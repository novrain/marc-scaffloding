import { createNamespacedHelpers } from 'vuex'
const { mapActions } = createNamespacedHelpers('iota/global/sysconfig')

export default {
    methods: {
        ...mapActions(['fetchSysconfig', 'updateSysconfig'])
    }
}