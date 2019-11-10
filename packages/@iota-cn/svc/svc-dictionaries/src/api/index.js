import { createMiddleware } from '@iota-cn/svc-util'
import * as Dictionary from './dictionary'

export default function (app, router, opts) {
    const models = app.iota.dc.models
    const restful = app.iota.restful

    const dictionaries = restful.resource({
        model: models.Dictionary,
        endpoints: ['/dictionaries'],
        search: [
            { operator: '$eq', param: 'key', attributes: ['key'] },
            { operator: '$eq', param: 'name', attributes: ['name'] },
            { operator: '$eq', param: 'belongTo', attributes: ['belongTo'] },
        ],
        actions: ['list', 'create']
    })

    if (app && app.iota && app.iota.restful && typeof app.iota.restful.createNormalizerAfter === 'function') {
        dictionaries.list.send.after(app.iota.restful.createNormalizerAfter("dictionaries"))
    }

    const dictionaryById = restful.resource({
        model: models.Dictionary,
        associations: true,
        endpoints: ['/dictionaries/:id'],
        // include: [{
        //     model: models.DictionaryItem, as: 'items',
        //     attributes: ['id', 'key', 'name']
        // }],
        actions: ['read', 'update', 'delete']
    })

    router.post('/dictionaries/:dictionaryId/items', createMiddleware(Dictionary.createItem))
    router.put('/dictionaries/:dictionaryId/items/:id', createMiddleware(Dictionary.updateItem))
    router.delete('/dictionaries/:dictionaryId/items/:id', createMiddleware(Dictionary.deleteItem))
}