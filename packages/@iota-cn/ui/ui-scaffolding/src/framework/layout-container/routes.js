import LayoutContainer from './view/LayoutContainer'
import SinglePageLayout from './view/SinglePageLayout'
import MessageCenter from './mixins/MessageCenter'
import { AuthenticationInterceptor, TrySigninInterceptor } from '../mixins'

export default (opts) => {
    let { simple, complex } = opts
    complex = complex || {}
    const { id, path, redirectTo } = complex
    let routes = {
        iota: {
            [id || 'container']: { // root(empty) / container
                path: path || '/container',
                component: {
                    mixins: [// 这里混入两个组件，这样减少依赖，注意顺序
                        TrySigninInterceptor,
                        AuthenticationInterceptor,
                        MessageCenter,
                        LayoutContainer
                    ]
                },
                props: { id, redirectTo },
            }
        }
    }
    if (simple) {
        routes.iota[simple.path] = { // root(empty) / simple
            path: simple.path,
            component: SinglePageLayout,
            props: simple || {}
        }
    }
    return routes
}
