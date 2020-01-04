import store from './store'
import messages from './view/locale'
import routes from './routes'

import createPermission from './components/Permission'
import Tagbar from './components/Tagbar'

import Menu from './view/menu/Menu'
import UserProfileControl from './view/profile/UserProfileControl'

const entry = (opts, Vue) => {
    /**
     * 注入组件，在store里作为动态组件使用
     */
    Vue.component('ii-rbac-menu', Menu)
    Vue.component('ii-user-profile-control', UserProfileControl)
    Vue.component('ii-tagbar', Tagbar)
    //注入全局的 权限判断模块
    Vue.use(createPermission(opts))
    return {
        store: store(opts),
        messages,
        routes: routes(opts)
    }
}

export {
    entry
}