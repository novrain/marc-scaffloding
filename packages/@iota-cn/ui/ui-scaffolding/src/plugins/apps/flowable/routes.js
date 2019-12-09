const Flowable = () => import("./view/console/Flowable")

export default (opts) => {
    const containerId = opts.containerId
    let routes = {}
    opts.flows.forEach(f => {
        routes[f.key] = {
            path: f.path,
            component: Flowable,
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
