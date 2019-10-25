import Vue from 'vue'
import Vuex from 'vuex'
import Router from 'vue-router'

import Antd from 'ant-design-vue';
import 'ant-design-vue/dist/antd.less';

import VCharts from 'v-charts'
import VueI18n from 'vue-i18n'

// iota-cn
import Avatar from '@iota-cn/avatar'
Vue.use(Avatar)

import AppLoader from '@iota-cn/ui-scaffolding/src/framework/AppLoader'
import App from './App.vue'
import config from './config'

const appLoader = new AppLoader(config)
const { store, routes, messages } = appLoader.load()

Vue.use(Antd)
Vue.use(VCharts)
Vue.use(VueI18n)

const i18n = new VueI18n({
    locale: Vue.config.locale || 'zh-cn',
    fallbackLocale: 'zh-cn',
    messages: messages || {}
})

Vue.use(Vuex)
Vue.use(Router)

new Vue({
    router: new Router({ routes, mode: 'history' }),
    store: new Vuex.Store(store),
    render: h => h(App),
    i18n
}).$mount('#app')
