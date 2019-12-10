/**
 * 强制路由刷新
 * @param {} flowId 
 */
const createFlowableContainer = (flowId) => {
    const Flowable = () => import("./view/console/Flowable")
    return {
        props: ['flowId', 'flowHelper'],
        name: flowId,
        components: {
            flowable: Flowable
        },
        render() {
            return (<flowable flowId={this.flowId} flowHelper={this.flowHelper} />)
        }
    }
}

export default (opts) => {
    const containerId = opts.containerId
    let routes = {}
    opts.flows.forEach(f => {
        routes[f.flowId] = {
            path: f.path,
            component: createFlowableContainer(f.flowId),
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
