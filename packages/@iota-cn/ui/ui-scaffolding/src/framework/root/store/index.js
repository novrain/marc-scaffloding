import mutations from './mutations'

export default {
    modules: {
        iota: {
            namespaced: true,
            //全局state
            state: {},
            modules: {
                global: {
                    namespaced: true,
                    state: {
                        theme: 'default',
                        lang: 'zh-cn',
                        initActions: []
                    },
                    mutations,
                    modules: {
                    }
                }
            }
        }
    }
}
