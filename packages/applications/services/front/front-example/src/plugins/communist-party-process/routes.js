

/**
 * 强制路由刷新
 * @param {} flowId 
 */
const createFlowableContainer = (flowId) => {
    const CommunistPartyProcess = () => import("./view/CommunistPartyProcess")
    return {
        props: ['flowId', 'flowHelper'],
        name: flowId,
        components: {
            flowable: CommunistPartyProcess
        },
        render() {
            return (<flowable flowId={this.flowId} flowHelper={this.flowHelper} />)
        }
    }
}

export default (opts) => {
    const { id, containerId } = opts
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
                [id || 'communist_party_process']: {
                    ...routes
                }
            }
        }
    }
}
