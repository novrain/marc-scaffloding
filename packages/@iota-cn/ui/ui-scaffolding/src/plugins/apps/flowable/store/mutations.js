import * as T from './mutation-types'
import merge from 'deepmerge'

export default () => {
    return {
        [T.FETCH_PROCESSDEF](state, processdef) {
            state.processdefs = merge(state.processdefs, processdef)
        },
        [T.FETCH_PROCESSDEFS](state, processdefs) {
            state.processdefs = processdefs
        },
        [T.LOAD_HELPER_SCRIPT](state, helper) {
            state.helpers = merge(state.helpers, helper)
        }
    }
}