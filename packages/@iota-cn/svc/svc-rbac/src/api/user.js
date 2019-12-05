/**
 * 用户管理
 * 权限收窄原则
 *  仅限自己创建和子用户创建
 *  角色\组织仅限于自己、子用户创建及已经分配给自己的
 */
import * as Utils from './utils'
import moment from 'moment'

/**
 * 查找用户
 * @param {*} ctx 
 * @param {*} next 
 */
export const findUser = async (ctx, next) => {
    const user = ctx.session.user;
    const userId = ctx.session.user.id;
    const dc = ctx.iota.dc;
    const id = ctx.params.id;
    const models = ctx.iota.dc.models;
    const orderBy = ctx.query.order_by || 'createdAt';
    const orderDirection = ctx.query.order_direction || 'ASC';
    let users = [];
    if (user.isAdmin) {
        let condition = await Utils.buildAdminFilterUserQuery(dc, user)
        condition.order = [[orderBy, orderDirection]]
        if (id) {
            condition.where.$and.push({ id: id })
        }
        users = await models.User.findAll(condition);
    } else {
        users = await Utils.findChildrenOfAUser(user, models)
        if (id) {
            users = users.filter(u => u.id === id)
        }
        let convertor = undefined;
        if (orderBy === 'createdAt' || orderBy === 'updatedAt') {
            convertor = moment;
        }
        Utils.sort({users, orderBy, orderDirection, convertor});
    }
    ctx.status = 200;
    ctx.body = {
        users: users
    };
    //规范化返回
    if (ctx.iota.restful && typeof ctx.iota.restful.createNormalizer === 'function') {
        ctx.iota.restful.createNormalizer('users')(ctx);
    }
}

/**
 * middle ware for ctx.iota.user.afterCreate
 * @param ctx
 * @param next
 */
export const createHook = async function (ctx, next) {
    const parentId = ctx.session.user.id;
    const models = ctx.iota.dc.models;
    let user = ctx.body;
    if (user.type === models.User.UserTypes.Sub) {
        if (!parentId) {
            let err = new Error('Invalid parentId', 'ParentId is invalid.');
            err.status = 400;
            throw err;
        }
        let enable = true;
        if (user.subExt && user.subExt.enable !== undefined) {
            enable = user.subExt.enable
        }
        let subUser = await models.SubUser.create({
            parentId: parentId,
            active: true,
            dependent: true,
            userId: user.id,
            enable: enable
        }, { transaction: ctx.iota.session.transaction });
        if (subUser) {
            ctx.body.subExt = subUser;
        }
    }
    // call next middle ware
    await next()
};

/**
 *
 * @param ctx
 * @param next
 */
export const updateHook = async function (ctx, next) {
    const userId = ctx.params.id;
    if (typeof ctx.request.body.subExt === 'object') {
        await updateAll(ctx, [userId], ctx.request.body.subExt, ctx.iota.session.transaction);
    }
    //}
    // call next middle ware
    await next();
};


