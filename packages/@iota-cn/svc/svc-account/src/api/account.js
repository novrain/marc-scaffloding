const excludes = ['createdAt', 'updatedAt'];
let createHook = async function (ctx, next) {
    const models = ctx.iota.dc.models;
    let user = ctx.body;
    let account = await models.Account.create({
        balance: 0,
        userId: user.id
    }, { transaction: ctx.iota.session.transaction });
    if (account) {
        ctx.body.account = {
            id: account.id,
            accountName: user.username,
            balance: account.balance
        }
    }
    // call next middle ware
    await next();
};

let find = async function (ctx, next) {
    let account;
    let models = ctx.iota.dc.models;
    account = await models.Account.findOne({
        attributes: { exclude: excludes },
        include: [
            {
                model: models.User,
                as: 'user',
                where: { id: ctx.session.user.id }
            }
        ]
    });
    let accountInfo;
    let totalFee = 0;
    let orders = await models.Order.findAll({
        where: { accountId: account.id, paymentState: 'prepaid' }
    });
    for (let i = 0; i < orders.length; i++) {
        totalFee += orders[i].fee
    }
    let serviceInfo = await models.AccountServicePackage.findOne({
        where: {
            accountId: account.id
        },
        include: [
            { model: models.ServicePackage, as: 'servicePackage' },
        ],
        attributes: { exclude: excludes }
    });
    if (serviceInfo) {
        serviceInfo = serviceInfo.get({ plain: true });
        serviceInfo.specification = JSON.parse(serviceInfo.specification);
        serviceInfo.initialSpecification = JSON.parse(serviceInfo.initialSpecification);
        serviceInfo.price = serviceInfo.price / 100;
        //@TODO endTime 过期
        if (serviceInfo.endTime && serviceInfo.endTime < new Date()) {
            serviceInfo.expired = true;
        }
    }
    account.balance = account.balance / 100;
    accountInfo = {
        id: account.id,
        accountName: account.user.username,
        balance: account.balance,
        totalFee: totalFee / 100,
        serviceInfo: serviceInfo
    };
    ctx.status = 200;
    ctx.body = accountInfo;
};

let changeBalance = async function (ctx, next) {
    let data = ctx.iota.session.paramsObj;
    let models = ctx.iota.dc.models;
    let now_balance;
    switch (data.operate_type) {
        case 'increase':
            now_balance = data.balance + data.recharge_fee;
            await models.Account.update(
                { balance: now_balance },
                { where: { id: data.account_id }, transaction: ctx.iota.session.transaction }
            );
            break;
        case 'reduce':
            if (data.balance - data.order_fee >= 0) {
                now_balance = data.balance - data.order_fee;
                await models.Account.update(
                    { balance: now_balance },
                    { where: { id: data.account_id }, transaction: ctx.iota.session.transaction }
                );
            } else {
                throw new Error('insufficient balance');
            }
            break;
        default:
            throw new Error('unknown operation type');
            break;
    }
};

export default {
    createHook,
    find,
    changeBalance
}