import { uniqueArray, valBetween } from '@iota-cn/svc-util';
import { Validator } from '@iota-cn/util-validation';

/**
 * 
 * @param {*} model 
 * @param {*} modelName 
 * @param {*} condition 
 */
export const filterQuery = (model, modelName, condition) => {
    const Model = require('@iota-fork/sequelize/lib/model')
    Model.$validateIncludedElements.bind(model)(condition);
    return model.QueryGenerator.selectQuery(modelName, condition, model).slice(0, -1);
}

export const buildAdminFilterUserQuery = async (dc, user, asFilter = false, includeOthers = true, includeDeleted = false) => {
    let condition = {
        attributes: asFilter ? ['id'] : userAttributes,
        where: {
            $and: [
                { id: { $not: user.id } },
            ],
            $or: []
        },
        include: [
            {
                model: dc.models.SubUser,
                as: 'subExt',
                where: {
                    parentId: { $not: null }
                },
                attributes: asFilter ? [] : ['id', 'enable']
            }
        ]
    };
    if (includeDeleted) {
        condition.paranoid = false;
    }
    let children = []
    if (includeDeleted) {
        children = await findChildrenOfAUserIncludeSoftDeleted(user, dc.models);
    }
    else {
        children = await findChildrenOfAUser(user, dc.models);
    }
    if (children.length > 0) {
        condition.where.$or.push({
            id: { $in: children.map(c => c.id) }
        })
    }
    if (includeOthers) {
        condition.where.$or.push({ isAdmin: false })
    }
    return condition
}

/**
 * 
 * @param {*} dc 
 * @param {*} models 
 * @param {*} userId 
 * @param {*} through 
 * @param {*} throughKey 
 */
export const buildRoleFilterQuery = (dc, userId, through, throughKey) => {
    const models = dc.models;
    //普通用户
    let roleCondition = {
        $or: []
    };
    //1、关联自己的角色
    const assignedRole = {
        distinct: true,
        attributes: ['roleId'],
        include: [
            {
                attributes: [],
                model: models.User,
                as: 'user',
                where: {
                    id: userId
                }
            }]
    };
    roleCondition.$or.push({ [throughKey]: { $in: dc.orm.literal(`(${filterQuery(models.UserRole, 'UserRole', assignedRole)})`) } });
    //2、通过组织关联的角色
    const assignedOrg = {
        distinct: true,
        attributes: ['roleId'],
        include: [
            {
                attributes: [],
                model: models.Organization,
                as: 'organization',
                include: [
                    {
                        attributes: [],
                        model: models.UserOrganization,
                        as: 'members',
                        where: {
                            userId: userId
                        }
                    }
                ]
            }]
    }
    roleCondition.$or.push({ [throughKey]: { $in: dc.orm.literal(`(${filterQuery(models.OrganizationRole, 'OrganizationRole', assignedOrg)})`) } });
    //3、通过职位关联的角色
    const assignedPosition = {
        distinct: true,
        attributes: ['roleId'],
        include: [
            {
                attributes: [],
                model: models.Position,
                as: 'position',
                include: [
                    {
                        attributes: [],
                        model: models.UserPosition,
                        as: 'members',
                        where: {
                            userId: userId
                        }
                    }
                ]
            }]
    }
    roleCondition.$or.push({ [throughKey]: { $in: dc.orm.literal(`(${filterQuery(models.PositionRole, 'PositionRole', assignedPosition)})`) } });
    let condition = {
        distinct: true,
        include: [
            {
                attributes: [],
                model: through,
                as: 'groups',
                where: roleCondition
            }
        ]
    };
    return condition;
}

/**
 * 
 * @param {*} children 
 * @param {*} model 
 * @param {*} allIds 
 */
export const fillAllParents = async (children, model, allIds) => {
    let ids = children.map(c => c.id);
    allIds = !!allIds ? allIds.concat(ids) : ids;
    let parentIds = children.filter(c => c.parentId !== null && c.parentId !== undefined && allIds.indexOf(c.parentId) === -1).map(c => c.parentId);
    if (parentIds.length > 0) {
        let parents = await model.findAll({
            raw: true,
            where: { id: { $in: parentIds } }
        })
        parents = await fillAllParents(parents, model, allIds);
        children = children.concat(parents)
    }
    return children;
}

export const findChildrenOfAUserIncludeSoftDeleted = async (parent, models) => {
    let children = await findAllChildrenOfUsersIncludeSoftDeleted([parent], models);
    if (parent.isAdmin) {
        return children
    } else {
        return children.filter(c => {
            return !c.isAdmin
        })
    }
}

export const findAllChildrenOfUsersIncludeSoftDeleted = async (parents, models, allIds) => {
    let ids = parents.map(p => {
        return p.id;
    });
    allIds = !!allIds ? allIds.concat(ids) : ids;
    let condition = {
        attributes: userAttributes,
        include: [
            {
                model: models.SubUser,
                as: 'subExt',
                attributes: ['id', 'enable', 'dependent', 'parentId'],
                where: { parentId: { $in: ids } }
            }
        ],
        paranoid: false
    }
    let children = await models.User.findAll(condition)
    //filter allready queried.
    children = children.filter(c => allIds.indexOf(c.id) === -1)
    if (children.length > 0) {
        children = children.concat(await findAllChildrenOfUsersIncludeSoftDeleted(children, models, allIds))
    }
    return children
}

/**
 * 
 * @param {*} parents 
 * @param {*} models 
 */
export const findChildrenOfAUser = async (parent, models) => {
    let children = await findChildrenOfAUserIncludeSoftDeleted(parent, models);
    return children.filter(c => {
        return !c.deletedAt
    })
}

/**
 * 
 * @param {*} rows 
 * @param {*} field 
 * @param {*} direction 
 * @param {*} convertor 
 */
export const sort = (rows, field, direction, convertor) => {
    rows.sort((a, b) => {
        let left = a[field];
        let right = b[field];
        if (typeof convertor === 'function') {
            left = convertor(left)
            right = convertor(right)
        }
        if (direction === 'ASC') {
            if (left < right) {
                return -1;
            }
            if (left > right) {
                return 1;
            }
            return 0;
        } else {
            if (left < right) {
                return 1;
            }
            if (left > right) {
                return -1;
            }
            return 0;
        }
    });
}

