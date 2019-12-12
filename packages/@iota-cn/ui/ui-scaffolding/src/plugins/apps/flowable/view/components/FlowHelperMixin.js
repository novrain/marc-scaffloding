export default {
    props: ['flowHelper'],
    data() {
        return {
            innerFlowHelper: undefined,
        }
    },
    mounted() {
        this.loadHelper()
    },
    methods: {
        loadHelper() {
            if (typeof this.flowHelper === 'string') {
                this.$loadScript(this.flowHelper)
                    .then(() => {
                        if (window.$IOTA_FLOW_HELPERS && window.$IOTA_FLOW_HELPERS[this.flowId]) {
                            this.innerFlowHelper = window.$IOTA_FLOW_HELPERS[this.flowId]
                        }
                    }).catch(() => { })
                // } else if(typeof this.flowHelper === 'object') {
            } else {
                this.innerFlowHelper = this.flowHelper
            }
        },
    }
}