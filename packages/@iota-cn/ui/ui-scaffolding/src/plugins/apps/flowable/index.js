import store from './store'
import messages from './view/locale'
import routes from './routes'
import Flowable from './view/console/Flowable'
import FlowableWidage from './view/overview/FlowableWidage'
import Vue from 'vue'

// 应用可以包装
Vue.component('ii-flowable', Flowable)
Vue.component('ii-flowable-widage', FlowableWidage)

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