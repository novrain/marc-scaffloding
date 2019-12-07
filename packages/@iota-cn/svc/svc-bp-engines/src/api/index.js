import { createMiddleware } from '@iota-cn/svc-util'
import HttpProxy from 'http-proxy'
import Router from 'koa-router'

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

    // proxy to flowabale
    const flowable = opts.flowable || {
        routes: ['/fl/process/*', '/fl/content/*'],
        target: 'http://localhost:8888'
    }

    const handler = async (ctx, next) => {
        await new Promise((reject, resolve) => {
            const reqOpts = {
                target: flowable.target
            }
            proxyServer.web(ctx.req, ctx.res, reqOpts, function (e) {
                ctx.iota.logger.log('error', e)
                resolve(); // resolve anyway
            });
        });
    }
    const proxyServer = new HttpProxy()

    const flowableRouter = new Router()
    flowable.routes.forEach(r => {
        flowableRouter.all(r, handler)
    })
    return { subRouter: flowableRouter }
}