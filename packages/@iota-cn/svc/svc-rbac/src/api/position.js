/**
 * 可操作自己或子用户创建的职位
 * 关联关系：
 *  角色/用户，只能操作自己或子用户创建的关联关系
 */
import * as Utils from './utils'
import moment from 'moment'
import { valBetween } from '@iota-cn/svc-util'
import { Validator } from '@iota-cn/util-validation'
/**
 * 查询职位
 *
 * @param {*} ctx
 * @param {*} next
 */
export const findPosition = async (ctx, next) => {
    const user = ctx.session.user;
    const userId = ctx.session.user.id;
    const dc = ctx.iota.dc;
    const models = ctx.iota.dc.models;
    const orderBy = ctx.query.order_by || 'createdAt';
    const orderDirection = ctx.query.order_direction || 'DESC';
    let positions = await Utils.findRsByUser(user, models.Position, models, true, undefined, true, 'position', models.UserPosition)
    let convertor = undefined;
    if (orderBy === 'createdAt' || orderBy === 'updatedAt') {
        convertor = moment;
    }
    Utils.sort(positions, orderBy, orderDirection, convertor);
    ctx.status = 200;
    ctx.body = {
        positions: positions
    };
}

/**
 * 创建职位 
 * @param {*} ctx 
 * @param {*} next 
 */
export const createPosition = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.createSource(ctx, {
        model: models.Position,
        isHierarchical: true,
        through: models.UserPosition,
        throughId: 'positionId'
    })
}

/**
 * 更新职位
 * @param {*} ctx
 * @param {*} next
 */
export const updatePosition = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.updateSource(ctx, { model: models.Position })
}

/**
 * 删除职位
 * @param {*} ctx
 * @param {*} next
 */
export const deletePosition = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.deleteSource(ctx, { model: models.Position })
}

/**
 * 列举职位的用户
 * @param {*} ctx 
 * @param {*} next 
 */
export const findUserInPosition = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    await Utils.findUserIn(ctx, models.UserPosition, models.Position, 'position', 'positionId', true);
}

/**
 * 列举不在职位的用户
 * @param {*} ctx 
 * @param {*} next 
 */
export const findUserNotInPosition = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    await Utils.findUserNotIn(ctx, models.UserPosition, models.Position, 'position', 'positionId', true);
}

/**
 * 列举职位的角色
 * @param {*} ctx 
 * @param {*} next 
 */
export const findRoleAssignToPosition = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    await Utils.findSourceIn(ctx, models.Role, 'role', 'roles', models.PositionRole, models.Position, 'position', 'positionId')
}

/**
 * 列举职位未绑定的角色
 * @param {*} ctx 
 * @param {*} next 
 */
export const findRoleNotAssignToPosition = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    await Utils.findSourceNotIn(ctx, models.Role, 'role', 'roleId', 'roles', models.PositionRole, models.Position, 'position', 'positionId')
}

/**
 * 给职位增加角色
 * @param {*} ctx 
 * @param {*} next 
 */
export const assignRoleToPosition = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.bindSourceTo(ctx, models.Role, models.PositionRole, 'roleId', models.Position, 'positionId')
}

/**
 * 从职位删除角色
 * @param {*} ctx 
 * @param {*} next 
 */
export const removeRoleFromPosition = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    return Utils.unbindSourceFrom(ctx, models.Role, models.PositionRole, 'roleId', models.Position, 'positionId')
}

/**
 * 给职位增加用户
 * 
 * @param {*} ctx 
 * @param {*} next 
 */
export const addUserToPosition = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    await Utils.bindASourceToUsers(ctx, models.Position, 'positionId', models.UserPosition, 'positionId', true, 'position');
}

/**
 * 删除职位的用户
 * @param {*} ctx 
 * @param {*} next 
 */
export const removeUseFromPosition = async (ctx, next) => {
    const models = ctx.iota.dc.models;
    await Utils.unbindASourceToUsers(ctx, models.Position, 'positionId', models.UserPosition, 'positionId', true, 'position');
}
