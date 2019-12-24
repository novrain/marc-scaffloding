const SingleFlowable = () => import('./view/SingleFlowable')

export default (opts) => {
    const { id, containerId, path } = opts
    let routes = {
        path: `${path || '/console/flowable'}/:processDefinitionKey`,
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
                flowable: {
                    ...routes
                }
            }
        }
    }
}
