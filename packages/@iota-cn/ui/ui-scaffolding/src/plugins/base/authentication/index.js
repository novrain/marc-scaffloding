import store from './store'
import messages from './view/locale'
import routes from './routes'
import AuthComponets from './components'

const entry = (opts, Vue) => {
    Vue.use(AuthComponets)
    return {
        store: store(opts),
        messages,
        routes: routes(opts)
    }
}

export {
    entry
}