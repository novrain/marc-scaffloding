import LayoutContainer from './view/LayoutContainer'
import SinglePageLayout from './view/SinglePageLayout'
import MessageCenter from './mixins/MessageCenter'
import { AuthenticationInterceptor, TrySigninInterceptor } from '../mixins'

export default (opts) => {
    let { simple, complex } = opts
    complex = complex || {}
    const { id, path, redirect, authFailRedirect } = complex
    let routes = {
        iota: {
            [id || 'container']: { // root(empty) / container
                path: path || '/container',
                redirect: redirect, // 可以覆盖默认路由
                component: {
                    mixins: [// 这里混入两个组件，这样减少依赖，注意顺序
                        TrySigninInterceptor,
                        AuthenticationInterceptor,
                        MessageCenter,
                        LayoutContainer
                    ]
                },
                props: { id, authFailRedirect },
            }
        }
    }
    if (simple) {
        routes.iota[simple.path] = { // root(empty) / simple
            path: simple.path,
            redirect: simple.redirect, // 可以覆盖默认路由
            component: SinglePageLayout,
            props: simple || {}
        }
    }
    return routes
}
