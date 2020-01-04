import * as T from './mutation-types'

export default () => {
    return {
        [T.REGISTER_WIDGETS](state, widgets) {
            state.widgets = state.widgets.concat(widgets)
        }
    }
}