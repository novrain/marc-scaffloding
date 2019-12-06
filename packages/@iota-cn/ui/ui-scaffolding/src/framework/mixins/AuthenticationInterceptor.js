import { isUserLogged } from '../util'

export default {
    props: {
        authFailRedirect: String
    },

    data() {
        return {}
    },

    created() {
        // 判断用户是否已经登录，如果没有，则重定向到配置页面或者 '/'
        // 这里的 this.$user 是由其他模块提供的一个vue data/computed 属性等
        if (!isUserLogged(this.$user)) {
            this.$router.push({ path: this.authFailRedirect || '/' })
        }
    }
}