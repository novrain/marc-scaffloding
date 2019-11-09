/**
 * Created by rain on 2017/2/20.
 */
import { uniqueArray, valBetween } from '@iota-cn/svc-util';

let create = async function (ctx, next) {
    let resourceGroupId = ctx.params.resourceGroupId;
    let models = ctx.iota.dc.models;
    let resources = ctx.request.body.resources ? ctx.request.body.resources : [];
    let createBy = ctx.session.user.id;
    //判断group是否存在
    let rsGroup = await models.ResourceGroup.findOne({ where: { id: resourceGroupId } });
    let invalidRequest = false;
    if (rsGroup && Array.isArray(resources)) {
        resources = uniqueArray(resources, ['key', 'type']);
        for (let resource of resources) {
            if (resource && resource.type) {
                //判断资源类型是否存在
                let rsType = await models.ResourceType.findOne({ where: { type: resource.type } });
                //判断对应的模型是否存在
                if (rsType && rsGroup && models[rsType.model]) {
                    let rsRecord = await models[rsType.model].findOne({
                        where: {
                            [rsType.idField]: resource.key,
                            belongTo: createBy
                        },
                        attributes: [
                            [rsType.idField, 'id'],
                            [rsType.nameField, 'name']
                        ]
                    });
                    if (!rsRecord) {
                        invalidRequest = true;
                        break;
                    }
                } else {
                    invalidRequest = true;
                    break;
                }
            } else {
                invalidRequest = true;
                break;
            }
        }
    } else {
        invalidRequest = true;
    }
    if (!invalidRequest) {
        let t = await ctx.iota.dc.orm.transaction();
        try {
            for (let resource of resources) {
                let newResource = await models.Resource.create({
                    name: resource.name,
                    type: resource.type,
                    key: resource.key,
                    resourceGroupId: resourceGroupId,
                    createBy: createBy
                }, { transaction: t });
                resource.id = newResource.id;
            }
            await t.commit();
            ctx.status = 200;
            ctx.body = resources;
        } catch (e) {
            await t.rollback();
            throw e;
        }
    } else {
        ctx.status = 400;
        ctx.body = {
            name: 'validation error',
            message: 'invalid request message framing, malformed request syntax,or deceptive request routing.',
            detail: 'lack of necessary parameters.'
        };
    }
};

let update = async function (ctx, next) {
    let id = ctx.params.id;
    let resourceGroupId = ctx.params.resourceGroupId;
    let models = ctx.iota.dc.models;
    let resource = ctx.request.body;
    if (resource) {
        //// 先判断 old resource 是否存在
        //let oldRs = await models.Resource.findOne({
        //    where: {id: id}
        //});
        //判断资源类型是否存在
        let rsType = await models.ResourceType.findOne({ where: { type: resource.type } });
        //判断group是否存在
        let rsGroup = await models.ResourceGroup.findOne({ where: { id: resourceGroupId } });
        //判断对应的模型是否存在
        //if (oldRs && rsType && rsGroup && models[rsType.model]) {
        if (rsType && rsGroup && models[rsType.model]) {
            //判断实际资源是否存在
            let rsRecord = await models[rsType.model].findOne({
                where: {
                    [rsType.idField]: resource.key
                },
                attributes: [
                    [rsType.idField, 'id'],
                    [rsType.nameField, 'name']
                ]
            });
            if (rsRecord) {
                await models.Resource.update({
                    name: rsRecord.name,
                    key: rsRecord.id,
                    type: rsType.type
                }, {
                    where: { id: id, resourceGroupId: resourceGroupId }
                });
                ctx.status = 204;
                ctx.body = {};
            } else {
                ctx.status = 404;
                ctx.body = {
                    name: 'invalid resource key',
                    message: `the resource of ${resource.key} dose not exist.`,
                };
            }
        } else {
            ctx.status = 404;
            ctx.body = {
                name: 'invalid resource type or resource group or old resource.',
                message: `the resource type ${resource.type} or resource ${id} to be edit of resource group ${resourceGroupId}  dose not exist.`
            };
        }
    } else {
        ctx.status = 400;
        ctx.body = {
            name: 'validation error',
            message: 'invalid request message framing, malformed request syntax,or deceptive request routing.',
            detail: 'lack of necessary parameters.'
        };
    }
};

