const MixedContainer = () => import('./view/MixedContainer')
const SinglePageLayout = () => import('./view/SinglePageLayout')

export default (opts) => {
    let { simple, complex } = opts
    complex = complex || {}
    const { id, path, redirect, authFailRedirect } = complex
    let routes = {
        iota: {
            [id || 'container']: { // root(empty) / container
                path: path || '/container',
                redirect: redirect, // 可以覆盖默认路由
                component: MixedContainer,
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
