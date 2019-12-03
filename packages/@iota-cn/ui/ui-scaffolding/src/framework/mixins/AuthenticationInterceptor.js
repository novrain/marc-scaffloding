import { isUserLogged } from '../util'

export default {
    props: {
        authFailRedirect: String
    },

    data() {
        return {}
    },

    created() {
        // 这个模块需要从上层规定
        const state = this.$store.state.iota.global.authentication
        // 判断用户是否已经登录，如果没有，则重定向到配置页面或者 '/'
        if (!isUserLogged(state.user)) {
            this.$router.push({ path: this.authFailRedirect || '/' })
        }
    }
}