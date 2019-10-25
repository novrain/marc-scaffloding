import E404 from './view/404.vue'
import E504 from './view/504.vue'
import E500 from './view/500.vue'
// import merge from 'deepmerge'

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