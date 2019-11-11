export const createItem = async (ctx, next) => {
    const models = ctx.iota.dc.models
    const dictionaryId = ctx.params.dictionaryId
    let item = ctx.request.body
    if (item && dictionaryId && item.key && item.name) {
        try {
            const conflict = await models.DictionaryItem.findOne({
                where: {
                    $or: [{ key: item.key }, { name: item.name }],
                    dictionaryId: dictionaryId
                }
            })
            if (conflict) {
                ctx.status = 409
                ctx.body = {
                    name: 'conflicted item',
                    message: 'item exist with same key'
                }
                return
            }
            item.dictionaryId = dictionaryId
            let newitem = await models.DictionaryItem.create(item)
            ctx.status = 200
            ctx.body = newitem
        } catch (e) {
            throw e
        }
    } else {
        ctx.status = 400
        ctx.body = {
            name: 'validation error',
            message: 'invalid request message framing, malformed request syntax,or deceptive request routing.',
            detail: 'lack of necessary parameters.'
        }
    }
}

export const updateItem = async (ctx, next) => {
    const id = ctx.params.id
    const models = ctx.iota.dc.models
    const dictionaryId = ctx.params.dictionaryId
    let item = ctx.request.body
    if (item && dictionaryId) {
        try {
            const conflict = await models.DictionaryItem.findOne({
                where: {
                    key: item.key,
                    dictionaryId: dictionaryId,
                    id: { $not: id }
                }
            })
            if (conflict) {
                ctx.status = 409
                ctx.body = {
                    name: 'conflicted item',
                    message: 'item exist with same key'
                }
                return
            }
            let result = await models.DictionaryItem.update(item, {
                where: {
                    id: id,
                    dictionaryId: dictionaryId
                }
            })
            let count = result[0]
            if (count === 1) {
                ctx.status = 204
                ctx.body = {}
            } else {
                ctx.status = 404
                ctx.body = {
                    name: 'invalid dictionary item',
                    message: `invalid dictionary item ${id}`
                }
            }
        } catch (e) {
            throw e
        }
    } else {
        ctx.status = 400
        ctx.body = {
            name: 'invalid dictionary item',
            message: `invalid item or dictionary id`
        }
    }
}

export const deleteItem = async (ctx, next) => {
    const id = ctx.params.id
    const dictionaryId = ctx.params.dictionaryId
    const models = ctx.iota.dc.models
    if (dictionaryId && id) {
        try {
            let result = await models.DictionaryItem.destroy({
                where: { id: id, dictionaryId: dictionaryId },
                individualHooks: true
            })
            if (result === 1) {
                ctx.status = 204
                ctx.body = {}
            } else {
                ctx.status = 404
                ctx.body = {
                    name: 'invalid device',
                    message: `the device ${id} dose not exist.`
                }
            }
        } catch (e) {
            throw e
        }
    } else {
        ctx.status = 400
        ctx.body = {
            name: 'validation error',
            message: 'lack of necessary parameters.'
        }
    }
}
