<script>
import moment from 'moment'
// import * as U from '../util'
import BaseFlowList from './BaseFlowList'

export default {
    mixins: [BaseFlowList],
    mounted() {
        this.history.disabled = false
    },
    methods: {
        refetch() {
            if (this.processDef) {
                this.$axios.silentPost('/fl/process/query/historic-process-instances', {
                    processDefinitionId: this.processDef.flowableInstance,
                    includeProcessVariables: true,
                    sort: 'startTime',
                    order: 'desc',
                    size: this.size,
                    start: (this.page - 1) * this.size,
                    finished: this.dataType === 'finished' ? true : false,
                    variables: [
                        {
                            name: "initiatorId",
                            value: this.user.id,
                            operation: "equals",
                            type: "string"
                        }
                    ]
                }, true)
                    .then((res) => {
                        this.flows = res.data.data.map(process => {
                            const formData = {}
                            process.variables.forEach(v => {
                                formData[v.name] = v.value
                            })
                            //@ Todo，由每个流程从参数里构造出来
                            // const name = process.name || 'example'
                            // const summary = process.summary || 'summary'
                            // const desc = process.desc || 'desc'
                            const { name, summary, desc } = this.flowFuncs.infoOfFlow.call(this, formData)
                            return {
                                processInstanceId: process.id,
                                createTime: moment(process.startTime).format('YYYY-MM-DD HH:mm:ss'),
                                name,
                                summary,
                                desc,
                                formData,
                                // currentNode: process.name
                            }
                        })
                        this.total = res.data.total
                        this.page = 0
                        if (this.flows.length > 0) {
                            this.$emit('select', this.flows[0])
                        } else {
                            this.$emit('select', undefined)
                        }
                    }).catch(() => { })
            }
        }
    }
}
</script>