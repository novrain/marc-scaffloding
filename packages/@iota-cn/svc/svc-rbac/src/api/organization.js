/**
 * 可操作自己或子用户创建的组织
 * 关联关系：
 *  角色/用户，只能操作自己或子用户创建的关联关系
 */
import * as Utils from './utils'
import moment from 'moment'
import { valBetween, uniqueArray } from '@iota-cn/svc-util'
import { Validator } from '@iota-cn/util-validation';


/**
 * 查询组织
 * 自身关联以及自己、自用户创建的
 *
 * @param {*} ctx
 * @param {*} next
 */
export const findOrg = async (ctx, next) => {
    const user = ctx.session.user;
    const userId = ctx.session.user.id;
    const dc = ctx.iota.dc;
    const models = ctx.iota.dc.models;
    const orderBy = ctx.query.order_by || 'createdAt';
    const orderDirection = ctx.query.order_direction || 'DESC';
    let organizations = await Utils.findRsByUser(user, models.Organization, models, true, undefined, true, 'organization', models.UserOrganization)
    let convertor = undefined;
    if (orderBy === 'createdAt' || orderBy === 'updatedAt') {
        convertor = moment;
    }
    Utils.sort({ rows: organizations, orderBy, orderDirection, convertor });
    ctx.status = 200;
    ctx.body = {
        organizations: organizations
    };
}

/**
 * 创建组织 
 * @param {*} ctx 
 * @param {*} next 
 */
export const createOrg = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.createSource(ctx, {
        model: models.Organization,
        isHierarchical: true,
        through: models.UserOrganization,
        throughId: 'organizationId'
    })
}

/**
 * 更新组织 
 * @param {*} ctx 
 * @param {*} next 
 */
export const updateOrg = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.updateSource(ctx, { model: models.Organization })
}

/**
 * 删除组织 
 * @param {*} ctx 
 * @param {*} next 
 */
export const deleteOrg = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.deleteSource(ctx, { model: models.Organization })
}

/**
 * 列举组织的用户
 * @param {*} ctx 
 * @param {*} next 
 */
export const findUserInOrg = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    await Utils.findUserIn(ctx, models.UserOrganization, models.Organization, 'organization', 'organizationId', true);
}

/**
 * 列举不在组织的用户
 * @param {*} ctx 
 * @param {*} next 
 */
export const findUserNotInOrg = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    await Utils.findUserNotIn(ctx, models.UserOrganization, models.Organization, 'organization', 'organizationId', true);
}

/**
 * 列举组织的角色
 * @param {*} ctx 
 * @param {*} next 
 */
export const findRoleAssignToOrg = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    await Utils.findSourceIn(ctx, models.Role, 'role', 'roles', models.OrganizationRole, models.Organization, 'organization', 'organizationId')
}

/**
 * 列举组织的未绑定的角色
 * @param {*} ctx 
 * @param {*} next 
 */
export const findRoleNotAssignToOrg = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    await Utils.findSourceNotIn(ctx, models.Role, 'role', 'roleId', 'roles', models.OrganizationRole, models.Organization, 'organization', 'organizationId')
}

/**
 * 给组织增加角色
 * @param {*} ctx
 * @param {*} next
 */
export const assignRoleToOrg = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.bindSourceTo(ctx, models.Role, models.OrganizationRole, 'roleId', models.Organization, 'organizationId')
}

/**
 * 从组织删除角色
 * @param {*} ctx 
 * @param {*} next 
 */
export const removeRoleFromOrg = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.unbindSourceFrom(ctx, models.Role, models.OrganizationRole, 'roleId', models.Organization, 'organizationId')
}

/**
 * 给组织增加用户
 * 
 * @param {*} ctx 
 * @param {*} next 
 */
export const addUserToOrg = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    await Utils.bindASourceToUsers(ctx, models.Organization, 'organizationId', models.UserOrganization, 'organizationId', true, 'organization');
}

/**
 * 删除组织的用户
 * @param {*} ctx 
 * @param {*} next 
 */
export const removeUseFromOrg = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    await Utils.unbindASourceToUsers(ctx, models.Organization, 'organizationId', models.UserOrganization, 'organizationId', true, 'organization');
}

/**
 * 查询用户自己所关联的组织
 * @param {*} ctx 
 * @param {*} next 
 */
export const findOrganizationsAssignToSelf = async (ctx, next) => {
    const user = ctx.session.user;
    const models = ctx.iota.dc.models;
    const orderBy = ctx.query.order_by || 'createdAt';
    const orderDirection = ctx.query.order_direction || 'DESC';
    let organizations = await Utils.findAssignedByUser(user, models.Organization, models.UserOrganization, 'members')
    let convertor = undefined;
    if (orderBy === 'createdAt' || orderBy === 'updatedAt') {
        convertor = moment;
    }
    Utils.sort({ rows: organizations, orderBy, orderDirection, convertor });
    ctx.status = 200;
    ctx.body = {
        organizations: organizations
    };
}
