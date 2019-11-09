/**
 * Created by kadve on 2016/11/8.
 */
import { valBetween } from '@iota-cn/svc-util';

async function find(ctx, next) {
    const limit = valBetween(ctx.query.limit, 1, 200, 20);
    const offset = parseInt(ctx.query.offset) || 0;
    const appName = ctx.query.appname;
    const platform = ctx.query.platform;
    const orderBy = ctx.query.orderBy || 'createdAt';
    const id = ctx.params.id;
    let condition = {
        where: {},
        limit: limit,
        offset: offset,
        order: [[orderBy]]
    }
    condition.where.userId = ctx.session.user.id;
    if (appName !== undefined) {
        condition.where.name = { $iLike: `%${appName}%` }
    }
    if (platform) {
        let platforms = platform.split(',');
        if (platforms.length > 0) {
            condition.where.platform = { $in: platforms };
        }
        //condition.where.platform = platform;
    }
    if (id) {
        condition.where.id = id;
    }
    let applications = await ctx.iota.dc.models.UserApp.findAndCountAll(condition);
    ctx.status = 200;
    ctx.body = {
        count: applications.count,
        applications: applications.rows
    }
    if (ctx.iota.restful && typeof ctx.iota.restful.createNormalizer === 'function') {
        ctx.iota.restful.createNormalizer('applications')(ctx);
    }
}

async function create(ctx, next) {
    let data = ctx.request.body;
    let userId = ctx.session.user.id;
    let models = ctx.iota.dc.models;
    let count = await models.UserApp.count({
        where: {
            userId: userId
        }
    });
    if (count >= 20) {
        ctx.status = 403;
        ctx.body = {
            name: 'forbidden',
            message: 'no enough quota'
        };
        return;
    }
    if (data && data.name && data.platform) {
        let newUserApp = await models.UserApp.create({
            userId: userId,
            name: data.name,
            platform: data.platform
        });
        ctx.status = 200;
        ctx.body = newUserApp;
    } else {
        ctx.status = 400;
        ctx.body = {
            name: 'validation error',
            message: 'invalid request message framing, malformed request syntax,or deceptive request routing.',
            detail: 'lack of necessary parameters.'
        };
    }
}

async function _delete(ctx, next) {
    const id = ctx.params.id;
    const models = ctx.iota.dc.models;
    let count = await models.UserApp.destroy({ where: { id: id } });
    if (count === 0) {
        ctx.status = 404;
        ctx.body = {
            name: 'invalid application',
            message: `the application ${id} dose not exist.`
        };
    } else {
        ctx.status = 200;
    }
}
export {
    find,
    create,
    _delete
}