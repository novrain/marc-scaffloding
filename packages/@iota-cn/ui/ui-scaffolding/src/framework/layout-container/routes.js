import LayoutContainer from './view/LayoutContainer'
import MessageCenter from './view/MessageCenter'
import SinglePageLayout from './view/SinglePageLayout'

export default (opts) => {
    let { simple, complex } = opts
    complex = complex || {}
    const { id, path } = complex
    let routes = {
        iota: {
            [id || 'container']: { // root(empty) / container
                path: path || '/container',
                component: { mixins: [MessageCenter, LayoutContainer] }, // 这里混入两个组件，这样减少依赖，注意顺序
                props: { id: id },
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
