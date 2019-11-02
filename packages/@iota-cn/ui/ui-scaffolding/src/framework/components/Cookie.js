import cookie from '../util'

const install = function (Vue) {
    Vue.prototype.$cookie = {
        get(key) {
            return cookie.iotaGet(key)
        },
        getJSON(key) {
            return cookie.iotaGetJson(key)
        },
        set(key) {
            return cookie.iotaSet(key)
        },
        remove(key, opts) {
            return cookie.iotaRemove(key, opts)
        }
    }
}

export default {
    install
}