export default () => {
    return {
        processdefs(state) {
            return state.processdefs
        },
        processdefsAsArray(state) {
            let keys = Object.keys(state.processdefs)
            return keys.map(k => {
                return state.processdefs[k]
            })
        },
        processdef(state) {
            return (processDefinitionKey) => {
                return state.processdefs[processDefinitionKey]
            }
        },
        helper(state) {
            return (processDefinitionKey) => {
                return state.helpers[processDefinitionKey]
            }
        },
        formDef(state) {
            return (processDefinitionKey) => {
                let processdef = state.processdefs[processDefinitionKey]
                return processdef ? processdef.formDef : undefined
            }
        }
    }
}