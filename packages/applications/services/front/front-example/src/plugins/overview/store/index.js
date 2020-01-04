import mutations from './mutations'
import actions from './actions'

export default (opts) => {
    const { containerId, id } = opts
    const state = {
        widgets: []
    }
    const store = {
        modules: {
            iota: {
                modules: {
                    [containerId || 'container']: {
                        modules: {
                            [id || 'app-overview']: {
                                namespaced: true,
                                state,
                                mutations: mutations(),
                                actions
                            }
                        }
                    }
                }
            }
        }
    }
    return store
}