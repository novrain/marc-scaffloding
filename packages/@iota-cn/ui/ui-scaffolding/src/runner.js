import merge from 'deepmerge'
import Vue from 'vue'
import Vuex from 'vuex'
import Router from 'vue-router'

import Antd from 'ant-design-vue'
import 'ant-design-vue/dist/antd.less'

import VChart from 'v-charts'
import VueI18n from 'vue-i18n'

// iota-cn
import Avatar from '@iota-cn/avatar'
import '@iota-cn/avatar/dist/avatar.css'
// Add to Vue prototype
import FrameComponents from './framework/components'

// ncform 或者可以按需配置
import axios from 'axios'
import vueNcform from '@ncform/ncform'
import Element from 'element-ui'
// import 'element-ui/lib/theme-chalk/index.css'
import ncformStdComps from '@ncform/ncform-theme-elementui'
import rules from './framework/ncform-rules'
// Element部分全局变量会被antd覆盖掉
try { Vue.use(Element) } catch (e) { console.log('externals mode') }
Vue.use(vueNcform, { extComponents: ncformStdComps, extRules: rules, lang: 'zh-cn' })
window.$http = Vue.prototype.$http = axios
// ncform -end

//CKEditor
import CKEditor from '@ckeditor/ckeditor5-vue'
Vue.use(CKEditor)

//Split pane
import { Splitpanes, Pane } from 'splitpanes'
import 'splitpanes/dist/splitpanes.css'
Vue.component('splitpanes', Splitpanes)
Vue.component('splitpane', Pane)

//Vue-resize
import 'vue-resize/dist/vue-resize.css'
import VueResize from 'vue-resize'
Vue.use(VueResize)

Vue.use(Antd)
Vue.use(VChart)
Vue.use(VueI18n)
Vue.use(Vuex)
Vue.use(Router)
Vue.use(Avatar)
Vue.use(FrameComponents)

import AppLoader from './framework/AppLoader'
import defaultApp from './App.vue'
import defaultConfig from './config'

export default ({ config, App }) => {
    const appLoader = new AppLoader(config || defaultConfig, Vue)
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