import { createMiddleware } from '@iota-cn/svc-util'
import HttpProxy from 'http-proxy'
import Router from 'koa-router'
import axios from 'axios'
import FormData from 'form-data'

export default function (app, router, opts) {
    const models = app.iota.dc.models
    const restful = app.iota.restful
    // proxy to flowabale
    const flowable = opts.flowable || {
        routes: ['/fl/process/*', '/fl/content/*'],
        target: 'http://localhost:8888'
    }

    // delete @Todo flowable 不支持按照 processDefinitionKey 删除
    router.delete('/processdefs/:processDefinitionKey', createMiddleware(async (ctx, next) => {
        const processDefinitionKey = ctx.params.processDefinitionKey
        await axios.delete(`${flowable.target}/fl/process/repository/deployments/${processDefinitionKey}`)
            .then(async () => {
                await models.ProcessDef.destroy({ where: { processDefinitionKey: processDefinitionKey } })
                ctx.status = 204
            })
            .catch(async (err) => {
                console.log(err.response)
                switch (err.response.status) {
                    case 404:
                        await models.ProcessDef.destroy({ where: { processDefinitionKey: processDefinitionKey } })
                        ctx.status = 204
                        break;
                    default:
                        ctx.status = 500
                        break;
                }
            })
    }))

    // deploy
    router.post('/processdefs/deploy/:processDefinitionKey', createMiddleware(async (ctx, next) => {
        const processDefinitionKey = ctx.params.processDefinitionKey
        const processdef = await models.ProcessDef.findOne({ where: { processDefinitionKey: processDefinitionKey } })
        if (!processdef || !processdef.bpmnXML) {
            ctx.status = 404
            ctx.body = {
                message: 'invalid processdef or bpmn definition'
            }
            return
        }
        const form = new FormData()
        form.append('deployment', Buffer.from(processdef.bpmnXML, 'UTF-8'), `${processDefinitionKey}.bpmn20.xml`);
        await axios.post(encodeURI(`${flowable.target}/fl/process/repository/deployments?deploymentKey=${processDefinitionKey}&deploymentName=${processdef.name}`),
            form,
            { headers: form.getHeaders(), }
        ).then(async (res) => {
            await models.ProcessDef.update({ deployed: true }, { where: { processDefinitionKey: processDefinitionKey } })
            ctx.status = 204
        }).catch((err) => {
            ctx.status = 500
            ctx.body = {
                message: err
            }
        })
    }))

    const processdefs = restful.resource({
        model: models.ProcessDef,
        endpoints: ['/processdefs', '/processdefs/:processDefinitionKey'],
        search: [
            { param: 'name', attributes: ['name'] },
            { operator: '$eq', param: 'belongTo', attributes: ['belongTo'] },
        ],
        excludeAttributes: ['bpmnXML'],
        actions: ['list', 'create', 'read', 'update']
    })

    if (app && app.iota && app.iota.restful && typeof app.iota.restful.createNormalizerAfter === 'function') {
        processdefs.list.send.after(app.iota.restful.createNormalizerAfter("processdefs"))
    }

    // include_bpmn
    const processdefsIncludeBpmn = restful.resource({
        model: models.ProcessDef,
        endpoints: ['/processdefs_include_bpmn'],
        search: [
            { param: 'name', attributes: ['name'] },
            { operator: '$eq', param: 'belongTo', attributes: ['belongTo'] },
        ],
        actions: ['list'],
        sort: {
            default: 'updatedAt',
            param: 'orderBy'
        }
    })

    if (app && app.iota && app.iota.restful && typeof app.iota.restful.createNormalizerAfter === 'function') {
        processdefsIncludeBpmn.list.send.after(app.iota.restful.createNormalizerAfter("processdefs"))
    }

    // proxy to flowabale
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