import { createMiddleware } from '@iota-cn/svc-util'
// import * as CommunistPartyProcessCategory from './communist_party_process_category'

export default function (app, router, opts) {
    const models = app.iota.dc.models
    const restful = app.iota.restful

    const communistPartyProcessCategories = restful.resource({
        model: models.CommunistPartyProcessCategory,
        endpoints: ['/communist_party/processes/categories'],
        actions: ['list', 'create']
    })

    if (app && app.iota && app.iota.restful && typeof app.iota.restful.createNormalizerAfter === 'function') {
        communistPartyProcessCategories.list.send.after(app.iota.restful.createNormalizerAfter("categories"))
    }
    // const communistPartyProcessCategoryById = 

    restful.resource({
        model: models.CommunistPartyProcessCategory,
        endpoints: ['/communist_party/processes/categories/:id'],
        // include: [{
        //     model: models.DictionaryItem, as: 'items',
        //     attributes: ['id', 'key', 'name']
        // }],
        actions: ['read', 'update', 'delete']
    })
}