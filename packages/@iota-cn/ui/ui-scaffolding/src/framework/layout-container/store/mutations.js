import * as T from './mutation-types'

export default {
    [T.REGISTER_MESSAGE_ACTIONS](state, { type, actions }) {
        let currentActions = state.messageCenter.actions[type] || []
        state.messageCenter.actions[type] = currentActions.concat(actions)
    },
    [T.LEFT_COLLAPSE](state) {
        state.layout.console.left.collapsed = !state.layout.console.left.collapsed
    },
    [T.CACHED_VIEWS](state, views) {
        state.cachedViews = views
    }
}