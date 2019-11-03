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
}