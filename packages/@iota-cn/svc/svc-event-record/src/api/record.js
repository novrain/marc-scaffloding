import {
    valBetween
} from '@iota-cn/svc-util'

const findAllRecord = async (ctx, next) => {
    let models = ctx.iota.dc.models;
    let limit = valBetween(ctx.query.limit, 1, 200, 80);
    let offset = parseInt(ctx.query.offset) || 0;
    let orderBy = ctx.query.order_by || 'createdAt';
    let orderDirection = ctx.query.order_direction || 'DESC';
    let logType = ctx.query.logType

    let records

    let condition = {
        limit: limit,
        offset: offset,
        order: [
            [orderBy, orderDirection]
        ]
    }

    let recordCondition = {
        where: {
            log_type: logType
        },
        limit: limit,
        offset: offset,
        order: [
            [orderBy, orderDirection]
        ]
    }
    if (logType) {
        recordCondition.where = Object.assign({
            log_type: logType
        }, recordCondition.where);

        records = await models.EventRecord.findAndCountAll(recordCondition)
    } else {
        records = await models.EventRecord.findAndCountAll(condition)
    }

    ctx.status = 200
    ctx.body = {
        count: records.count,
        records: records.rows
    }
    if (ctx.iota.restful && typeof ctx.iota.restful.createNormalizer === 'function') {
        ctx.iota.restful.createNormalizer('records')(ctx);
    }
}

export {
    findAllRecord
}