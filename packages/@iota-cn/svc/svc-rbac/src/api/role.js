/**
 * 角色管理
 * 权限收窄原则
 *  仅限自己创建和子用户创建
 *  menu, operation限于自己所拥有的范围
 */
import * as Utils from './utils'
import moment from 'moment'
import { Validator } from '@iota-cn/util-validation'
/**
 * 查找角色
 * @param {*} ctx 
 * @param {*} next 
 */
export const findRole = async (ctx, next) => {
    const user = ctx.session.user;
    const userId = ctx.session.user.id;
    const dc = ctx.iota.dc;
    const models = ctx.iota.dc.models;
    const orderBy = ctx.query.order_by || 'createdAt';
    const orderDirection = ctx.query.order_direction || 'DESC'
    let roles = await Utils.findRsByUser(user, models.Role, models, false)
    let convertor = undefined;
    if (orderBy === 'createdAt' || orderBy === 'updatedAt') {
        convertor = moment;
    }
    Utils.sort({ rows: roles, orderBy, orderDirection, convertor });
    ctx.status = 200;
    ctx.body = {
        roles: roles
    };
}

/**
 * 创建角色
 * @param {*} ctx 
 * @param {*} next 
 */
export const createRole = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.createSource(ctx, {
        model: models.Role,
    })
}

/**
 * 更新角色基本信息 
 * @param {*} ctx 
 * @param {*} next 
 */
export const updateRole = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.updateSource(ctx, { model: models.Role })
}

/**
 * 删除角色 
 * @param {*} ctx 
 * @param {*} next 
 */
export const deleteRole = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.deleteSource(ctx, { model: models.Role })
}

/**
 * 查询角色的操作
 * @param {*} ctx 
 * @param {*} next 
 */
export const findMenuOfRole = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.findSourceBelongToRole(ctx, models.Menu, models.RoleMenu, 'menus')
}

/**
 * 查询角色的菜单
 * @param {*} ctx 
 * @param {*} next 
 */
export const findOperationOfRole = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.findSourceBelongToRole(ctx, models.Operation, models.RoleOperation, 'operations')
}

/**
 * 添加菜单至角色 
 * @param {*} ctx 
 * @param {*} next 
 */
export const assignMenuToRole = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.assignSourceToRole(ctx, models.Menu, models.RoleMenu, 'menuId')
}

/**
 * 添加操作至角色 
 * @param {*} ctx 
 * @param {*} next 
 */
export const assignOperationToRole = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.assignSourceToRole(ctx, models.Operation, models.RoleOperation, 'operationId')
}

/**
 * 从角色删除菜单
 * @param {*} ctx 
 * @param {*} next 
 */
export const removeMenuFromRole = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.removeSourceFromRole(ctx, models.Menu, models.RoleMenu, 'menuId')
}

/**
 * 从角色删除操作 
 * @param {*} ctx 
 * @param {*} next 
 */
export const removeOperationFromRole = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.removeSourceFromRole(ctx, models.Operation, models.RoleOperation, 'operationId')
}

//用户与角色关联
/**
 * 查询角色用户 
 * @param {*} ctx 
 * @param {*} next 
 */
export const findUserBindToRole = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    await Utils.findUserIn(ctx, models.UserRole, models.Role, 'role', 'roleId');
}

/**
 * 查询未绑定角色用户 
 * @param {*} ctx 
 * @param {*} next 
 */
export const findUserNotBindToRole = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    await Utils.findUserNotIn(ctx, models.UserRole, models.Role, 'role', 'roleId');
}

/**
 * 绑定角色至用户 
 * @param {*} ctx 
 * @param {*} next 
 */
export const bindRoleToUser = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    await Utils.bindASourceToUsers(ctx, models.Role, 'roleId', models.UserRole, 'roleId');
}

/**
 * 解除角色用户绑定 
 * @param {*} ctx 
 * @param {*} next 
 */
export const unbindRoleAndUser = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    await Utils.unbindASourceToUsers(ctx, models.Role, 'roleId', models.UserRole, 'roleId');
}

//组织与角色关联
/**
 * 查询角色组织 
 * @param {*} ctx 
 * @param {*} next 
 */
export const findOrgBindToRole = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    await Utils.findSourceIn(ctx, models.Organization, 'organization', 'organizations', models.OrganizationRole, models.Role, 'role', 'roleId', false, true)
}

/**
 * 查询角色未绑定的组织 
 * @param {*} ctx 
 * @param {*} next 
 */
export const findOrgNotBindToRole = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    await Utils.findSourceNotIn(ctx, models.Organization, 'organization', 'organizationId', 'organizations', models.OrganizationRole, models.Role, 'role', 'roleId', false)
}

/**
 * 绑定角色至组织
 * @param {*} ctx 
 * @param {*} next 
 */
export const bindRoleToOrg = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.bindSourceTo(ctx, models.Organization, models.OrganizationRole, 'organizationId', models.Role, 'roleId')
}

/**
 * 解除角色组织绑定 
 * @param {*} ctx 
 * @param {*} next 
 */
export const unbindRoleAndOrg = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.unbindSourceFrom(ctx, models.Organization, models.OrganizationRole, 'organizationId', models.Role, 'roleId')
}

//职位与角色关联
/**
 * 查询角色绑定的职位 
 * @param {*} ctx 
 * @param {*} next 
 */
export const findPositionBindToRole = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    await Utils.findSourceIn(ctx, models.Position, 'position', 'positions', models.PositionRole, models.Role, 'role', 'roleId', false, true)
}

/**
 * 查询角色未绑定职位
 * @param {*} ctx 
 * @param {*} next 
 */
export const findPositionNotBindToRole = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    await Utils.findSourceNotIn(ctx, models.Position, 'position', 'positionId', 'positions', models.PositionRole, models.Role, 'role', 'roleId', false)
}

/**
 * 绑定角色至职位
 * @param {*} ctx 
 * @param {*} next 
 */
export const bindRoleToPosition = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.bindSourceTo(ctx, models.Position, models.PositionRole, 'positionId', models.Role, 'roleId')
}

/**
 * 解除角色职位绑定 
 * @param {*} ctx 
 * @param {*} next 
 */
export const unbindRoleAndPosition = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.unbindSourceFrom(ctx, models.Position, models.PositionRole, 'positionId', models.Role, 'roleId')
}

/**
 * 查询用户自己所关联的角色
 * @param {*} ctx 
 * @param {*} next 
 */
export const findRolesAssignToSelf = async (ctx, next) => {
    const user = ctx.session.user;
    const models = ctx.iota.dc.models;
    const orderBy = ctx.query.order_by || 'createdAt';
    const orderDirection = ctx.query.order_direction || 'DESC';
    let roles = await Utils.findAssignedByUser(user, models.Role, models.UserRole, 'userMembers')
    let convertor = undefined;
    if (orderBy === 'createdAt' || orderBy === 'updatedAt') {
        convertor = moment;
    }
    Utils.sort({ rows: roles, orderBy, orderDirection, convertor });
    ctx.status = 200;
    ctx.body = {
        roles: roles
    };
}