import { silentGet } from '@iota-cn/ui-scaffolding/src/axios'

export default (opts) => {
    const { flowableId, overviewId, flowablePath, containerId } = opts
    return {
        loadWidgets({ dispatch }) {
            silentGet('/v1/api/applications/processdefs/widgets').then((res) => {
                if (res) {
                    let widgets = []
                    res.data.widgets.forEach(w => {
                        if (w.widget) {
                            widgets.push({
                                component: w.widget,
                                props: {
                                    id: flowableId,
                                    containerId: containerId,
                                    processDefinitionKey: w.processDefinitionKey,
                                    redirect: `${flowablePath}/${w.processDefinitionKey}`
                                }
                            })
                        }
                    })
                    if (widgets.length > 0) {
                        dispatch(`iota/${containerId}/${overviewId}/registerWidgets`, widgets, { root: true })
                    }
                }
            })
        }
    }
}