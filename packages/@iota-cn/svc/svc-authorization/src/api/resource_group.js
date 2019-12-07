import { Validator } from '@iota-cn/util-validation';
import { uniqueArray, valBetween } from '@iota-cn/svc-util';

let create = async function (ctx, next) {
    const createBy = ctx.session.user.id;
    const models = ctx.iota.dc.models;
    const rsGroup = ctx.request.body ? ctx.request.body : {};
    let resources = rsGroup.resources ? rsGroup.resources : [];
    let count = await models.ResourceGroup.count({
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
    if (Validator.isCommonName(rsGroup.name) && Validator.isCommonDesc(rsGroup.desc) && Array.isArray(resources)) {
        let invalidRs = false;
        //@TODO uniqueArray with key and type
        resources = uniqueArray(resources, ['key', 'type']);
        for (let resource of resources) {
            if (resource.key && resource.type) {
                //判断资源类型是否存在
                let rsType = await models.ResourceType.findOne({ where: { type: resource.type } });
                if (rsType && models[rsType.model]) {
                    //判断实际资源是否存在
                    let rsRecord = await models[rsType.model].findOne({
                        where: { [rsType.idField]: resource.key, createBy: createBy },
                        attributes: [[rsType.idField, 'id'], [rsType.nameField, 'name'], [rsType.descField, 'desc']]
                    });
                    if (rsRecord) {
                        resource.name = resource.name ? resource.name : rsRecord.name;
                        resource.desc = resource.desc ? resource.desc : rsRecord.desc;
                    }
                    invalidRs = rsRecord ? false : true;
                    if (invalidRs) {
                        break;
                    }
                } else {
                    invalidRs = true;
                    break;
                }
            } else {
                invalidRs = true;
                break;
            }
        }
        if (invalidRs) {
            ctx.status = 400;
            ctx.body = {
                name: 'invalid resource',
                message: `invalid resource, resource: ${JSON.stringify(rsGroup)}`
            };
            return;
        } else {
            let t = await ctx.iota.dc.orm.transaction();
            try {
                let newRsGroup = await models.ResourceGroup.create({
                    name: rsGroup.name,
                    desc: rsGroup.desc,
                    createBy
                }, { transaction: t });
                await Promise.all(resources.map(async function (resource, i) {
                    return await models.Resource.create({
                        resourceGroupId: newRsGroup.id,
                        name: resource.name,
                        type: resource.type,
                        desc: resource.desc,
                        key: resource.key,
                        createBy
                    }, { transaction: t });
                }));
                await t.commit();
                ctx.status = 200;
                rsGroup.id = newRsGroup.id;
                ctx.body = rsGroup;
            } catch (err) {
                await t.rollback();
                throw err;
            }
        }
    } else {
        ctx.status = 400;
        ctx.body = {
            name: 'invalid request',
            message: 'invalid name or desc'
        };
    }
};

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
        limit: limit,
        offset: offset,
        order: [[orderBy, orderDirection]]
    };
    if (id) {
        condition.where.id = id;
    }
    let rsGroupWithResources = await models.ResourceGroup.findAndCountAll(condition);
    ctx.status = 200;
    ctx.body = {
        count: rsGroupWithResources.count,
        resourceGroups: rsGroupWithResources.rows
    };
    //规范化返回
    if (ctx.iota.restful && typeof ctx.iota.restful.createNormalizer === 'function') {
        ctx.iota.restful.createNormalizer('resourceGroups')(ctx);
    }
};

let update = async function (ctx, next) {
    let id = ctx.params.id;
    let models = ctx.iota.dc.models;
    let resourceGroup = ctx.request.body;
    if (resourceGroup
        && (resourceGroup.name ? Validator.isCommonName(resourceGroup.name) : true)
        && (resourceGroup.desc ? Validator.isCommonDesc(resourceGroup.desc) : true)) {
        let record = {
            name: resourceGroup.name,
            desc: resourceGroup.desc
        };
        let result = await models.ResourceGroup.update(
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
                name: 'invalid resource group',
                message: `invalid resource group ${id}`
            };
        }
    } else {
        ctx.status = 400;
        ctx.body = {
            name: 'invalid resource group',
            message: `invalid resource group name or desc`
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
        let count = await models.ResourceGroup.count({
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
            name: 'invalid resource group',
            message: `the resource group ${ids} dose not exist.`
        };
        return;
    }
    let t = await ctx.iota.dc.orm.transaction();
    try {
        await models.Resource.destroy({
            where: {
                resourceGroupId: { $in: ids }
            },
            transaction: t
        });
        await models.ResourceGroup.destroy({
            where: {
                id: { $in: ids }
            },
            transaction: t
        });
        await t.commit();
        ctx.status = 204;
        ctx.body = {};
    } catch (e) {
        await t.rollback();
        throw e;
    }
};

let findNotAssignToUserGroup = async function (ctx, next) {
    const createBy = ctx.session.user.id;
    const userGroupId = ctx.params.userGroupId;
    const limit = valBetween(ctx.query.limit, 1, 200, 20);
    const offset = parseInt(ctx.query.offset) || 0;
    const orderBy = ctx.query.orderBy || 'createdAt';
    const orderDirection = ctx.query.orderDirection || 'DESC';
    const dc = ctx.iota.dc;
    const models = ctx.iota.dc.models;
    //过滤该用户组 从 Authorization获取
    let filterQuery = dc.orm.dialect.QueryGenerator.selectQuery('Authorization', {
        where: {
            userGroupId: userGroupId,
            createBy: createBy
        },
        attributes: ['resourceGroupId']
    }).slice(0, -1);
    let condition = {
        where: {
            createBy: createBy,
            id: { $notIn: dc.orm.literal(`(${filterQuery})`) }
        },
        limit: limit,
        offset: offset,
        distinct: true,
        include: [
            {
                model: models.Resource,
                as: 'resources'
            }
        ],
        order: [[orderBy, orderDirection]]
    };
    let rsGroupWithResources = await models.ResourceGroup.findAndCountAll(condition);
    ctx.status = 200;
    ctx.body = {
        count: rsGroupWithResources.count,
        resourceGroups: rsGroupWithResources.rows
    };
    //规范化返回
    if (ctx.iota.restful && typeof ctx.iota.restful.createNormalizer === 'function') {
        ctx.iota.restful.createNormalizer('resourceGroups')(ctx);
    }
};

export default {
    create,
    find,
    update,
    _delete,
    //find not assign to userGroup
    findNotAssignToUserGroup
}