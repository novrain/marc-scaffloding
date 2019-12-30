import merge from 'deepmerge'
import mutations from './mutations'
import getters from './getters'

export default (opts) => {
    const { id } = opts.complex
    const state = {
        initActions: [],
        messageCenter: {
            // actions 注册地
            actions: {

            },
            messageRooms: []
        },
        // 两种固定布局
        layout: {
            // type: 外部指定以下两种
            normal: {// 上下结构
                head: {
                    right: {
                        items: []
                    },
                    menu: {
                        items: [],
                    },
                    left: {
                        items: []
                    }
                }
            },
            console: {// 控制台，左右（上下）
                head: {
                    left: {
                        items: [{ component: 'ii-collapsed-control', props: { id: id } }]
                    },
                    right: {
                        items: []
                    }
                },
                navigation: {
                    bar: {
                        items: []
                    },
                },
                left: {
                    collapsed: false,
                    top: {
                        items: []
                    },
                    middle: {
                        items: []
                    },
                    bottom: {
                        items: []
                    }
                }
            }
        }
    }
    const store = {
        modules: {
            iota: {
                modules: {
                    [id || 'container']: {
                        namespaced: true,
                        //全局state
                        state,
                        modules: { // for children
                        },
                        mutations,
                        getters,
                    }
                }
            }
        }
    }
    let containerStore = merge(store.modules.iota.modules[id || 'container'].state, { messageCenter: opts.messageCenter, ...opts.complex })
    store.modules.iota.modules[id || 'container'].state = containerStore
    return store
}