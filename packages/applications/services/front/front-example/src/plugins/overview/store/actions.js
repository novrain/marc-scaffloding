import * as T from './mutation-types'

export default {
    registerWidgets({ commit }, widgets) {
        commit(T.REGISTER_WIDGETS, widgets)
    }
}