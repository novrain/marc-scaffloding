import mutations from './mutations'
import getters from './getters'
import actions from './actions'
import * as U from '../util'
import Vue from 'vue'
import UserProfileControl from '../view/UserProfileControl'

Vue.component('ii-user-profile-control', UserProfileControl)

export default (opts) => {
    const { containerId } = opts
    const store = {
        modules: {
            iota: {
                modules: {
                    [containerId || 'container']: {
                        // 注入到 container, 这里有些别扭
                        state: {
                            layout: {
                                console: {
                                    head: {
                                        right: {
                                            items: [{ component: 'ii-user-profile-control' }]
                                        }
                                    }
                                }
                            }
                        }
                    },
                    global: {
                        modules: {
                            authentication: {
                                // no namespace 统一到 iota/global
                                state: {
                                    user: U.createEmptyUser(),
                                    // ...opts
                                },
                                mutations: mutations(opts),
                                getters,
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