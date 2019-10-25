/**
 * Created by rain on 2017/2/16.
 */
import { valBetween } from '@iota-cn/svc-util';

/**
 * 创建一个检查当前用户的中间件
 * @param fn
 * @returns {boolean}
 */
let checkCurrentUser = function (fn) {
    return async (ctx, next) => {
        //获取当前帐号
        let currentUser = ctx.session.user;
        //判断是否匹配
        if (currentUser.id !== ctx.params.parentId) {
            ctx.status = 400;
            ctx.body = {
                name: 'Invalid parent id.',
                message: 'Cannot operate sub user of other user.'
            };
        } else {
            await fn(ctx, next);
        }
    }
};

/**
 * middle ware for ctx.iota.user.afterCreate
 * @param ctx
 * @param next
 */
let createHook = async function (ctx, next) {
    const parentId = ctx.params.parentId;
    const models = ctx.iota.dc.models;
    let user = ctx.body;
    if (user.type === models.User.UserTypes.Sub) {
        if (!parentId) {
            let err = new Error('Invalid parentId', 'ParentId is invalid.');
            err.status = 400;
            throw err;
        }
        let subUser = await models.SubUser.create({
            parentId: parentId,
            active: true,
            dependent: true,
            userId: user.id
        }, { transaction: ctx.iota.session.transaction });
        if (subUser) {
            ctx.body.subExt = subUser;
        }
    }
    // call next middle ware
    await next();
};


/**
 *
 * @param ctx
 * @param next
 */
let createApi = checkCurrentUser(async function (ctx, next) {
    //调用ctx.iota.user.create
    let user = ctx.iota.user;
    const models = ctx.iota.dc.models;
    let currentUser = ctx.session.user;
    if (currentUser.type === 'Sub') {
        ctx.status = 403;
        ctx.body = {
            name: 'forbidden',
            message: '.'
        };
        return;
    }
    let rs = await models.SubUser.findAndCountAll({ where: { parentId: currentUser.id } })
    if (rs.count >= 20) {
        ctx.status = 403;
        ctx.body = {
            name: 'forbidden',
            message: '.'
        };
        return;
    }
    if (user && typeof user.create === 'function') {
        try {
            ctx.request.body.type = 'Sub';
            await user.create(ctx);
        }
        catch (err) {
            ctx.status = 500;
            ctx.body = {
                name: 'server error',
                message: 'an unexpected condition was encountered in the server and no more specific message is suitable.'
            };
            ctx.iota.logger.error(`path: ${ctx.path}, body: ${JSON.stringify(ctx.request.body)}, error: ${err}`);
        }
    } else {
        ctx.status = 500;
        ctx.body = {
            name: 'server error',
            message: 'Environment error, no suitable user module.'
        };
        ctx.iota.logger.error(`path: ${ctx.path}, body: ${JSON.stringify(ctx.request.body)}`);
    }
});

let find = async function (ctx, next) {
    const models = ctx.iota.dc.models;
    const parentId = ctx.params.parentId;
    const limit = valBetween(ctx.query.limit, 1, 200, 20);
    const offset = parseInt(ctx.query.offset) || 0;
    const orderBy = ctx.query.orderBy || 'createdAt';
    const orderDirection = ctx.query.orderDirection || 'DESC';
    const id = ctx.params.id;
    let condition = {
        include: [
            {
                model: models.SubUser,
                as: "subExt",
                where: { parentId: parentId },
            }
        ],
        attributes: ['id', 'username', 'email', 'mobile'],
        limit: limit,
        offset: offset,
        distinct: true,
        order: [[orderBy, orderDirection]]
    };
    if (id) {
        condition.where = { id: id };
    }
    let users = await models.User.findAndCountAll(condition);
    ctx.status = 200;
    ctx.body = {
        count: users.count,
        users: users.rows
    };
    //规范化返回
    if (ctx.iota.restful && typeof ctx.iota.restful.createNormalizer === 'function') {
        ctx.iota.restful.createNormalizer('users')(ctx);
    }
};

