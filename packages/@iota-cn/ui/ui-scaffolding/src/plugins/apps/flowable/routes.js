const SingleFlowable = () => import('./view/SingleFlowable')
const FlowsPortal = () => import('./view/FlowsPortal')
const Flowable = () => import('./view/console/Flowable')

export default (opts) => {
    const { id, containerId, path } = opts
    let routes = {}
    // 通用（all in one）流程管理模块
    routes.allinone = {
        portal: {
            path: '/console/flowables/portal',
            component: FlowsPortal,
            props: {
                id: id,
                containerId: containerId
            }
        },
        management: {
            path: '/console/flowables/instances',
            component: Flowable,
            props: {
                id: id,
                containerId: containerId
            }
        }
    }
    // 单一流程页面模块，根据路由参数切换, 放后面，防止前面的路由被覆盖
    routes.sigleflow = {
        path: `${path || '/console/flowables'}/:processDefinitionKey`,
        component: SingleFlowable,
        props: (route) => ({
            id: id,
            containerId: containerId,
            processDefinitionKey: route.params.processDefinitionKey
        })
    }
    return {
        iota: {
            [containerId || 'container']: {
                [id || 'flowables']: {
                    ...routes
                }
            }
        }
    }
}
