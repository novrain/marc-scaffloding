import * as T from './mutation-types'
import { silentGet } from '../../../../axios'

export default {
    async fetchSysconfig({ commit }) {
        return silentGet('/v1/api/sysconfig').then((res) => {
            if (res) {
                commit(T.FETCH_SYSCONFIG, res.data.settings.map(s => {
                    s.widgetSettings = JSON.parse(s.widgetSettings || '{}')
                    return s
                }))
                return res
            }
        })
    },
    async updateSysconfig({ commit }, values) {
        commit(T.UPDATE_SYSCONFIG, values)
        return
    }
}