/**
 * 
 * @param {*} user 
 * @param {*} childrenIds 
 * @param {*} models 
 */
export const isChildrenUsers = async (dc, user, childrenIds) => {
    if (!Array.isArray(childrenIds)) {
        return false
    }
    childrenIds = uniqueArray(childrenIds)
    if (user.isAdmin) {
        let condition = await buildAdminFilterUserQuery(dc, user, true)
        condition.where.$and.push({ id: { $in: childrenIds } })
        let rs = await dc.models.User.findAndCountAll(condition);
        return rs.count === childrenIds.length;
    }
    let children = await findChildrenOfAUser(user, dc.models);
    let ids = children.map(c => c.id)
    return childrenIds.every(i => ids.indexOf(i) !== -1)
}

/**
 * 
 * @param {*} user 
 * @param {*} childId 
 * @param {*} models 
 */
export const isChildUser = async (dc, user, childId, childInfo, includeDeleted = false, includeAdmin = false) => {
    if (user.isAdmin) {
        let condition = undefined;
        if (childInfo && childInfo.isAdmin) {
            condition = await buildAdminFilterUserQuery(dc, user, true, false, includeDeleted)
        } else {
            condition = await buildAdminFilterUserQuery(dc, user, true, true, includeDeleted)
        }
        condition.where.$and.push({ id: childId })
        let rs = await dc.models.User.findAndCountAll(condition);
        return rs.count === 1;
    }
    // if (user.id === childId) {
    //     return true;
    // }
    if (childInfo && childInfo.isAdmin) {
        return false
    }
    let condition = {
        where: { id: childId },
        include: [
            {
                model: dc.models.SubUser,
                as: 'subExt'
            }
        ]
    }
    if (!user.isAdmin && !includeAdmin) {
        condition.where.isAdmin = false;
    }
    if (includeDeleted) {
        condition.paranoid = false
    }
    const child = await dc.models.User.find(condition);
    if (child && child.subExt && child.subExt.parentId === user.id) {
        return true;
    } else if (child && child.subExt && child.subExt.parentId !== null && child.subExt.parentId !== undefined) {
        return await isChildUser(dc, user, child.subExt.parentId, null, true, true)
    } else {
        return false;
    }
}

/**
 * 
 * @param {*} user 
 * @param {*} dc 
 * @param {*} rss 
 */
export const checkRsByUser = async (user, dc, rss) => {
    const models = dc.models
    if (user.isAdmin) {
        return true;
    }
    // 404 ??
    let children = await findChildrenOfAUserIncludeSoftDeleted(user, models);
    for (let rs of rss) {
        let $or = [
            { belongTo: user.id }
        ];
        if (children.length > 0) {
            $or.push({ belongTo: { $in: children.map(c => c.id) } })
        }
        if (Array.isArray(rs.$or)) {
            $or = $or.concat(rs.$or)
        }
        if (rs.allowMaintainAssigned) {
            let sourceInclude = {
                attributes: [],
                model: rs.model,
                as: rs.sourceAs
            };
            let targetInclude = {
                attributes: [],
                model: models.User,
                as: 'user'
            }
            let assignedCondition = {
                attributes: [rs.throughKey],
                where: {
                    userId: user.id
                },
                include: [
                    sourceInclude,
                    targetInclude
                ],
                distinct: true
            };
            $or.push({ id: { $in: dc.orm.literal(`(${filterQuery(rs.through, rs.through.name, assignedCondition)})`) } })
        }
        let $and = [
            { $or: $or }
        ];
        if (Array.isArray(rs.ids) && rs.ids.length > 0) {
            $and.push({ id: { $in: rs.ids } })
        }
        let condition = {
            attributes: ['id'],
            where: {
                $and: $and
            }
        }
        let rows = await rs.model.findAll(condition);
        if (rows.length != rs.ids.length) {
            return false;
        }
    }
    return true;
}

/**
 * 
 * @param {*} user 
 * @param {*} model 
 * @param {*} models 
 * @param {*} isFillParents 
 * @param {*} ids 
 */
export const findRsByUser = async (user, model, models, isFillParents = false, ids, includeAssigned = false, sourceAs, through) => {
    if (!!ids && !Array.isArray(ids)) {
        ids = [ids]
    }
    if (user.isAdmin) {
        let condition = {
            raw: true
        };
        if (ids && ids.length > 0) {
            condition.where = { id: { $in: ids } }
        }
        let rs = await model.findAll(condition);
        return rs.map(r => {
            r.hasRight = true;
            return r;
        });
    }
    let children = await findChildrenOfAUserIncludeSoftDeleted(user, models);
    let condition = {
        raw: true,
        where: {
            $and: []
        }
    }
    let $or = [
        { belongTo: user.id }
    ]
    if (children.length > 0) {
        $or.push({ belongTo: { $in: children.map(c => c.id) } })
    }
    condition.where.$and.push({ $or: $or })
    if (ids && ids.length > 0) {
        condition.where.$and.push({ id: { $in: ids } })
    }
    let rs = await model.findAll(condition);
    let hasRightIds = [];
    rs = rs.map(r => {
        r.hasRight = true;
        hasRightIds.push(r.id)
        return r;
    })
    //add assigned
    if (includeAssigned) {
        let sourceInclude = {
            model: model,
            as: sourceAs
        };
        if (hasRightIds.length > 0) {
            sourceInclude.where = {
                id: { $notIn: hasRightIds } // hasRight > assigned
            }
        }
        let targetInclude = {
            model: models.User,
            as: 'user'
        }
        let assignedCondition = {
            where: {
                userId: user.id
            },
            include: [
                sourceInclude,
                targetInclude
            ],
            distinct: true
        };
        let sourcesInTarget = await through.findAndCountAll(assignedCondition);
        rs = rs.concat(sourcesInTarget.rows.map(s => {
            let source = Object.assign({ assigned: true }, s[sourceAs].get({ plant: true }));
            source[through.name[0].toLowerCase() + through.name.slice(1)] = {
                id: s.id,
                createdAt: s.createdAt
            }
            return source;
        }))
    }
    //parents
    if (isFillParents) {
        rs = await fillAllParents(rs, model);
    }
    return rs;
}

