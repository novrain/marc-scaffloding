import ResetPasswordForm from './ResetPasswordForm'
import UserInfoExtendsForm from './UserInfoExtendsForm'

const install = (Vue) => {
    /**
     * 全局computer user，data中无法使用
     */
    Vue.mixin({
        computed: {
            $user() {
                const state = this.$store.state.iota.global.authentication
                return state.user
            }
        }
    })
    // 组件
    Vue.component('ii-reset-password-form', ResetPasswordForm)
    Vue.component('ii-user-extends-form', UserInfoExtendsForm)
    // 原型
    if (!Vue.prototype.$p) { // 默认鉴权操作函数，作为框架层的默认实现
        Vue.prototype.$p = function () {
            return true
        }
    }
    if (!Vue.prototype.$m) { // 默认菜单权限作函数，作为框架层的默认实现
        Vue.prototype.$m = function () {
            return true
        }
    }
}

export default {
    install
}