import store from './store'
import routes from './routes'
import merge from 'deepmerge'

const entry = (opts) => {
    store.modules.iota.state = merge(store.modules.iota.state, opts)
    return {
        store,
        routes
    }
}

export {
    entry
}