/**
 * 
 * @param {*} ctx 
 * @param {*} through 
 * @param {*} target 
 * @param {*} targetAs 
 * @param {*} targetKey 
 */
export const findUserIn = async (ctx, through, target, targetAs, targetKey, allowMaintainAssigned = false) => {
    const user = ctx.session.user;
    const userId = ctx.session.user.id;
    const targetId = ctx.params[targetKey];
    const id = ctx.params.id;
    const dc = ctx.iota.dc;
    const models = ctx.iota.dc.models;
    const limit = valBetween(ctx.query.limit, 1, 200, 20);
    const offset = parseInt(ctx.query.offset) || 0;
    const orderBy = ctx.query.order_by || 'createdAt';
    const orderDirection = ctx.query.order_direction || 'DESC';
    let userInclude = {
        model: models.User,
        as: 'user',
        attributes: ['id', 'username', 'email', 'type'],
        include: {
            model: models.SubUser,
            as: 'subExt',
            attributes: ['id', 'enable']
        },
        where: {
            $and: [
                { id: { $not: user.id } }
            ]
        }
    };
    let targetInclude = {
        model: target,
        as: targetAs
    }
    let condition = {
        where: {
            [targetKey]: targetId
        },
        include: [
            userInclude,
            targetInclude
        ],
        limit: limit,
        offset: offset,
        distinct: true,
        order: [[orderBy, orderDirection]]
    };
    if (id) {
        condition.where.id = id;
    }
    if (!user.isAdmin) {
        let targetRs = await findRsByUser(user, target, models, false, undefined, allowMaintainAssigned, targetAs, through);
        if (!targetRs.some(o => o.id === targetId)) {
            ctx.status = 403;
            ctx.body = {
                name: 'forbidden',
                message: `not a ${target.name} of current user`
            };
            return;
        }
        let children = await findChildrenOfAUser(user, models);
        userInclude.where.$and.push({ id: { $in: children.map(c => c.id) } })
    } else {
        let filterOtherAdmin = await buildAdminFilterUserQuery(dc, user, true)
        userInclude.where.$and.push({ id: { $in: dc.orm.literal(`(${filterQuery(models.User, 'User', filterOtherAdmin)})`) } })
    }
    let usersInTarget = await through.findAndCountAll(condition);
    ctx.status = 200;
    let users = [];
    for (let u of usersInTarget.rows) {
        users.push({
            id: u.userId,
            [through.name[0].toLowerCase() + through.name.slice(1)]: u.id,
            [targetKey]: u[targetKey],
            email: u.user.email,
            username: u.user.username,
            accept: u.accept,
            enable: u.enable,
            type: u.type,
            createdAt: u.createdAt
        });
    }
    ctx.body = {
        count: usersInTarget.count,
        users: users
    };
    //规范化返回
    if (ctx.iota.restful && typeof ctx.iota.restful.createNormalizer === 'function') {
        ctx.iota.restful.createNormalizer('users')(ctx);
    }
}

/**
 * 
 * @param {*} ctx 
 * @param {*} through 
 * @param {*} target 
 * @param {*} targetAs 
 * @param {*} targetKey 
 */
export const findUserNotIn = async (ctx, through, target, targetAs, targetKey, allowMaintainAssigned = false) => {
    const user = ctx.session.user;
    const userId = ctx.session.user.id;
    const targetId = ctx.params[targetKey];
    const id = ctx.params.id;
    const dc = ctx.iota.dc;
    const models = ctx.iota.dc.models;
    const limit = valBetween(ctx.query.limit, 1, 200, 20);
    const offset = parseInt(ctx.query.offset) || 0;
    const orderBy = ctx.query.order_by || 'createdAt';
    const orderDirection = ctx.query.order_direction || 'DESC';
    let userInclude = {
        attributes: [],
        model: models.User,
        as: 'user'
    };
    let targetInclude = {
        attributes: [],
        model: target,
        as: targetAs
    }
    let filterCondition = {
        attributes: ['userId'],
        where: {
            [targetKey]: targetId
        },
        include: [
            userInclude,
            targetInclude
        ]
    };
    let condition = {
        where: { $and: [{ id: { $not: user.id } }] },
        attributes: ['id', 'username', 'email', 'type', 'createdAt'],
        include: {
            model: models.SubUser,
            as: 'subExt',
            attributes: ['id', 'enable']
        },
        distinct: true,
        limit: limit,
        offset: offset,
        order: [[orderBy, orderDirection]]
    }
    if (!user.isAdmin) {
        let targetRs = await findRsByUser(user, target, models, false, undefined, allowMaintainAssigned, targetAs, through);
        if (!targetRs.some(o => o.id === targetId)) {
            ctx.status = 403;
            ctx.body = {
                name: 'forbidden',
                message: `not a ${targetAs} of current user`
            };
            return;
        }
        let children = await findChildrenOfAUser(user, models);
        condition.where.$and.push({ id: { $in: children.map(c => c.id) } })
    } else {
        let filterOtherAdmin = await buildAdminFilterUserQuery(dc, user, true)
        condition.where.$and.push({ id: { $in: dc.orm.literal(`(${filterQuery(models.User, 'User', filterOtherAdmin)})`) } })
    }
    condition.where.$and.push({ id: { $notIn: dc.orm.literal(`(${filterQuery(through, through.name, filterCondition)})`) } })
    let usersNotInTarget = await models.User.findAndCountAll(condition);
    ctx.status = 200;
    ctx.body = {
        count: usersNotInTarget.count,
        users: usersNotInTarget.rows
    };
    //规范化返回
    if (ctx.iota.restful && typeof ctx.iota.restful.createNormalizer === 'function') {
        ctx.iota.restful.createNormalizer('users')(ctx);
    }
}

