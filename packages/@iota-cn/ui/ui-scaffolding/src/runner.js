import merge from 'deepmerge'
import Vue from 'vue'
import Vuex from 'vuex'
import Router from 'vue-router'

import Antd from 'ant-design-vue'
import 'ant-design-vue/dist/antd.less'

import VCharts from 'v-charts'
import VueI18n from 'vue-i18n'

// iota-cn
import Avatar from '@iota-cn/avatar'
// Add to Vue prototype
import FrameComponents from './framework/components'

Vue.use(Antd)
Vue.use(VCharts)
Vue.use(VueI18n)
Vue.use(Vuex)
Vue.use(Router)
Vue.use(Avatar)
Vue.use(FrameComponents)

import AppLoader from './framework/AppLoader'
import defaultApp from './App.vue'
import defaultConfig from './config'

export default ({ config, App }) => {
    const appLoader = new AppLoader(config || defaultConfig)
    const { store, routes, messages } = appLoader.load()

    const i18n = new VueI18n({
        locale: Vue.config.locale || 'zh-cn',
        fallbackLocale: 'zh-cn',
        messages: messages ? merge(messages, FrameComponents.messages) : FrameComponents.messages
    })

    new Vue({
        router: new Router({ routes, mode: 'history' }),
        store: new Vuex.Store(store),
        render: h => h(App || defaultApp),
        i18n
    }).$mount('#app')
}