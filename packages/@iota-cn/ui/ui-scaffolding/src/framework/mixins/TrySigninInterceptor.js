export default {
    data() {
        return {}
    },

    created() {
        // 此处需要约定一个全局的 action 操作，并由其他模块实现 @see plugins/base/authentication
        // 考虑其他更加合理的方式，要么此混入可以由其他模块实现，并由框架层引用，减少耦合
        this.$store.dispatch('iota/global/trySignin')
    }
}