/**
 * 
 * @param {*} ctx 
 * @param {*} source 
 * @param {*} sourceAs 
 * @param {*} outKey 
 * @param {*} through 
 * @param {*} target 
 * @param {*} targetAs 
 * @param {*} targetKey 
 * @param {*} page 
 * @param {*} fillParents 
 */
export const findSourceIn = async (ctx, source, sourceAs, outKey, through, target, targetAs, targetKey, page = true, fillParents = false) => {
    const user = ctx.session.user;
    const userId = ctx.session.user.id;
    const targetId = ctx.params[targetKey];
    const id = ctx.params.id;
    const dc = ctx.iota.dc;
    const models = ctx.iota.dc.models;
    const orderBy = ctx.query.order_by || 'createdAt';
    const orderDirection = ctx.query.order_direction || 'DESC';
    let sourceInclude = {
        model: source,
        as: sourceAs
    };
    let targetInclude = {
        model: target,
        as: targetAs
    }
    let condition = {
        where: {
            [targetKey]: targetId
        },
        include: [
            sourceInclude,
            targetInclude
        ],
        distinct: true,
        order: [[orderBy, orderDirection]]
    };
    if (page && !fillParents) {
        const limit = valBetween(ctx.query.limit, 1, 200, 20);
        const offset = parseInt(ctx.query.offset) || 0;
        condition.limit = limit;
        condition.offset = offset;
    }
    // if (id) {
    //     condition.where.id = id;
    // }
    if (!user.isAdmin) {
        let targetRs = await findRsByUser(user, target, models);
        if (!targetRs.some(o => o.id === targetId)) {
            ctx.status = 403;
            ctx.body = {
                name: 'forbidden',
                message: `not a ${targetAs}  of current user`
            };
            return;
        }
        let sourceRs = await findRsByUser(user, source, models);
        sourceInclude.where = { id: { $in: sourceRs.map(c => c.id) } }
    }
    let sourcesInTarget = await through.findAndCountAll(condition);
    let outPuts = sourcesInTarget.rows.map(s => {
        let source = Object.assign({ assigned: true }, s[sourceAs].get({ plant: true }));
        source[through.name[0].toLowerCase() + through.name.slice(1)] = {
            id: s.id,
            createdAt: s.createdAt
        }
        return source
    })
    if (fillParents) {
        outPuts = await fillAllParents(outPuts, source)
    }
    ctx.status = 200;
    ctx.body = {
        [outKey]: outPuts
    };
    if (page && !fillParents) {
        ctx.body.count = sourcesInTarget.count    //规范化返回
        if (ctx.iota.restful && typeof ctx.iota.restful.createNormalizer === 'function') {
            ctx.iota.restful.createNormalizer(outKey)(ctx);
        }
    }
}

/**
 * 
 * @param {*} ctx 
 * @param {*} source 
 * @param {*} sourceAs 
 * @param {*} sourceKey 
 * @param {*} outKey 
 * @param {*} through 
 * @param {*} target 
 * @param {*} targetAs 
 * @param {*} targetKey 
 */
export const findSourceNotIn = async (ctx, source, sourceAs, sourceKey, outKey, through, target, targetAs, targetKey, page = true, fillParents = false) => {
    const user = ctx.session.user;
    const userId = ctx.session.user.id;
    const targetId = ctx.params[targetKey];
    const id = ctx.params.id;
    const dc = ctx.iota.dc;
    const models = ctx.iota.dc.models;
    const orderBy = ctx.query.order_by || 'createdAt';
    const orderDirection = ctx.query.order_direction || 'DESC';
    let sourceInclude = {
        attributes: [],
        model: source,
        as: sourceAs,
    };
    let targetInclude = {
        attributes: [],
        model: target,
        as: targetAs
    }
    let filterCondition = {
        attributes: [sourceKey],
        where: {
            [targetKey]: targetId
        },
        include: [
            sourceInclude,
            targetInclude
        ],
        distinct: true,
        order: [[orderBy, orderDirection]]
    };
    let condition = {
        where: { $and: [] },
        order: [[orderBy, orderDirection]]
    };
    if (page && !fillParents) {
        const limit = valBetween(ctx.query.limit, 1, 200, 20);
        const offset = parseInt(ctx.query.offset) || 0;
        condition.limit = limit;
        condition.offset = offset;
    }
    if (!user.isAdmin) {
        let targetRs = await findRsByUser(user, target, models);
        if (!targetRs.some(o => o.id === targetId)) {
            ctx.status = 403;
            ctx.body = {
                name: 'forbidden',
                message: `not a ${targetAs} of current user`
            };
            return;
        }
        let sourceRs = await findRsByUser(user, source, models);
        condition.where.$and.push({ id: { $in: sourceRs.map(c => c.id) } })
    }
    condition.where.$and.push({ id: { $notIn: dc.orm.literal(`(${filterQuery(through, through.name, filterCondition)})`) } })
    let sourcesNotInTarget = await source.findAndCountAll(condition);
    if (fillParents) {
        sourcesNotInTarget.rows = await fillAllParents(sourcesNotInTarget.rows, source)
    }
    ctx.status = 200;
    ctx.body = {
        [outKey]: sourcesNotInTarget.rows
    };
    if (page && !fillParents) {
        ctx.body.count = sourcesNotInTarget.count    //规范化返回
        if (ctx.iota.restful && typeof ctx.iota.restful.createNormalizer === 'function') {
            ctx.iota.restful.createNormalizer(outKey)(ctx);
        }
    }
}

/**
 * 
 * @param {*} ctx 
 * @param {*} source 
 * @param {*} sourceAs 
 * @param {*} outKey 
 * @param {*} through 
 * @param {*} page 
 */
