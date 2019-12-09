// import Root from './view/Root'
const Root = () => import('./view/Root')

const routes = function (opts) {
    const rs = {
        iota: {
            path: '/',
            // redirect: opts.redirect,  // not work, use beforeEnter
            component: Root,
        }
    }
    if (opts.redirect) {
        rs.iota.beforeEnter = (to, from, next) => {
            if (to.path === '/') {
                next({
                    path: opts.redirect
                })
            } else {
                next()
            }
        }
    }
    return rs
}

export default routes