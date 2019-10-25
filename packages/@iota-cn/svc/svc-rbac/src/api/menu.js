import * as Utils from './utils'
import moment from 'moment'

// find user's menu by user(and organization\postion)
export const findMenuOfCurrentUser = async (ctx, next) => {
    const user = ctx.session.user;
    const userId = ctx.session.user.id;
    const dc = ctx.iota.dc;
    const models = ctx.iota.dc.models;
    const orderBy = ctx.query.order_by || 'createdAt';
    const orderDirection = ctx.query.order_direction || 'ASC';
    if (user.isAdmin) {
        let menus = await models.Menu.findAll({
            raw: true,
            order: [[orderBy, orderDirection]]
        });
        menus = menus.map(m => {
            m.hasRight = true;
            return m;
        })
        ctx.status = 200;
        ctx.body = {
            menus: menus
        };
        return;
    }
    let condition = Utils.buildRoleFilterQuery(dc, userId, models.RoleMenu, 'roleId');
    // condition.raw = true;
    // condition.order = [[orderBy, orderDirection]];
    let menus = await models.Menu.findAll(condition);
    menus = menus.map(m => {
        let tm = m.get({ plain: true })
        tm.hasRight = true;
        return tm;
    })
    //parents
    menus = await Utils.fillAllParents(menus, models.Menu);
    let convertor = undefined;
    if (orderBy === 'createdAt' || orderBy === 'updatedAt') {
        convertor = moment;
    }
    Utils.sort(menus, orderBy, orderDirection, convertor);
    ctx.status = 200;
    ctx.body = {
        menus: menus
    };
}
