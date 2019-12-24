import mutations from './mutations'
import actions from './actions'
import getters from './getters'

export default (opts) => {
    const { id, containerId } = opts
    // 流程的定义、帮助类
    const state = {
        processdefs: {},
        helpers: {}
    }
    const store = {
        modules: {
            iota: {
                modules: {
                    [containerId || 'container']: {
                        modules: {
                            [id || 'flowable']: {
                                namespaced: true,
                                state,
                                mutations: mutations(opts),
                                actions: actions(opts),
                                getters: getters(opts)
                            }
                        }
                    }
                }
            }
        }
    }
    return store
}