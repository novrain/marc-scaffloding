import mutations from './mutations'
import getters from './getters'
import actions from './actions'
import * as U from '../util'

export default (opts) => {
    const store = {
        modules: {
            iota: {
                modules: {
                    global: {
                        modules: {
                            authentication: {
                                // no namespace 统一到 iota/global
                                state: {
                                    user: U.createEmptyUser(),
                                    // ...opts
                                },
                                mutations,
                                getters,
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