export const findSourceAssignToUser = async (ctx, source, sourceAs, outKey, through, page = true, fillParents = false, includeAssigned = false) => {
    const user = ctx.session.user;
    const userId = ctx.session.user.id;
    const targetId = ctx.params.userId;
    const id = ctx.params.id;
    const dc = ctx.iota.dc;
    const models = ctx.iota.dc.models;
    const limit = valBetween(ctx.query.limit, 1, 200, 20);
    const offset = parseInt(ctx.query.offset) || 0;
    const orderBy = ctx.query.order_by || 'createdAt';
    const orderDirection = ctx.query.order_direction || 'DESC';
    let sourceInclude = {
        model: source,
        as: sourceAs,
    };
    let targetInclude = {
        model: models.User,
        as: 'user'
    }
    let condition = {
        where: {
            userId: targetId
        },
        include: [
            sourceInclude,
            targetInclude
        ],
        distinct: true,
        order: [[orderBy, orderDirection]]
    };
    if (page && !fillParents) {
        const limit = valBetween(ctx.query.limit, 1, 200, 20);
        const offset = parseInt(ctx.query.offset) || 0;
        condition.limit = limit;
        condition.offset = offset;
    }
    if (!user.isAdmin) {
        let children = await findChildrenOfAUser(user, models);
        if (!children.some(c => c.id === targetId)) {
            ctx.status = 403;
            ctx.body = {
                name: 'forbidden',
                message: `not a sub user of current user`
            };
            return;
        }
        let sourceRs = [];
        if (includeAssigned) {
            sourceRs = await findRsByUser(user, source, models, false, undefined, true, sourceAs, through);
        } else {
            sourceRs = await findRsByUser(user, source, models);
        }
        sourceInclude.where = { id: { $in: sourceRs.map(c => c.id) } }
    }
    let sourcesInTarget = await through.findAndCountAll(condition);
    let outPuts = sourcesInTarget.rows.map(s => {
        let source = Object.assign({ assigned: true }, s[sourceAs].get({ plant: true }));
        source[through.name[0].toLowerCase() + through.name.slice(1)] = {
            id: s.id,
            createdAt: s.createdAt
        }
        return source;
    })
    if (fillParents) {
        outPuts = await fillAllParents(outPuts, source)
    }
    ctx.status = 200;
    ctx.body = {
        [outKey]: outPuts
    };
    if (page && !fillParents) {
        ctx.body.count = sourcesInTarget.count    //规范化返回
        if (ctx.iota.restful && typeof ctx.iota.restful.createNormalizer === 'function') {
            ctx.iota.restful.createNormalizer(outKey)(ctx);
        }
    }
}

/**
 * 
 * @param {*} ctx 
 * @param {*} source 
 * @param {*} sourceAs 
 * @param {*} sourceKey 
 * @param {*} outKey 
 * @param {*} through 
 */
export const findSourceNotAssignToUser = async (ctx, source, sourceAs, sourceKey, outKey, through, page = true, fillParents = false, includeAssigned = false) => {
    const user = ctx.session.user;
    const userId = ctx.session.user.id;
    const targetId = ctx.params.userId;
    const id = ctx.params.id;
    const dc = ctx.iota.dc;
    const models = ctx.iota.dc.models;
    const limit = valBetween(ctx.query.limit, 1, 200, 20);
    const offset = parseInt(ctx.query.offset) || 0;
    const orderBy = ctx.query.order_by || 'createdAt';
    const orderDirection = ctx.query.order_direction || 'DESC';
    let sourceInclude = {
        attributes: [],
        model: source,
        as: sourceAs,
    };
    let targetInclude = {
        attributes: [],
        model: models.User,
        as: 'user'
    }
    let filterCondition = {
        attributes: [sourceKey],
        where: {
            userId: targetId
        },
        include: [
            sourceInclude,
            targetInclude
        ],
        distinct: true,
        order: [[orderBy, orderDirection]]
    };
    let condition = {
        where: { $and: [] },
        order: [[orderBy, orderDirection]]
    };
    if (page && !fillParents) {
        const limit = valBetween(ctx.query.limit, 1, 200, 20);
        const offset = parseInt(ctx.query.offset) || 0;
        condition.limit = limit;
        condition.offset = offset;
    }
    if (!user.isAdmin) {
        let children = await findChildrenOfAUser(user, models);
        if (!children.some(c => c.id === targetId)) {
            ctx.status = 403;
            ctx.body = {
                name: 'forbidden',
                message: `not a sub user of current user`
            };
            return;
        }
        let sourceRs = [];
        if (includeAssigned) {
            sourceRs = await findRsByUser(user, source, models, false, undefined, true, sourceAs, through);
        } else {
            sourceRs = await findRsByUser(user, source, models);
        }
        condition.where.$and.push({ id: { $in: sourceRs.map(c => c.id) } })
    }
    condition.where.$and.push({ id: { $notIn: dc.orm.literal(`(${filterQuery(through, through.name, filterCondition)})`) } })
    let sourcesNotInTarget = await source.findAndCountAll(condition);
    if (fillParents) {
        sourcesNotInTarget.rows = await fillAllParents(sourcesNotInTarget.rows, source)
    }
    ctx.status = 200;
    ctx.body = {
        [outKey]: sourcesNotInTarget.rows
    };
    if (page && !fillParents) {
        ctx.body.count = sourcesNotInTarget.count    //规范化返回
        if (ctx.iota.restful && typeof ctx.iota.restful.createNormalizer === 'function') {
            ctx.iota.restful.createNormalizer(outKey)(ctx);
        }
    }
}

/**
 * 
 * @param {*} ctx 
 * @param {*} source 
 */
