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
                let url = '/fl/process/query/process-instances'
                let query = {
                    processDefinitionId: this.processDef.flowableInstance,
                    includeProcessVariables: true,
                    sort: 'startTime',
                    order: 'desc',
                    size: this.size,
                    start: (this.page - 1) * this.size,
                    variables: [
                        {
                            name: "initiatorId",
                            value: this.user.id,
                            operation: "equals",
                            type: "string"
                        }
                    ]
                }
                if (this.dataType === 'finished') {
                    url = '/fl/process/query/historic-process-instances'
                    query = {
                        processDefinitionId: this.processDef.flowableInstance,
                        includeProcessVariables: true,
                        sort: 'startTime',
                        order: 'desc',
                        size: this.size,
                        start: (this.page - 1) * this.size,
                        finished: true,
                        variables: [
                            {
                                name: "initiatorId",
                                value: this.user.id,
                                operation: "equals",
                                type: "string"
                            }
                        ]
                    }
                }
                if (this.flowHelper.query) { // 允许扩展查询条件
                    query = this.flowHelper.query({
                        basic: query,
                        conditions: {
                            fuzzyQuery: this.fuzzyQuery
                        },
                        dataType: this.dataType,
                        processDef: this.processDef
                    })
                }
                this.$axios.silentPost(url, query, true)
                    .then((res) => {
                        this.flows = res.data.data.map(process => {
                            const formData = {}
                            process.variables.forEach(v => {
                                formData[v.name] = v.value
                            })
                            const { name, summary, desc } = this.flowHelper.simplified.call(this, { formData })
                            return {
                                processInstanceId: process.id,
                                createTime: moment(process.startTime).format('YYYY-MM-DD HH:mm:ss'),
                                name,
                                summary,
                                desc,
                                formData,
                                // 任务是否挂起，必须明确有值，否则认为无法处理
                                suspended: process.suspended !== undefined ? process.suspended : undefined,
                                endTime: process.endTime,
                                finished: this.dataType === 'finished'
                            }
                        })
                        this.total = res.data.total
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