let updateAll = async function (ctx, ids, values, transaction) {
    const models = ctx.iota.dc.models;
    if (Array.isArray(ids) && ids.length > 0) {
        let condition = {
            where: { userId: { $in: ids } }
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

export const enable = async function (ctx, next) {
    const dc = ctx.iota.dc;
    const models = dc.models;
    const parentId = ctx.iota.user.id;
    const ids = ctx.request.body.ids ? ctx.request.body.ids : [];
    const id = ctx.params.id;
    if (id) {
        ids.push(id);
    }
    let isValid = await Utils.isChildrenUsers(dc, ctx.session.user, ids)
    if (isValid) {
        let count = await updateAll(ctx, ids, { enable: true });
        if (count === 0) {
            ctx.status = 404;
            ctx.body = {
                message: 'not found'
            }
        } else {
            ctx.status = 204;
        }
    } else {
        ctx.status = 403;
        ctx.body = {
            name: 'forbidden',
            message: `not a user of current user`
        }
    }
};

export const disable = async function (ctx, next) {
    const dc = ctx.iota.dc;
    const models = dc.models;
    const parentId = ctx.iota.user.id;
    const ids = ctx.request.body.ids ? ctx.request.body.ids : [];
    const id = ctx.params.id;
    if (id) {
        ids.push(id);
    }
    let isValid = await Utils.isChildrenUsers(dc, ctx.session.user, ids)
    if (isValid) {
        let count = await updateAll(ctx, ids, { enable: false });
        if (count === 0) {
            ctx.status = 404;
            ctx.body = {
                message: 'not found'
            }
        } else {
            ctx.status = 204;
        }
    } else {
        ctx.status = 403;
        ctx.body = {
            name: 'forbidden',
            message: `not a user of current user`
        }
    }
};
/**
 * 创建用户
 * @param {*} ctx 
 * @param {*} next 
 */
export const createUser = async (ctx, next) => {
    let user = ctx.iota.user;
    let newUser = ctx.request.body;
    if (!ctx.session.user.isAdmin && newUser.isAdmin) {
        ctx.status = 403;
        ctx.body = {
            name: 'forbidden',
            message: `not a user of current user`
        }
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
}

/**
 * 更新用户基本信息 
 * @param {*} ctx 
 * @param {*} next 
 */
export const updateUser = async (ctx, next) => {
    let user = ctx.iota.user;
    if (user && typeof user.update === 'function') {
        const dc = ctx.iota.dc;
        const models = dc.models;
        ctx.iota.session = ctx.iota.session || {};
        const userId = ctx.params.id;
        let newUser = ctx.request.body;
        let isValid = await Utils.isChildUser(dc, ctx.session.user, userId, newUser)
        if (isValid) {
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
            ctx.status = 403;
            ctx.body = {
                name: 'forbidden',
                message: `not a user of current user`
            }
        }
    } else {
        ctx.status = 500;
        ctx.body = {
            name: 'server error',
            message: 'Environment error, no suitable user module.'
        };
        ctx.iota.logger.error(`path: ${ctx.path}, body: ${JSON.stringify(ctx.request.body)}`);
    }
}

/**
 * 删除用户 
 * @param {*} ctx 
 * @param {*} next 
 */
export const deleteUser = async (ctx, next) => {
    //@TODO 修改为软删除,如果将来关联资源,先要判断资源是否有关联
    const user = ctx.session.user;
    const dc = ctx.iota.dc;
    const models = ctx.iota.dc.models;
    const userId = ctx.params.id;
    const isValid = await Utils.isChildUser(dc, user, userId)
    if (isValid) {
        await models.User.destroy({
            where: { id: userId }
        })
        ctx.status = 204;
        ctx.body = {}
    } else {
        ctx.status = 403;
        ctx.body = {
            name: 'forbidden',
            message: `not a user of current user`
        }
    }
}

//用户与角色关联
/**
 * 查询用户角色 
 * @param {*} ctx 
 * @param {*} next 
 */
export const findRoleAssignToUser = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    await Utils.findSourceAssignToUser(ctx, models.Role, 'role', 'roles', models.UserRole)
}

/**
 * 查询用户未分配角色 
 * @param {*} ctx 
 * @param {*} next 
 */
export const findRoleNotAssignToUser = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    await Utils.findSourceNotAssignToUser(ctx, models.Role, 'role', 'roleId', 'roles', models.UserRole)
}


/**
 * 绑定用户至用户 
 * @param {*} ctx 
 * @param {*} next 
 */
export const bindRoleToUser = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.bindAUserToSources(ctx, models.Role, models.UserRole, 'roleId')
}

/**
 * 解除用户与角色绑定 
 * @param {*} ctx 
 * @param {*} next 
 */
export const unbindRoleAndUser = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.unbindSourceFromAUser(ctx, models.Role, models.UserRole, 'roleId')
}

//组织与用户关联
/**
 * 查询用户组织 
 * @param {*} ctx 
 * @param {*} next 
 */
export const findOrgAssignToUser = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    await Utils.findSourceAssignToUser(ctx, models.Organization, 'organization', 'organizations', models.UserOrganization, false, false, true)
}

/**
 * 查询用户未绑定组织 
 * @param {*} ctx 
 * @param {*} next 
 */
export const findOrgNotAssignToUser = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    await Utils.findSourceNotAssignToUser(ctx, models.Organization, 'organization', 'organizationId', 'organizations', models.UserOrganization, false, false, true)
}

/**
 * 绑定用户至组织
 * @param {*} ctx 
 * @param {*} next 
 */
export const bindUserToOrg = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.bindAUserToSources(ctx, models.Organization, models.UserOrganization, 'organizationId', true, 'organization')
}

/**
 * 解除用户组织绑定 
 * @param {*} ctx 
 * @param {*} next 
 */
export const unbindUserAndOrg = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.unbindSourceFromAUser(ctx, models.Organization, models.UserOrganization, 'organizationId', true, 'organization')
}

//职位与用户关联
/**
 * 查询用户职位 
 * @param {*} ctx 
 * @param {*} next 
 */
