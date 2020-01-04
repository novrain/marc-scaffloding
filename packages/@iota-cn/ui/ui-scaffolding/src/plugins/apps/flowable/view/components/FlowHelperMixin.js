import * as U from '../../util'
import StoreReaderMixin from './StoreReaderMixin'

export default {
    // 支持多实例
    props: ['id', 'containerId', 'processDefinitionKey'],
    mixins: [StoreReaderMixin],
    data() {
        return {}
    },
    mounted() {
        if (this.processDefinitionKey) { // 单流程模式
            this.loadProcessdef(this.processDefinitionKey)
        } else { // 所有流程模式
            this.$store.dispatch(`iota/${this.containerId}/${this.id}/fetchProcessDefs`, { vm: this })
        }
    },
    watch: {
        processDefinitionKey: {
            handler() {
                this.loadProcessdef(this.processDefinitionKey)
            }
        }
    },
    methods: {
        loadProcessdef(processDefinitionKey) {
            this.$store.dispatch(`iota/${this.containerId}/${this.id}/fetchProcessDef`, { processDefinitionKey: processDefinitionKey, vm: this })
        }
    },
    computed: {
        processdef() {
            return this.$store.getters[`iota/${this.containerId}/${this.id}/processdef`](this.processDefinitionKey)
        },
        helper() {
            return this.$store.getters[`iota/${this.containerId}/${this.id}/helper`](this.processDefinitionKey)
        },
        formDef() {
            let processdef = this.processdef
            if (processdef) {
                let def = JSON.parse(processdef.formDef || '{}')
                def.globalConfig = {
                    style: {
                        formCls: 'ii-nc-form'
                    },
                    constants: {
                        initiatorId: this.$user.id,
                        initiatorName: U.nameOfUser(this.$user),
                        currentTaskId: 'start'
                    }
                }
                return def
            } else {
                return undefined
            }
        },
        formWidth() {
            const formDef = this.formDef
            const formUi = formDef ? (formDef.ui || { width: 700 }) : { width: 700 }
            return formUi.width || 700
        }
    }
}