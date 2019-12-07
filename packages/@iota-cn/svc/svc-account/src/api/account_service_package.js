import { changeBalance } from './index';

let createDefaultServiceHook = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    let account = ctx.body.account;
    if (account) {
        let freeService = await models.ServicePackage.findOne({
            where: { serviceType: models.ServicePackage.ServiceType.Free }
        });
        if (freeService) {
            if (ctx.body.type === 'Sub') {//子用户配额修改为0
                let specification = JSON.parse(freeService.specification);
                for (let r in specification.resources) {
                    specification.resources[r].quota = 0;
                }
                freeService.specification = JSON.stringify(specification);
            }
            await models.AccountServicePackage.create({
                accountId: account.id,
                name: freeService.name,
                price: freeService.price, // 0
                specification: freeService.specification,
                initialSpecification: freeService.specification,
                servicePackageId: freeService.id
            }, { transaction: ctx.iota.session.transaction });
        }
    }
    // call next middle ware
    await next();
};

let find = async function (ctx, next) {
    let userId;
    let models = ctx.iota.dc.models;
    userId = ctx.session.user.id;

    let account = await models.Account.findOne({
        include: [{ model: models.AccountServicePackage, as: 'service' }],
        where: { userId: userId }
    });
    account.balance = account.balance / 100;
    account.service.price = account.service.price / 100;
    account.service.specification = JSON.parse(account.service.specification);
    account.service.initialSpecification = JSON.parse(account.service.initialSpecification);
    ctx.status = 200;
    ctx.body = account;
}

let create = async function (ctx, next) {
    let out_trade_no = ctx.iota.session.out_trade_no;
    let models = ctx.iota.dc.models;
    let order;
    try {
        order = await models.Order.findOne({
            where: { out_trade_no: out_trade_no }
        });
        let servicePackage = await models.ServicePackage.findOne({
            where: { id: order.servicePackageId }
        });
        let beginTime = new Date();
        let endTime = new Date(beginTime);
        endTime.setFullYear(endTime.getFullYear() + 1);
        endTime.setDate(endTime.getDate() - 1);
        let dataObj = {
            name: servicePackage.name,
            price: servicePackage.price,
            beginTime: beginTime,
            endTime: endTime,
            specification: servicePackage.specification,
            initialSpecification: servicePackage.specification,
            accountId: order.accountId,
            servicePackageId: servicePackage.id
        };
        //更新或者新建
        let asp = await models.AccountServicePackage.findOne({ where: { accountId: order.accountId } });
        if (asp) {
            let oldSpecification = JSON.parse(asp.specification);
            let oldInitSpecification = JSON.parse(asp.initialSpecification);
            let newSpecification = JSON.parse(servicePackage.specification)
            //约定好的规范 后期添加配额都遵循现有的json对象格式
            let keys = Object.keys(newSpecification['resources']);
            keys.forEach(s => {
                if (oldSpecification['resources'].hasOwnProperty(s)) {
                    //新购服务，扣除已用服务
                    newSpecification['resources'][s]['quota'] =
                        newSpecification['resources'][s]['quota'] - (oldInitSpecification['resources'][s]['quota'] - oldSpecification['resources'][s]['quota']);
                }
            });
            dataObj.specification = JSON.stringify(newSpecification);
            await models.AccountServicePackage.update(dataObj, {
                where: { id: asp.id },
                transaction: ctx.iota.session.transaction
            });
            dataObj.id = asp.id;
            return dataObj;
        } else {
            return await models.AccountServicePackage.create(dataObj, {
                transaction: ctx.iota.session.transaction
            });
        }
    } catch (e) {
        ctx.status = 500;
        ctx.body = {
            name: 'server error',
            message: 'an unexpected condition was encountered in the server and no more specific message is suitable.'
        };
        ctx.iota.logger.error(`path: ${ctx.path}, error: ${e}`, e.stack);
    }
}

export default {
    find,
    create,
    createDefaultServiceHook
}