export const findPositionAssignToUser = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    await Utils.findSourceAssignToUser(ctx, models.Position, 'position', 'positions', models.UserPosition, false, false, true)
}

/**
 * 查询用户未绑定职位 
 * @param {*} ctx 
 * @param {*} next 
 */
export const findPositionNotAssignToUser = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    await Utils.findSourceNotAssignToUser(ctx, models.Position, 'position', 'positionId', 'positions', models.UserPosition, false, false, true)
}


/**
 * 绑定用户至职位
 * @param {*} ctx 
 * @param {*} next 
 */
export const bindUserToPosition = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.bindAUserToSources(ctx, models.Position, models.UserPosition, 'positionId', true, 'position')
}

/**
 * 解除用户职位绑定 
 * @param {*} ctx 
 * @param {*} next 
 */
export const unbindUserAndPosition = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.unbindSourceFromAUser(ctx, models.Position, models.UserPosition, 'positionId', true, 'position')
}


export const findMenuOfUser = async (ctx, next) => {
    const user = ctx.session.user;
    const dc = ctx.iota.dc;
    const models = ctx.iota.dc.models;
    const orderBy = ctx.query.order_by || 'createdAt';
    const orderDirection = ctx.query.order_direction || 'ASC';
    const userId = ctx.params.userId;
    //check is children
    let isValid = await Utils.isChildUser(dc, user, userId)
    if (isValid) {
        let condition = Utils.buildRoleFilterQuery(dc, userId, models.RoleMenu, 'roleId');
        // condition.raw = true;
        // condition.order = [[orderBy, orderDirection]];
        let menus = await models.Menu.findAll(condition);
        menus = menus.map(m => {
            let tm = m.get({ plain: true })
            tm.assigned = true;
            return tm;
        })
        menus = await Utils.fillAllParents(menus, models.Menu);
        let convertor = undefined;
        if (orderBy === 'createdAt' || orderBy === 'updatedAt') {
            convertor = moment;
        }
        Utils.sort({menus, orderBy, orderDirection, convertor});
        ctx.status = 200;
        ctx.body = {
            menus: menus
        };
    } else {
        ctx.status = 403;
        ctx.body = {
            name: 'forbidden',
            message: 'not a child of current user or user self.'
        }
    }
}

export const findOperationOfUser = async (ctx, next) => {
    const user = ctx.session.user;
    const dc = ctx.iota.dc;
    const models = ctx.iota.dc.models;
    const orderBy = ctx.query.order_by || 'createdAt';
    const orderDirection = ctx.query.order_direction || 'ASC';
    const userId = ctx.params.userId;
    //check is children
    let isValid = await Utils.isChildUser(dc, user, userId);
    if (isValid) {
        let condition = Utils.buildRoleFilterQuery(dc, userId, models.RoleOperation, 'roleId');
        // condition.raw = true;
        // condition.order = [[orderBy, orderDirection]];
        let operations = await models.Operation.findAll(condition);
        operations = operations.map(o => {
            let to = o.get({ plain: true })
            to.assigned = true;
            return to;
        })
        operations = await Utils.fillAllParents(operations, models.Operation);
        let convertor = undefined;
        if (orderBy === 'createdAt' || orderBy === 'updatedAt') {
            convertor = moment;
        }
        Utils.sort({operations, orderBy, orderDirection, convertor});
        ctx.status = 200;
        ctx.body = {
            operations: operations
        };
    } else {
        ctx.status = 403;
        ctx.body = {
            name: 'forbidden',
            message: 'not a child or current user'
        }
    }
}

export const findUserExtention = async function (ctx, next) {
    const dc = ctx.iota.dc;
    const id = ctx.params.id;
    let isValid = await Utils.isChildrenUsers(dc, ctx.session.user, [id])
    if (isValid) {
        ctx.params.userId = id;
        await ctx.iota.user.findUserExtention(ctx, next)
    } else {
        ctx.status = 403;
        ctx.body = {
            name: 'forbidden',
            message: `not a user of current user`
        }
    }
}

export const updateUserExtention = async function (ctx, next) {
    const dc = ctx.iota.dc;
    const id = ctx.params.id;
    let isValid = await Utils.isChildrenUsers(dc, ctx.session.user, [id])
    if (isValid) {
        ctx.params.userId = id;
        await ctx.iota.user.updateOrCreateUserExtention(ctx, next)
    } else {
        ctx.status = 403;
        ctx.body = {
            name: 'forbidden',
            message: `not a user of current user`
        }
    }
}