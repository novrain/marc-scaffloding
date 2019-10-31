import store from './store'
import messages from './view/locale'
import routes from './routes'

const entry = (opts) => {
    return {
        store: store(opts),
        messages,
        routes: routes(opts)
    }
}

export {
    entry
}