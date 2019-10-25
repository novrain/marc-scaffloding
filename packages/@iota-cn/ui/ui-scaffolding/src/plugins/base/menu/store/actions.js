import * as T from './mutation-types'
import axios, { onErr } from '../../../../axios'

export default {
    async fetchMenus({ commit }) {
        return axios.get('/v1/api/authorizations/menus').then((res) => {
            commit(T.FETCH_MENU, res.data)
            return res
        }).catch(onErr)
    },
}