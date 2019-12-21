import mutations from './mutations'
import actions from './actions'

export default () => {
    const state = {
        settings: []
    }
    const store = {
        modules: {
            iota: {
                modules: {
                    global: {
                        state: {
                            initActions: [`iota/global/sysconfig/fetchSysconfig`]
                        },
                        modules: {
                            sysconfig: {
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