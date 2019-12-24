import * as T from './mutation-types'
import { silentGet } from '../../../../axios'

export default () => {
    // const { id, containerId } = opts
    return {
        async fetchProcessDef({ commit }, { processDefinitionKey, vm }) {
            return silentGet(`/v1/api/processdefs/${processDefinitionKey}`).then((res) => {
                if (res) {
                    commit(T.FETCH_PROCESSDEF, { [processDefinitionKey]: res.data })
                    if (res.data.helperScript) { // 如果有辅助脚本，这个时候加载
                        vm.$loadScript(res.data.helperScript).then(
                            () => commit(T.LOAD_HELPER_SCRIPT, { [processDefinitionKey]: window.$IOTA_FLOW_HELPERS[processDefinitionKey] })
                        )
                    }
                    return res
                }
            })
        },
        async fetchProcessDefs({ commit }) {
            return silentGet('/v1/api/processdefs').then((res) => {
                if (res) {
                    let processdefs = {}
                    res.data.processdefs.forEach(def => {
                        processdefs[def.processDefinitionKey] = def
                    })
                    commit(T.FETCH_PROCESSDEFS, processdefs)
                    return res.data.processdefs
                }
            })
        },
        updateHelper({ commit }, helper) {
            commit(T.LOAD_HELPER_SCRIPT, helper)
        }
    }
}