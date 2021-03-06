import mutations from './mutations'
import getters from './getters'
import actions from './actions'
import * as U from '../util'

// 注释部分为默认的基本 UserProfile Control，由于后续功能模块叠加，应该可以配置或覆盖
// import UserProfileControl from '../view/UserProfileControl'

export default (opts) => {
    // Vue.component('ii-user-profile-control', UserProfileControl)
    // const { containerId } = opts
    const store = {
        modules: {
            iota: {
                modules: {
                    // [containerId || 'container']: {
                    //     // 注入到 container, 这里有些别扭
                    //     state: {
                    //         layout: {
                    //             console: {
                    //                 head: {
                    //                     right: {
                    //                         items: [{ component: 'ii-user-profile-control' }]
                    //                     }
                    //                 }
                    //             }
                    //         }
                    //     }
                    // },
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