import * as T from './mutation-types'
import { silentGet } from '../../../../axios'

export default {
    async fetchMenus({ commit }) {
        return silentGet('/v1/api/authorizations/menus').then((res) => {
            if (res) {
                commit(T.FETCH_MENU, res.data.menus)
                return res
            }
        })
    },
    async fetchOperations({ commit }, that) {
        return silentGet('/v1/api/authorizations/operations').then((res) => {
            if (res) {
                // 注入 全局 RBAC的 operations
                if (that.$rbac) {
                    that.$rbac.operations = res.data.operations
                }
                commit(T.FETCH_OPERATIONS, res.data.operations)
                return res
            }
        })
    }
}