export const createSource = async (ctx, source) => {
    const user = ctx.session.user;
    const dc = ctx.iota.dc;
    const belongTo = ctx.session.user.id;
    const models = ctx.iota.dc.models;
    const sourceBody = ctx.request.body ? ctx.request.body : {};
    if (Validator.isCommonName(sourceBody.name)
        && Validator.isCommonDesc(sourceBody.desc)) {
        if (sourceBody.parentId && source.isHierarchical) {
            let condition = {
                attributes: [source.throughId],
                include: [
                    {
                        attributes: [],
                        model: models.User,
                        as: 'user',
                        where: {
                            id: user.id
                        }
                    }
                ]
            }
            let rss = [{
                model: source.model,
                ids: [sourceBody.parentId],
                $or: [{ id: { $in: dc.orm.literal(`(${filterQuery(source.through, source.through.name, condition)})`) } }] // 关联的
            }]
            let isValid = await checkRsByUser(user, dc, rss);
            if (!isValid) {
                ctx.status = 403;
                ctx.body = {
                    name: 'forbidden',
                    message: 'no authorization to related resources.'
                };
                return;
            }
        }
        let newSource = {
            name: sourceBody.name,
            desc: sourceBody.desc,
            belongTo,
            id: process.env.NODE_ENV === 'test' ? sourceBody.id : undefined
        }
        if (sourceBody.parentId && source.isHierarchical) {
            newSource.parentId = sourceBody.parentId;
        }
        newSource = await source.model.create(newSource)
        ctx.status = 200;
        ctx.body = newSource
    }
    else {
        ctx.status = 400;
        ctx.body = {
            name: 'invalid request',
            message: 'invalid name or desc'
        };
    }
}

/**
 * 
 * @param {*} ctx 
 * @param {*} source 
 */
export const updateSource = async (ctx, source) => {
    const user = ctx.session.user;
    const id = ctx.params.id;
    const dc = ctx.iota.dc;
    const models = ctx.iota.dc.models;
    const sourceBody = ctx.request.body;
    if (sourceBody
        && (sourceBody.name ? Validator.isCommonName(sourceBody.name) : true)
        && (sourceBody.desc ? Validator.isCommonDesc(sourceBody.desc) : true)) {
        let isValid = await checkRsByUser(user, dc, [
            {
                model: source.model,
                ids: [id]
            }
        ])
        if (isValid) {
            let record = {
                name: sourceBody.name,
                desc: sourceBody.desc
            };
            let result = await source.model.update(
                record,
                { where: { id: id } }
            );
            let count = result[0];
            if (count === 1) {
                ctx.status = 204;
                ctx.body = {};
            } else {
                ctx.status = 404;
                ctx.body = {
                    name: `invalid ${source.model.name}`,
                    message: `invalid ${source.model.name} ${id}`
                };
            }
        } else {
            ctx.status = 403;
            ctx.body = {
                name: 'forbidden',
                message: `invalid ${source.model.name} ${id} or no authorization`
            };
        }
    } else {
        ctx.status = 400;
        ctx.body = {
            name: `invalid ${source.model.name}`,
            message: `invalid ${source.model.name} name or desc`
        };
    }
}

/**
 * 
 * @param {*} ctx 
 * @param {*} source 
 */
export const deleteSource = async (ctx, source) => {
    const user = ctx.session.user;
    let ids = ctx.query.ids ? ctx.query.ids.split(',') : [];
    const dc = ctx.iota.dc;
    const models = ctx.iota.dc.models;
    const id = ctx.params.id;
    if (id) {
        ids.push(id);
    }
    ids = uniqueArray(ids);
    let isValid = await checkRsByUser(user, dc, [
        {
            model: source.model,
            ids: ids
        }
    ])
    if (isValid) {
        let t = await ctx.iota.dc.orm.transaction();
        try {
            let result = await source.model.destroy({
                where: {
                    id: { $in: ids }
                }
            });
            if (result === ids.length) {
                await t.commit();
                ctx.status = 204;
                ctx.body = {};
            } else {
                await t.rollback();
                ctx.status = 404;
                ctx.body = {
                    name: `invalid ${source.model.name}`,
                    message: `invalid ${source.model.name} ${ids}`
                };
            }
        } catch (e) {
            await t.rollback();
            throw e;
        }
    } else {
        ctx.status = 403;
        ctx.body = {
            name: 'forbidden',
            message: `invalid ${source.model.name} ${ids} or no authorization`
        };
    }
}

/**
 * 
 * @param {*} ctx 
 * @param {*} model 
 * @param {*} through 
 * @param {*} outKey 
 */
export const findSourceBelongToRole = async (ctx, model, through, outKey) => {
    const user = ctx.session.user;
    const userId = ctx.session.user.id;
    const dc = ctx.iota.dc;
    const models = ctx.iota.dc.models;
    const roleId = ctx.params.roleId;
    let isValid = await checkRsByUser(user, dc, [{
        model: models.Role,
        ids: [roleId]
    }])
    if (isValid) {
        let condition = {
            distinct: true,
            include: [
                {
                    attributes: [],
                    model: through,
                    as: 'groups',
                    where: {
                        roleId: roleId
                    }
                }
            ]
        }
        if (!user.isAdmin) {
            let filterCondition = buildRoleFilterQuery(dc, userId, through, 'roleId')
            filterCondition.attributes = ['id']
            condition.where = {
                id: { $in: dc.orm.literal(`(${filterQuery(model, model.name, filterCondition)})`) }
            }
        }
        let assigned = await model.findAll(condition)
        assigned = assigned.map(a => {
            let ta = a.get({ plain: true })
            ta.assigned = true;
            return ta;
        })
        assigned = await fillAllParents(assigned, model);
        ctx.status = 200;
        ctx.body = {
            [outKey]: assigned
        }
    } else {
        ctx.status = 403;
        ctx.body = {
            name: 'forbidden',
            message: `invalid ${'role'} ${roleId} or no authorization`
        };
    }
}

/**
 * 
 * @param {*} ctx 
 * @param {*} model 
 * @param {*} through 
 * @param {*} throughKey 
 */
