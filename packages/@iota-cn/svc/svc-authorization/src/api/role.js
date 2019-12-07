import { Validator } from '@iota-cn/util-validation';
import { uniqueArray, valBetween } from '@iota-cn/svc-util';

let find = async function (ctx, next) {
    let createBy = ctx.session.user.id;
    const id = ctx.params.id;
    const limit = valBetween(ctx.query.limit, 1, 200, 20);
    const offset = parseInt(ctx.query.offset) || 0;
    const orderBy = ctx.query.orderBy || 'createdAt';
    const orderDirection = ctx.query.orderDirection || 'DESC';
    let models = ctx.iota.dc.models;
    let condition = {
        where: {
            createBy: createBy
        },
        include: [
            {
                model: models.Permission,
                as: 'permissions'
            }
        ],
        limit: limit,
        offset: offset,
        distinct: true,
        order: [[orderBy, orderDirection]]
    };
    if (id) {
        condition.where.id = id;
    }
    let rolesWithPermissions = await models.Role.findAndCountAll(condition);
    ctx.status = 200;
    ctx.body = {
        count: rolesWithPermissions.count,
        roles: rolesWithPermissions.rows
    };
    //规范化返回
    if (ctx.iota.restful && typeof ctx.iota.restful.createNormalizer === 'function') {
        ctx.iota.restful.createNormalizer('roles')(ctx);
    }
};

let create = async function (ctx, next) {
    const models = ctx.iota.dc.models;
    const role = ctx.request.body;
    const createBy = ctx.session.user.id;
    let count = await models.Role.count({
        where: {
            createBy: createBy
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
    if (role && Validator.isCommonName(role.name) && Validator.isCommonDesc(role.desc)) {
        let t = await ctx.iota.dc.orm.transaction();
        let newRole = await models.Role.create({
            name: role.name,
            desc: role.desc,
            createBy: createBy
        }, { transaction: t }
        );
        if (newRole) {
            //@TODO 未做 必要的检查，暂时先
            let permissions = role.permissions;
            if (Array.isArray(permissions)) {
                for (let permission of permissions) {
                    permission.roleId = newRole.id;
                    let newPermission = await models.Permission.create(permission, { transaction: t });
                    permission.id = newPermission.id;
                }
            }
            await t.commit();
            ctx.status = 200;
            role.id = newRole.id;
            ctx.body = role;
        } else {
            await t.rollback();
            ctx.status = 404;
            ctx.body = {
                name: 'invalid role',
                message: `invalid role ${id}`
            };
        }
    } else {
        ctx.status = 400;
        ctx.body = {
            name: 'invalid role group',
            message: `invalid role group name or desc`
        };
    }
};

let updateBasic = async function (ctx, next) {
    let id = ctx.params.id;
    let models = ctx.iota.dc.models;
    let role = ctx.request.body;
    if (role
        && Validator.isCommonName(role.name)
        && Validator.isCommonDesc(role.desc)) {
        let record = {
            name: role.name,
            desc: role.desc
        };
        let result = await models.Role.update(
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
                name: 'invalid role',
                message: `invalid role ${id}`
            };
        }
    } else {
        ctx.status = 400;
        ctx.body = {
            name: 'invalid role group',
            message: `invalid role group name or desc`
        };
    }
};


let update = async function (ctx, next) {
    let roleId = ctx.params.roleId;
    let models = ctx.iota.dc.models;
    let role = ctx.request.body;
    if (role
        && (role.name ? Validator.isCommonName(role.name) : true)
        && (role.desc ? Validator.isCommonDesc(role.desc) : true)) {
        let t = await ctx.iota.dc.orm.transaction();
        let record = {};
        if (role.name != undefined) {
            record.name = role.name;
        }
        if (role.desc != undefined) {
            record.desc = role.desc;
        }
        record.updatedAt = new Date();
        let result = await models.Role.update(
            record,
            { where: { id: roleId }, transaction: t }
        );
        let count = result[0];
        if (count === 1) {
            //删除该角色的权限
            await models.Permission.destroy({
                where: {
                    roleId: roleId
                },
                transaction: t
            });
            //@TODO 未做 必要的检查，暂时先
            let permissions = role.permissions;
            if (Array.isArray(permissions)) {
                for (let permission of permissions) {
                    permission.roleId = roleId;
                    let newPermission = await models.Permission.create(permission, { transaction: t });
                    permission.id = newPermission.id;
                }
            }
            await t.commit();
            ctx.status = 204;
            ctx.body = {};
        } else {
            await t.rollback();
            ctx.status = 404;
            ctx.body = {
                name: 'invalid role',
                message: `invalid role ${id}`
            };
        }
    } else {
        ctx.status = 400;
        ctx.body = {
            name: 'invalid role group',
            message: `invalid role group name or desc`
        };
    }
};

let _delete = async function (ctx, next) {
    const id = ctx.params.id;
    let ids = ctx.query.ids ? ctx.query.ids.split(',') : [];
    let createBy = ctx.session.user.id;
    let invalidGroups = false;
    let models = ctx.iota.dc.models;
    if (id) {
        ids.push(id);
    }
    ids = uniqueArray(ids);
    if (ids.length > 0) {
        let count = await models.Role.count({
            where: {
                id: {
                    $in: ids
                },
                createBy: createBy
            }
        });
        if (count < ids.length) {
            invalidGroups = true;
        }
    } else {
        invalidGroups = true;
    }
    if (invalidGroups) {
        ctx.status = 404;
        ctx.body = {
            name: 'invalid role',
            message: `the role ${ids} dose not exist.`
        };
        return;
    }
    let t = await ctx.iota.dc.orm.transaction();
    try {
        await models.Permission.destroy({
            where: {
                roleId: { $in: ids }
            },
            transaction: t
        });
        await models.Role.destroy({
            where: {
                id: { $in: ids }
            },
            transaction: t
        });
        await t.commit();
        ctx.status = 204;
        ctx.body = {}
    } catch (e) {
        await t.rollback();
        throw e;
    }
};


export default {
    create,
    find,
    update,
    updateBasic,
    _delete
}

