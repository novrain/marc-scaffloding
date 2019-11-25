import mutations from './mutations'
import actions from './actions'

export default (opts) => {
    const { containerId } = opts
    const state = {}
    const store = {
        modules: {
            iota: {
                modules: {
                    [containerId || 'container']: {
                        modules: {
                            communistPartyProcess: {
                                namespaced: true,
                                state,
                                mutations,
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