import mutations from './mutations'
import menus from './mock'
import * as Util from '../util'
import Vue from 'vue'

import Menu from '../view/Menu'

Vue.component('ii-menu', Menu)

export default (opts) => {
    const { id, containerId } = opts
    const state = {
        menus: Util.convertMenus(menus)
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
                            }
                        }
                    }
                }
            }
        }
    }
    return store
}