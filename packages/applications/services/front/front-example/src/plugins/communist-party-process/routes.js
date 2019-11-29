import CommunistPartyProcess from "./view/CommunistPartyProcess";

export default (opts) => {
    const containerId = opts.containerId
    const flow = opts.flow
    return {
        iota: {
            [containerId || 'container']: {
                'communist_party_process': {
                    path: '/console/applications/communist_party_process',
                    component: {
                        mixins: [CommunistPartyProcess]
                    },
                    props: { flowId: flow.flowId, flowFuncs: flow.flowFuncs }
                }
            }
        }
    }
}