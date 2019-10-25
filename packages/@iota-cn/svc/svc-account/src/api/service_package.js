/**
 * Created by kadven on 2017/2/17.
 */

let find = async function (ctx, next) {
    const models = ctx.iota.dc.models;
    let sp_id = ctx.params.id;
    let orderBy = ctx.query.orderBy || 'price';
    let orderDirection = ctx.query.orderDirection || 'ASC';
    try {
        if (sp_id) {
            let service = await models.ServicePackage.findOne({
                where: {
                    id: sp_id
                }
            });
            service.specification = JSON.parse(service.specification);
            service.price = service.price / 100;
            ctx.status = 200;
            ctx.body = service;
        } else {
            let services = await models.ServicePackage.findAndCountAll({
                order: [[orderBy, orderDirection]]
            });
            services.rows.forEach(service => {
                service.price = service.price / 100;
                service.specification = JSON.parse(service.specification);
            })
            ctx.status = 200;
            ctx.body = {
                total: services.count,
                services: services.rows
            }
        }
    } catch (e) {
        ctx.status = 500;
        ctx.body = {
            name: 'Server error',
            message: 'An unexpected condition was encountered in the server and no more specific message is suitable.'
        };
        ctx.iota.logger.error(`path: ${ctx.path}, id:${sp_id}, error: ${e}`);
    }
}

export default {
    find
}