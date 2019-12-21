import * as T from './mutation-types'

export default () => {
    return {
        [T.FETCH_SYSCONFIG](state, settings) {
            state.settings = settings
        },
        [T.UPDATE_SYSCONFIG](state, setting) {
            state.settings = state.settings.map(s => {
                if (setting[s.key]) {
                    s.value = setting[s.key]
                }
                return s
            })
        }
    }
}