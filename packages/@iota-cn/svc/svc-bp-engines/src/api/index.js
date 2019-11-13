import { createMiddleware } from '@iota-cn/svc-util'

export default function (app, router, opts) {
    const models = app.iota.dc.models
    const restful = app.iota.restful

    const processdefs = restful.resource({
        model: models.ProcessDef,
        endpoints: ['/processdefs', '/processdefs/:id'],
        search: [
            { param: 'name', attributes: ['name'] },
            { operator: '$eq', param: 'belongTo', attributes: ['belongTo'] },
        ],
        actions: ['list', 'create', 'read', 'update', 'delete']
    })

    if (app && app.iota && app.iota.restful && typeof app.iota.restful.createNormalizerAfter === 'function') {
        processdefs.list.send.after(app.iota.restful.createNormalizerAfter("processdefs"))
    }
}