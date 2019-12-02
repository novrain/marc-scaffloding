import store from './store'
import messages from './view/locale'
import routes from './routes'
import Flowable from './view/console/Flowable'
import Vue from 'vue'

// 应用可以包装
Vue.component('ii-flowable', Flowable)

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