import mutations from './mutations'
import actions from './actions'

export default (opts) => {
    const { id, containerId } = opts
    const state = {}  // 如果需要使用全局的store，则需要区分出具体的流程相关数据
    const store = {
        modules: {
            iota: {
                modules: {
                    [containerId || 'container']: {
                        modules: {
                            [id || 'flowable']: {
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