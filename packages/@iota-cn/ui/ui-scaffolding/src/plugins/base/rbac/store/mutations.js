import * as T from './mutation-types'
import * as Util from '../util'

export default {
    [T.FETCH_MENU](state, menus) {
        state.menus = Util.convertMenus(menus)
    },
    [T.FETCH_OPERATIONS](state, operations) {
        state.operations = operations
    }
}