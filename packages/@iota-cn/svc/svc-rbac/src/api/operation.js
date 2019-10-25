import * as Utils from './utils'
import moment from 'moment'

// find user's operation by user(and organization\postion)
export const findOperationOfCurrentUser = async (ctx, next) => {
    const user = ctx.session.user;
    const userId = ctx.session.user.id;
    const dc = ctx.iota.dc;
    const models = ctx.iota.dc.models;
    const orderBy = ctx.query.order_by || 'createdAt';
    const orderDirection = ctx.query.order_direction || 'ASC';
    if (user.isAdmin) {
        let operations = await models.Operation.findAll({
            raw: true,
            order: [[orderBy, orderDirection]]
        });
        operations = operations.map(m => {
            m.hasRight = true;
            return m;
        })
        ctx.status = 200;
        ctx.body = {
            operations: operations
        };
        return;
    }
    let condition = Utils.buildRoleFilterQuery(dc, userId, models.RoleOperation, 'roleId');
    // condition.raw = true;
    // condition.order = [[orderBy, orderDirection]];
    let operations = await models.Operation.findAll(condition);
    operations = operations.map(o => {
        let to = o.get({ plain: true })
        to.hasRight = true;
        return to;
    })
    //parents
    operations = await Utils.fillAllParents(operations, models.Operation);

    let convertor = undefined;
    if (orderBy === 'createdAt' || orderBy === 'updatedAt') {
        convertor = moment;
    }
    Utils.sort(operations, orderBy, orderDirection, convertor);
    ctx.status = 200;
    ctx.body = {
        operations: operations
    };
}