let _delete = async function (ctx, next) {
    const id = ctx.params.id;
    let ids = ctx.query.ids ? ctx.query.ids.split(',') : [];
    let resourceGroupId = ctx.params.resourceGroupId;
    let models = ctx.iota.dc.models;
    let invalid = false;
    if (id) {
        ids.push(id);
    }
    ids = uniqueArray(ids);
    if (ids.length > 0) {
        let result = await models.Resource.findAll({
            where: { id: { $in: ids }, resourceGroupId: resourceGroupId }
        });
        if (result.length < ids.length) {
            invalid = true;
        }
    } else {
        invalid = true;
    }
    if (invalid) {
        ctx.status = 404;
        ctx.body = {
            name: 'invalid resource',
            message: `the resource ${ids} of resource group ${resourceGroupId} dose not exist.`
        };
        return;
    }
    try {
        await models.Resource.destroy({
            where: { id: { $in: ids }, resourceGroupId: resourceGroupId }
        });
        ctx.status = 204;
        ctx.body = {};
    } catch (e) {
        throw e;
    }
};

let findResourceNotInGroup = async function (ctx, next) {
    const resourceGroupId = ctx.params.resourceGroupId;
    const type = ctx.params.type;
    const belongTo = ctx.session.user.id;
    const models = ctx.iota.dc.models;
    const dc = ctx.iota.dc;
    const limit = valBetween(ctx.query.limit, 1, 200, 20);
    const offset = parseInt(ctx.query.offset) || 0;
    const orderBy = ctx.query.orderBy || 'createdAt';
    const orderDirection = ctx.query.orderDirection || 'DESC';
    let resourceDef = await models.ResourceType.findOne({
        where: { type: type }
    });
    if (!resourceDef || !models[resourceDef.model]) {
        ctx.status = 400;
        ctx.body = {
            name: 'invalid request',
            message: 'invalid resource type'
        };
        return;
    }
    let filterCondition = {
        where: {
            type: type
        },
        attributes: ['key'],
        include: [{
            attributes: [],
            model: models.ResourceGroup,
            as: 'resourceGroup',
            where: {
                id: resourceGroupId,
                createBy: belongTo
            }
        }]
    };
    //trick 这是一个非常非常特殊的做法，不想使用多次查询
    const Model = require('@iota-fork/sequelize/lib/model')
    Model._validateIncludedElements.bind(models.Resource)(filterCondition);
    let filterQuery = models.Resource.QueryGenerator.selectQuery('Resource', filterCondition, models.Resource).slice(0, -1);
    let condition = {
        where: {
            belongTo: belongTo,
            id: { $notIn: dc.orm.literal(`(${filterQuery})`) }
        },
        limit: limit,
        offset: offset,
        order: [
            [orderBy, orderDirection]
        ]
    };
    let resources = await models[resourceDef.model].findAndCountAll(condition);
    ctx.status = 200;
    ctx.body = {
        count: resources.count,
        [resourceDef.key]: resources.rows
    };
    //规范化返回
    if (ctx.iota.restful && typeof ctx.iota.restful.createNormalizer === 'function') {
        ctx.iota.restful.createNormalizer(resourceDef.key)(ctx);
    }
};

let findResourceInGroup = async function (ctx, next) {
    const resourceGroupId = ctx.params.resourceGroupId;
    const id = ctx.params.id;
    const limit = valBetween(ctx.query.limit, 1, 200, 20);
    const offset = parseInt(ctx.query.offset) || 0;
    const orderBy = ctx.query.orderBy || 'createdAt';
    const orderDirection = ctx.query.orderDirection || 'DESC';
    let models = ctx.iota.dc.models;
    let condition = {
        where: {
            resourceGroupId: resourceGroupId
        },
        limit: limit,
        offset: offset,
        order: [
            [orderBy, orderDirection]
        ]
    };
    if (id) {
        condition.where.id = id;
    }
    let groupResources = await models.Resource.findAndCountAll(condition);
    ctx.status = 200;
    ctx.body = {
        count: groupResources.count,
        resources: groupResources.rows
    };
    //规范化返回
    if (ctx.iota.restful && typeof ctx.iota.restful.createNormalizer === 'function') {
        ctx.iota.restful.createNormalizer('resources')(ctx);
    }
};

export default {
    findResourceInGroup,
    findResourceNotInGroup,
    create,
    update,
    _delete
}