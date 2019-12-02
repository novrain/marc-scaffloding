import Flowable from "./view/console/Flowable";

export default (opts) => {
    const containerId = opts.containerId
    let routes = {}
    opts.flows.forEach(f => {
        routes[f.key] = {
            path: f.path,
            component: {
                // mixins: [Flowable, ...(f.mixins || [])]
                mixins: [Flowable]  // 目前混入在第一层没有意义
            },
            props: { flowId: f.flowId, flowHelper: f.flowHelper }
        }
    })
    return {
        iota: {
            [containerId || 'container']: {
                flowable: {
                    ...routes
                }
            }
        }
    }
}
