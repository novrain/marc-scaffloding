import * as T from './mutation-types'
import merge from 'deepmerge'

export default () => {
    return {
        [T.FETCH_SYSCONFIG](state, settings) {
            state.settings = merge(state.settings, settings)
        },
        [T.UPDATE_SYSCONFIG](state, settings) {
            state.settings = merge(state.settings, settings)
        }
    }
}