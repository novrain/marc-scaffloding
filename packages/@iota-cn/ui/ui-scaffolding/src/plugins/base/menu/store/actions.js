import * as T from './mutation-types'
import { commonGet } from '../../../../axios'

export default {
    async fetchMenus({ commit }) {
        return commonGet('/v1/api/authorizations/menus', { doNotHint: true }).then((res) => {
            commit(T.FETCH_MENU, res.data.menus)
            return res
        })
    },
}