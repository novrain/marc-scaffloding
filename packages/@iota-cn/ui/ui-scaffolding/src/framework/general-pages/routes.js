const E404 = () => import('./view/404')
const E504 = () => import('./view/504')
const E500 = () => import('./view/500')

export default (opts) => {
    let parents = opts.parents

    let routes = {}
    if (Array.isArray(parents)) {
        parents.forEach(parent => {
            let target = routes
            let path = parent.path.split('/');
            if (Array.isArray(path)) {
                path.forEach(p => {
                    let t = target[p] || {}
                    target[p] = t
                    target = t
                })
            }
            target['*'] = {
                path: '*',
                component: E404,
                props: parent.props
            }
            target[504] = {
                path: '504',
                component: E504,
                props: parent.props
            }
            target[505] = {
                path: '500',
                component: E500,
                props: parent.props
            }
        })
    }
    return routes
}