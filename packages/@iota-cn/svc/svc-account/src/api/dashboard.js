export default class Dashboard {
    async find(ctx, next) {
        let userId = ctx.session.user.id;
        let id = ctx.params.id;
        let models = ctx.iota.dc.models;
        try {
            if (id) {
                let dashboard = await models.Dashboard.findOne({
                    where: { id: id },
                    order: [['createdAt', 'DESC']]
                });
                dashboard.option = dashboard.option ? JSON.parse(dashboard.option) : {}
                dashboard.source = dashboard.source ? JSON.parse(dashboard.source) : {}
                ctx.status = 200;
                ctx.body = dashboard
            } else {
                let dashboards = await models.Dashboard.findAndCountAll({ where: { userId: userId } });
                dashboards.rows = dashboards.rows.map(function (d, i) {
                    d.option = d.option ? JSON.parse(d.option) : d.option;
                    d.source = d.source ? JSON.parse(d.source) : d.source;
                    return d;
                })
                ctx.status = 200;
                ctx.body = {
                    total: dashboards.count,
                    dashboards: dashboards.rows
                }
            }
        } catch (e) {
            ctx.status = 500;
            ctx.body = {
                name: 'create error',
                message: 'An unexpected condition was encountered in the server and no more specific message is suitable.'
            }
        }
    }
    async create(ctx, next) {
        let userId = ctx.session.user.id;
        let body = ctx.request.body;
        let models = ctx.iota.dc.models;
        try {
            delete body.id;
            body.userId = userId;
            body.option = JSON.stringify(body.option);
            body.source = JSON.stringify(body.source);
            let newDashboard = await models.Dashboard.create(body);
            newDashboard.option = newDashboard.option ? JSON.parse(newDashboard.option) : {}
            newDashboard.source = newDashboard.source ? JSON.parse(newDashboard.source) : {}
            ctx.status = 200;
            ctx.body = newDashboard;
        } catch (e) {
            ctx.status = 500;
            ctx.body = {
                name: 'create error',
                message: 'An unexpected condition was encountered in the server and no more specific message is suitable.'
            }
        }
    }
    async update(ctx, next) {
        let id = ctx.params.id;
        let models = ctx.iota.dc.models;
        let body = ctx.request.body;
        try {
            delete body.id;
            delete body.userId;
            body.option = JSON.stringify(body.option);
            body.source = JSON.stringify(body.source);
            await models.Dashboard.update(body, { where: { id: id } });
            ctx.status = 204;
            ctx.body = {};
        } catch (e) {
            ctx.status = 500;
            ctx.body = {
                name: 'create error',
                message: 'An unexpected condition was encountered in the server and no more specific message is suitable.'
            }
        }
    }
    async delete(ctx, next) {
        let id = ctx.params.id;
        let models = ctx.iota.dc.models;
        try {
            let result = await models.Dashboard.destroy({ where: { id: id + '' } });
            if (result === 1) {
                ctx.status = 204;
                ctx.body = {};
            } else {
                ctx.status = 404;
                ctx.body = {
                    name: 'not found',
                    message: `could not find this interface`
                }
            }
        } catch (e) {
            ctx.status = 500;
            ctx.body = {
                name: 'create error',
                message: 'An unexpected condition was encountered in the server and no more specific message is suitable.'
            }
        }
    }
}