export const assignSourceToRole = async (ctx, model, through, throughKey) => {
    const user = ctx.session.user;
    const userId = ctx.session.user.id;
    const dc = ctx.iota.dc;
    const models = ctx.iota.dc.models;
    const roleId = ctx.params.roleId;
    let ids = ctx.request.body.ids ? ctx.request.body.ids : [];
    ids = uniqueArray(ids)
    let isValid = await checkRsByUser(user, dc, [
        {
            model: models.Role,
            ids: [roleId]
        }
    ])
    if (isValid && !user.isAdmin) {
        let condition = buildRoleFilterQuery(dc, userId, through, 'roleId');
        let rs = await model.findAll(condition);
        //@TODO include parents but can not only include parent.
        rs = await fillAllParents(rs, model)
        let rsIds = rs.map(r => r.id)
        isValid = ids.every(i => rsIds.indexOf(i) !== -1)
    }
    if (isValid) {
        let t = await ctx.iota.dc.orm.transaction();
        try {
            let newSources = [];
            for (let id of ids) {
                let exist = await through.findOne({
                    where: {
                        roleId: roleId,
                        [throughKey]: id
                    }
                }, { transaction: t })
                if (!exist) {
                    let m = await through.create({
                        roleId: roleId,
                        [throughKey]: id
                    }, { transaction: t })
                    newSources.push(m)
                }
            }
            await t.commit();
            ctx.status = 200;
            ctx.body = newSources;
        } catch (e) {
            await t.rollback();
            throw e;
        }

    } else {
        ctx.status = 403;
        ctx.body = {
            name: 'forbidden',
            message: `invalid ${'role'} ${roleId} or no authorization`
        };
    }
}

/**
 * 
 * @param {*} ctx 
 * @param {*} model 
 * @param {*} through 
 * @param {*} throughKey 
 */
export const removeSourceFromRole = async (ctx, model, through, throughKey) => {
    const user = ctx.session.user;
    const userId = ctx.session.user.id;
    const dc = ctx.iota.dc;
    const models = ctx.iota.dc.models;
    const roleId = ctx.params.roleId;
    let ids = ctx.query.ids ? ctx.query.ids.split(',') : [];
    const id = ctx.params.id;
    if (id) {
        ids.push(id);
    }
    ids = uniqueArray(ids)
    let isValid = await checkRsByUser(user, dc, [
        {
            model: models.Role,
            ids: [roleId]
        }
    ])
    if (isValid && !user.isAdmin) {
        let condition = buildRoleFilterQuery(dc, userId, through, 'roleId');
        let rs = await model.findAll(condition);
        //@TODO include parents but can not only include parent.
        rs = await fillAllParents(rs, model)
        let rsIds = rs.map(r => r.id)
        isValid = ids.every(i => rsIds.indexOf(i) !== -1)
    }
    if (isValid) {
        let count = await through.destroy({
            where: {
                roleId: roleId,
                [throughKey]: { $in: ids }
            }
        })
        ctx.status = 204;
        ctx.body = {}
    } else {
        ctx.status = 403;
        ctx.body = {
            name: 'forbidden',
            message: `invalid ${'role'} ${roleId} or no authorization`
        };
    }
}

/**
 * 
 * @param {*} ctx 
 * @param {*} source 
 * @param {*} through 
 * @param {*} throughKey 
 * @param {*} target 
 * @param {*} targetKey 
 */
export const bindSourceTo = async (ctx, source, through, throughKey, target, targetKey) => {
    const user = ctx.session.user;
    const userId = ctx.session.user.id;
    const dc = ctx.iota.dc;
    const models = ctx.iota.dc.models;
    const targetId = ctx.params[targetKey];
    let ids = ctx.request.body.ids ? ctx.request.body.ids : [];
    ids = uniqueArray(ids)
    let isValid = await checkRsByUser(user, dc, [
        {
            model: target,
            ids: [targetId]
        },
        {
            model: source,
            ids: ids
        }
    ])
    if (isValid) {
        let t = await ctx.iota.dc.orm.transaction();
        try {
            let newSources = [];
            for (let id of ids) {
                let exist = await through.findOne({
                    where: {
                        [targetKey]: targetId,
                        [throughKey]: id
                    }
                }, { transaction: t })
                if (!exist) {
                    let m = await through.create({
                        [targetKey]: targetId,
                        [throughKey]: id
                    }, { transaction: t })
                    newSources.push(m)
                }
            }
            await t.commit();
            ctx.status = 200;
            ctx.body = newSources;
        } catch (e) {
            await t.rollback();
            throw e;
        }

    } else {
        ctx.status = 403;
        ctx.body = {
            name: 'forbidden',
            message: `invalid ${target.name} ${targetId} or no authorization`
        };
    }
}

/**
 * 
 * @param {*} ctx 
 * @param {*} model 
 * @param {*} through 
 * @param {*} throughKey 
 * @param {*} target 
 * @param {*} targetKey 
 */
export const unbindSourceFrom = async (ctx, model, through, throughKey, target, targetKey) => {
    const user = ctx.session.user;
    const userId = ctx.session.user.id;
    const dc = ctx.iota.dc;
    const models = ctx.iota.dc.models;
    const targetId = ctx.params[targetKey];
    let ids = ctx.query.ids ? ctx.query.ids.split(',') : [];
    const id = ctx.params.id;
    if (id) {
        ids.push(id);
    }
    ids = uniqueArray(ids)
    let isValid = await checkRsByUser(user, dc, [
        {
            model: target,
            ids: [targetId]
        },
        {
            model: model,
            ids: ids
        }
    ])
    if (isValid) {
        let count = await through.destroy({
            where: {
                [targetKey]: targetId,
                [throughKey]: { $in: ids }
            }
        })
        //@TODO check count equal
        ctx.status = 204;
        ctx.body = {}
    } else {
        ctx.status = 403;
        ctx.body = {
            name: 'forbidden',
            message: `invalid ${target.name} ${targetId} or no authorization`
        };
    }
}

/**
 * 
 * @param {*} ctx 
 * @param {*} source 
 * @param {*} through 
 * @param {*} throughKey 
 */
