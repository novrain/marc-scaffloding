import mutations from './mutations'
import actions from './actions'

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
                            initActions: [`iota/${containerId}/${id}/fetchOperations`],
                            layout: {
                                console: {
                                    left: {
                                        middle: {
                                            items: [{ component: 'ii-rbac-menu', props: { id, containerId } }]
                                        }
                                    },
                                    head: {
                                        right: {
                                            items: [{ component: 'ii-user-profile-control' }]
                                        }
                                    }
                                }
                            }
                        },
                        modules: {
                            [id || 'rbac']: {
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