let updateAll = async function (ctx, ids, parentId, values, transaction) {
    const models = ctx.iota.dc.models;
    if (Array.isArray(ids)) {
        let condition = {
            where: { userId: { $in: ids }, parentId: parentId }
        };
        if (transaction) {
            condition.transaction = transaction;
        }
        let result = await models.SubUser.update(values, condition);
        return result[0];
    }
    else {
        return 0;
    }
};

let enable = checkCurrentUser(async function (ctx, next) {
    const parentId = ctx.params.parentId;
    const ids = ctx.request.body.ids;
    let count = await updateAll(ctx, ids, parentId, { enable: true });
    if (count === 0) {
        ctx.status = 404;
        ctx.body = {
            message: 'not found'
        }
    } else {
        ctx.status = 204;
    }
});

let disable = checkCurrentUser(async function (ctx, next) {
    const parentId = ctx.params.parentId;
    const ids = ctx.request.body.ids;
    let count = await updateAll(ctx, ids, parentId, { enable: false });
    if (count === 0) {
        ctx.status = 404;
        ctx.body = {
            message: 'not found'
        }
    } else {
        ctx.status = 204;
    }
});

let makeDependent = checkCurrentUser(async function (ctx, next) {
    const parentId = ctx.params.parentId;
    const ids = ctx.request.body.ids;
    let count = await updateAll(ctx, ids, parentId, { dependent: true });
    if (count === 0) {
        ctx.status = 404;
        ctx.body = {
            message: 'not found'
        }
    } else {
        ctx.status = 204;
    }
});

let makeIndependent = checkCurrentUser(async function (ctx, next) {
    const parentId = ctx.params.parentId;
    const ids = ctx.request.body.ids;
    let count = await updateAll(ctx, ids, parentId, { dependent: false });
    if (count === 0) {
        ctx.status = 404;
        ctx.body = {
            message: 'not found'
        }
    } else {
        ctx.status = 204;
    }
});

/**
 *
 * @param ctx
 * @param next
 */
let updateHook = async function (ctx, next) {
    const parentId = ctx.params.parentId;
    const userId = ctx.params.id;
    //if (user.type === models.User.UserTypes.Sub) {
    if (!parentId) {
        let err = new Error('Invalid parentId', 'ParentId is invalid.');
        err.status = 400;
        throw err;
    }
    if (typeof ctx.request.body.subExt === 'object') {
        await updateAll(ctx, [userId], parentId, ctx.request.body.subExt, ctx.iota.session.transaction);
    }
    //}
    // call next middle ware
    await next();
};

let updateApi = checkCurrentUser(async function (ctx, next) {
    let user = ctx.iota.user;
    if (user && typeof user.update === 'function') {
        const dc = ctx.iota.dc;
        ctx.iota.session = ctx.iota.session || {};
        let t = await dc.orm.transaction();
        ctx.iota.session.transaction = t;
        try {
            ctx.request.body.id = ctx.params.id;
            await user.update(ctx);
            if (ctx.status === 204)
                await t.commit();
            else {
                await t.rollback();
            }
        }
        catch (err) {
            await t.rollback();
            ctx.status = 500;
            ctx.body = {
                name: 'server error',
                message: 'an unexpected condition was encountered in the server and no more specific message is suitable.'
            };
            ctx.iota.logger.error(`path: ${ctx.path}, body: ${JSON.stringify(ctx.request.body)}, error: ${err}`);
        }
    } else {
        ctx.status = 500;
        ctx.body = {
            name: 'server error',
            message: 'Environment error, no suitable user module.'
        };
        ctx.iota.logger.error(`path: ${ctx.path}, body: ${JSON.stringify(ctx.request.body)}`);
    }
});

export default {
    createHook,
    createApi,
    find,
    enable,
    disable,
    makeDependent,
    makeIndependent,
    updateHook,
    updateApi
}