export const bindAUserToSources = async (ctx, source, through, throughKey, allowMaintainAssigned = false, sourceAs) => {
    const user = ctx.session.user;
    const dc = ctx.iota.dc;
    const models = ctx.iota.dc.models;
    const userId = ctx.params.userId;
    let ids = ctx.request.body.ids ? ctx.request.body.ids : [];
    ids = uniqueArray(ids)
    let isValid = await isChildUser(dc, user, userId)
    if (isValid) {
        isValid = await checkRsByUser(user, dc, [
            {
                model: source,
                ids: ids,
                allowMaintainAssigned: allowMaintainAssigned,
                sourceAs: sourceAs,
                through: through,
                throughKey: throughKey
            }
        ])
    }
    if (isValid) {
        let t = await ctx.iota.dc.orm.transaction();
        try {
            let newSources = [];
            for (let id of ids) {
                let exist = await through.findOne({
                    where: {
                        userId: userId,
                        [throughKey]: id
                    }
                }, { transaction: t })
                if (!exist) {
                    let m = await through.create({
                        userId: userId,
                        [throughKey]: id
                    }, { transaction: t })
                    newSources.push(m)
                }
            }
            await t.commit();
            ctx.status = 200;
            ctx.body = newSources;
        } catch (e) {
            await t.rollback();
            throw e;
        }

    } else {
        ctx.status = 403;
        ctx.body = {
            name: 'forbidden',
            message: `invalid user ${userId} or no authorization`
        };
    }
}

/**
 * 
 * @param {*} ctx 
 * @param {*} source 
 * @param {*} through 
 * @param {*} throughKey 
 */
export const unbindSourceFromAUser = async (ctx, source, through, throughKey, allowMaintainAssigned = false, sourceAs) => {
    const user = ctx.session.user;
    const dc = ctx.iota.dc;
    const models = ctx.iota.dc.models;
    const userId = ctx.params.userId;
    let ids = ctx.query.ids ? ctx.query.ids.split(',') : [];
    const id = ctx.params.id;
    if (id) {
        ids.push(id);
    }
    ids = uniqueArray(ids)
    let isValid = await isChildUser(dc, user, userId)
    if (isValid) {
        isValid = await checkRsByUser(user, dc, [
            {
                model: source,
                ids: ids,
                allowMaintainAssigned: allowMaintainAssigned,
                sourceAs: sourceAs,
                through: through,
                throughKey: throughKey
            }
        ])
    }
    if (isValid) {
        let count = await through.destroy({
            where: {
                userId: userId,
                [throughKey]: { $in: ids }
            }
        })
        //@TODO check count equal
        ctx.status = 204;
        ctx.body = {}
    } else {
        ctx.status = 403;
        ctx.body = {
            name: 'forbidden',
            message: `invalid user ${userId} or no authorization`
        };
    }
}

/**
 * 
 * @param {*} ctx 
 * @param {*} source 
 * @param {*} sourceKey 
 * @param {*} through 
 * @param {*} throughKey 
 */
export const bindASourceToUsers = async (ctx, source, sourceKey, through, throughKey, allowMaintainAssigned = false, sourceAs) => {
    const user = ctx.session.user;
    const currentUserId = ctx.session.user.id;
    const dc = ctx.iota.dc;
    const models = ctx.iota.dc.models;
    const sourceId = ctx.params[sourceKey];
    let ids = ctx.request.body.ids ? ctx.request.body.ids : [];
    ids = uniqueArray(ids)
    let isValid = await checkRsByUser(user, dc, [
        {
            model: source,
            ids: [sourceId],
            allowMaintainAssigned: allowMaintainAssigned,
            sourceAs: sourceAs,
            through: through,
            throughKey: throughKey
        }
    ])
    if (isValid && !user.isAdmin) {
        let children = await findChildrenOfAUser(user, models);
        let childIds = children.map(c => c.id)
        isValid = ids.every(i => childIds.indexOf(i) !== -1)
    }
    if (isValid) {
        let t = await ctx.iota.dc.orm.transaction();
        try {
            let newSources = [];
            for (let id of ids) {
                let exist = await through.findOne({
                    where: {
                        userId: id,
                        [throughKey]: sourceId
                    }
                }, { transaction: t })
                if (!exist) {
                    let m = await through.create({
                        userId: id,
                        [throughKey]: sourceId
                    }, { transaction: t })
                    newSources.push(m)
                }
            }
            await t.commit();
            ctx.status = 200;
            ctx.body = newSources;
        } catch (e) {
            await t.rollback();
            throw e;
        }

    } else {
        ctx.status = 403;
        ctx.body = {
            name: 'forbidden',
            message: `invalid ${source.name} ${sourceId} or no authorization`
        };
    }
}

/**
 * 
 * @param {*} ctx 
 * @param {*} model 
 * @param {*} through 
 * @param {*} throughKey 
 */
export const unbindASourceToUsers = async (ctx, source, sourceKey, through, throughKey, allowMaintainAssigned = false, sourceAs) => {
    const user = ctx.session.user;
    const currentUserId = ctx.session.user.id;
    const dc = ctx.iota.dc;
    const models = ctx.iota.dc.models;
    const sourceId = ctx.params[sourceKey];
    let ids = ctx.query.ids ? ctx.query.ids.split(',') : [];
    const id = ctx.params.id;
    if (id) {
        ids.push(id);
    }
    ids = uniqueArray(ids)
    let isValid = await checkRsByUser(user, dc, [
        {
            model: source,
            ids: [sourceId],
            allowMaintainAssigned: allowMaintainAssigned,
            sourceAs: sourceAs,
            through: through,
            throughKey: throughKey
        }
    ])
    if (isValid && !user.isAdmin) {
        let children = await findChildrenOfAUser(user, models);
        let childIds = children.map(c => c.id)
        isValid = ids.every(i => childIds.indexOf(i) !== -1)
    }
    if (isValid) {
        let count = await through.destroy({
            where: {
                userId: { $in: ids },
                [throughKey]: sourceId
            }
        })
        //@TODO check count equal
        ctx.status = 204;
        ctx.body = {}
    } else {
        ctx.status = 403;
        ctx.body = {
            name: 'forbidden',
            message: `invalid ${source.name} ${sourceId} or no authorization`
        };
    }
}

export const userAttributesWhenInclude = [['id', 'userId'], 'username', 'email', 'mobile', 'gravatar', 'actEmail', 'type', 'isAdmin', 'deletedAt'];
export const userAttributes = ['id', 'username', 'email', 'mobile', 'gravatar', 'actEmail', 'type', 'isAdmin', 'deletedAt'];
