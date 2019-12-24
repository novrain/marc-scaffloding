import mutations from './mutations'
import actions from './actions'

export default (opts) => {
    const { id, containerId } = opts
    const state = {}
    const store = {
        modules: {
            iota: {
                modules: {
                    [containerId || 'container']: {
                        state: {
                            initActions: [`iota/${containerId}/${id}/loadWidgets`]
                        },
                        modules: {
                            [id || 'communistPartyProcess']: {
                                namespaced: true,
                                state,
                                mutations,
                                actions: actions(opts)
                            }
                        }
                    }
                }
            }
        }
    }
    return store
}