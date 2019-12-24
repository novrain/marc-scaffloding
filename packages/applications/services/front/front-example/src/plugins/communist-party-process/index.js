import store from './store'
import messages from './view/locale'
import routes from './routes'
import CommunistPartyProcess from "./view/CommunistPartyProcess"

const entry = (opts, Vue) => {
    Vue.component('ii-flow-app-cpp', CommunistPartyProcess)
    return {
        store: store(opts),
        messages,
        routes: routes(opts)
    }
}

export {
    entry
}