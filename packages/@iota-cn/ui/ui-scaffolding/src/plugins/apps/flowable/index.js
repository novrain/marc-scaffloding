import store from './store'
import messages from './view/locale'
import routes from './routes'
import Flowable from './view/console/Flowable'
import FlowableWidget from './view/overview/FlowableWidget'
import FlowHelperMixin from './view/components/FlowHelperMixin'


const entry = (opts, Vue) => {
    // 应用可以包装
    Vue.component('ii-flowable', Flowable)
    Vue.component('ii-flowable-widget', FlowableWidget)
    Vue.component('ii-flowable-helper-mixin', FlowHelperMixin)
    return {
        store: store(opts),
        messages,
        routes: routes(opts)
    }
}

export {
    entry
}