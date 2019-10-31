import mutations from './mutations'
import actions from './actions'
import Vue from 'vue'

import Menu from '../view/Menu'

Vue.component('ii-menu', Menu)

export default (opts) => {
    const { id, containerId } = opts
    const state = {
        menus: {
            roots: [{ children: [] }],
            idMap: [],
            pathMap: []
        }
    }
    const store = {
        modules: {
            iota: {
                modules: {
                    [containerId || 'container']: {
                        // 注入到 container
                        state: {
                            layout: {
                                console: {
                                    left: {
                                        middleItems: [{ component: 'ii-menu', props: { id, containerId } }]
                                    }
                                }
                            }
                        },
                        modules: {
                            [id || 'menu']: {
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