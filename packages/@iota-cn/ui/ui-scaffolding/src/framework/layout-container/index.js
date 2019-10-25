import store from './store'
import routes from './routes'

const entry = (opts) => {
    opts.complex = opts.complex || {}
    const theStore = store(opts)
    return {
        store: theStore,
        routes: routes(opts)
    }
}

export {
    entry
}