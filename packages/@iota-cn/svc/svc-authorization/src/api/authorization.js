/**
 * Created by rain on 2017/2/28.
 */
import { uniqueArray, valBetween } from '@iota-cn/svc-util';

let create = async function (ctx, next) {
    const models = ctx.iota.dc.models;
    const authorization = ctx.request.body;
    const createBy = ctx.session.user.id;
    if (authorization && authorization.userGroupId && authorization.roleId && authorization.resourceGroupId) {
        //判断该资源是否已经分配至该用户
        let exitAuth = await models.Authorization.findOne({
            where: {
                userGroupId: authorization.userGroupId,
                resourceGroupId: authorization.resourceGroupId
            }
        });
        if (exitAuth) {
            ctx.status = 409;
            ctx.body = {
                name: 'duplicate authorization',
                message: 'this resource group already been assign to this user group.'
            };
            return;
        }
        authorization.createBy = createBy;
        let newAuth = await models.Authorization.create(authorization);
        ctx.status = 200;
        authorization.id = newAuth.id;
        authorization.createdAt = newAuth.createdAt;
        ctx.body = authorization;
    } else {
        ctx.status = 400;
        ctx.body = {
            name: 'validation error',
            message: 'invalid request message framing, malformed request syntax,or deceptive request routing.',
            detail: 'lack of necessary parameters.'
        };
    }
};

let findByUserGroup = async function (ctx, next) {
    const models = ctx.iota.dc.models;
    const createBy = ctx.session.user.id;
    const userGroupId = ctx.params.userGroupId;
    const id = ctx.params.id;
    const limit = valBetween(ctx.query.limit, 1, 200, 20);
    const offset = parseInt(ctx.query.offset) || 0;
    const orderBy = ctx.query.orderBy || 'createdAt';
    const orderDirection = ctx.query.orderDirection || 'DESC';
    let condition = {
        where: {
            createBy: createBy,
            userGroupId: userGroupId
        },
        limit: limit,
        offset: offset,
        distinct: true,
        order: [[orderBy, orderDirection]],
        include: [
            {
                model: models.UserGroup,
                as: 'userGroup'
            }, {
                model: models.ResourceGroup,
                as: 'resourceGroup'
            }, {
                model: models.Role,
                as: 'role'
            }
        ]
    };
    if (id) {
        condition.where.id = id;
    }
    let authWithResources = await models.Authorization.findAndCountAll(condition);
    ctx.status = 200;
    ctx.body = {
        count: authWithResources.count,
        authorizations: authWithResources.rows
    };

    //规范化返回
    if (ctx.iota.restful && typeof ctx.iota.restful.createNormalizer === 'function') {
        ctx.iota.restful.createNormalizer('authorizations')(ctx);
    }
};

let _delete = async function (ctx, next) {
    const id = ctx.params.id;
    let ids = ctx.query.ids ? ctx.query.ids.split(',') : [];
    let createBy = ctx.session.user.id;
    let invalidAuth = false;
    let models = ctx.iota.dc.models;
    if (id) {
        ids.push(id);
    }
    ids = uniqueArray(ids);
    if (ids.length > 0) {
        let count = await models.Authorization.count({
            where: {
                id: {
                    $in: ids
                },
                createBy: createBy
            }
        });
        if (count < ids.length) {
            invalidAuth = true;
        }
    } else {
        invalidAuth = true;
    }
    if (invalidAuth) {
        ctx.status = 404;
        ctx.body = {
            name: 'invalid authorization',
            message: `the authorization ${ids} dose not exist.`
        };
        return;
    }
    await models.Authorization.destroy({
        where: {
            id: { $in: ids }
        }
    });
    ctx.status = 204;
    ctx.body = {};
};

//let findUserGroupWithAuthorization = async (ctx, next)=> {
//
//};

export default {
    create,
    findByUserGroup,
    _delete,
    //findUserGroupWithAuthorization,
}