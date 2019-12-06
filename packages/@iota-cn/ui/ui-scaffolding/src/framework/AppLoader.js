import createLogger from 'vuex/dist/logger'
import merge from 'deepmerge'
import { initCookie } from './util'
import { initAxios } from '../axios'

const debug = process.env.NODE_ENV !== 'production'

// VueRouter keys to filter
const ROUTE_CONFIG_KEYS = [
    'path',
    'name',
    'component',
    'components',
    'redirect',
    'alias',
    'children',
    'meta',
    'beforeEnter',
    'props',
    'caseSensitive',
    'pathToRegexpOptions'
]

/**
 * 加载应用插件，主要是拼装Vuex.store & Vue-Router.routes & i18n.messages
 */
class AppLoader {
    static isObject = (value) => {
        return value !== null && typeof value === 'object'
    }

    /**
     * 转换Routes为Vue-Router格式
     */
    static convertToVueRoutes = (routes) => {
        let children = []
        let current = undefined
        if (Array.isArray(routes)) {
            return routes
        }
        if (!AppLoader.isObject(routes)) {
            return null
        }
        if (routes.path) {
            current = {}
            for (let key of ROUTE_CONFIG_KEYS) {
                current[key] = routes[key]
            }
            current.children = Array.isArray(current.children) ? current.children : children
        }
        const keys = Object.keys(routes).filter(key => { return ROUTE_CONFIG_KEYS.indexOf(key) === -1 })
        //sort, make * to be the last one.
        keys.sort((a, b) => {
            return a === "*" ? 1 : (b === "*" ? -1 : 0)
        })
        keys.forEach(key => {
            const val = routes[key]
            const childs = AppLoader.convertToVueRoutes(val)
            if (childs) {
                if (Array.isArray(childs)) {
                    children.push(...childs)
                } else {
                    children.push(childs)
                }
            }
        })
        if (children.length !== 0 || current) {
            return current ? current : children
        }
    }

    constructor(config, Vue) {
        this.config = config
        this.Vue = Vue
        // 初始化 cookie 包，设置前缀
        config.cookie = config.cookie ? config.cookie : {}
        initCookie(config.cookie.prefix)
        config.axios = config.axios ? config.axios : {}
        initAxios(config.axios)
    }

    load = () => {
        let store = {
            strict: debug,
            plugins: debug ? [createLogger()] : []
        }
        let routes = {}
        let messages = {}
        if (Array.isArray(this.config.plugins)) {
            this.config.plugins.forEach(p => {
                let { store: pluginStore, routes: pluginRoutes, messages: pluginMessages } = typeof p.plugin.entry === 'function'
                    ? p.plugin.entry(p.opts, this.Vue)
                    : p.plugin
                if (pluginStore) store = merge(store, pluginStore)
                if (pluginRoutes) routes = merge(routes, pluginRoutes)
                messages = merge(messages, pluginMessages || {})
            })
        }

        routes = AppLoader.convertToVueRoutes(routes)
        return { store, routes: Array.isArray(routes) ? routes : [routes], messages }
    }
}

export default AppLoader