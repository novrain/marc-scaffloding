import * as T from './mutation-types'
import { silentGet } from '../../../../axios'

export default () => {
    // const { id, containerId } = opts
    return {
        async fetchProcessDef({ dispatch, commit, state }, { processDefinitionKey, vm }) {
            let processdef = state.processdefs[processDefinitionKey]
            if (processdef) {
                let helperScript = processdef.helperScript
                if (helperScript) {
                    let helper = state.helpers[processDefinitionKey]
                    if (helper) {
                        return processdef
                    }
                    else {
                        return dispatch('loadHelper', { vm, processDefinitionKey, helperScript: processdef.helperScript })
                            .then(() => {
                                return processdef
                            })
                    }
                }
                return processdef
            }
            return silentGet(`/v1/api/processdefs/${processDefinitionKey}`).then((res) => {
                if (res) {
                    processdef = res.data
                    commit(T.FETCH_PROCESSDEF, { [processDefinitionKey]: processdef })
                    if (processdef.helperScript) { // 如果有辅助脚本，这个时候加载
                        return dispatch('loadHelper', { vm, processDefinitionKey, helperScript: processdef.helperScript })
                            .then(() => {
                                return processdef
                            })
                    }
                    return processdef
                }
            })
        },
        async fetchProcessDefs({ commit, state }) {
            if (Object.keys(state.processdefs).length > 0) {
                return state.processdefs
            }
            return silentGet('/v1/api/processdefs').then((res) => {
                if (res) {
                    let processdefs = {}
                    res.data.processdefs.forEach(def => {
                        processdefs[def.processDefinitionKey] = def
                        // if (def.helperScript) { // 如果有辅助脚本，这个时候加载 @Todo 数量过多的情况，不合适，需要懒加载
                        //     dispatch('loadHelper', { vm, processDefinitionKey: def.processDefinitionKey, helperScript: def.helerpScript })
                        // }
                    })
                    commit(T.FETCH_PROCESSDEFS, processdefs)
                    return res.data.processdefs
                }
            })
        },
        async loadHelper({ commit }, { vm, processDefinitionKey, helperScript }) {
            return vm.$loadScript(helperScript).then(
                () => commit(T.LOAD_HELPER_SCRIPT, { [processDefinitionKey]: window.$IOTA_FLOW_HELPERS[processDefinitionKey] })
            )
        },
        updateHelper({ commit }, helper) {
            commit(T.LOAD_HELPER_SCRIPT, helper)
        }
    }
}