import store from './store'
import messages from './view/locale'
import routes from './routes'

import createPermission from './components/Permission'
import Vue from 'vue'

const entry = (opts) => {
    Vue.use(createPermission(opts)) //注入全局的 权限判断模块
    return {
        store: store(opts),
        messages,
        routes: routes(opts)
    }
}

export {
    entry
}