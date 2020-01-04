import moment from 'moment'
import * as U from '../../util'

export default {
    mounted() {
        this.history.disabled = false
    },
    methods: {
        refetch() {
            let url = '/fl/iota/query/process-instances'
            let query = {
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
                url = '/fl/iota/query/historic-process-instances'
                query = {
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
            if (this.processDefinitionKey) { // 单流程模式，必须提供flowHelper
                query.processDefinitionKey = this.processDefinitionKey
                if (this.flowHelper.query) { // 允许扩展查询条件
                    query = this.flowHelper.query({
                        basic: query,
                        conditions: {
                            fuzzyQuery: this.fuzzyQuery
                        },
                        dataType: this.dataType
                    })
                }
            }
            this.$axios.silentPost(url, query, true)
                .then((res) => {
                    this.flows = res.data.data.map(process => {
                        // 非单流程模式下，依赖flowable的processDefinitionId
                        let processDefinitionKey = this.processDefinitionKey || process.processDefinitionId.split(':')[0]
                        if (!this.findProcessdef(processDefinitionKey)) {
                            return
                        }
                        const formData = {}
                        U.decodeFormVariables(process.variables).forEach(v => {
                            formData[v.name] = v.value
                        })
                        return {
                            id: process.id,
                            processInstanceId: process.id,
                            createTime: moment(process.startTime).format('YYYY-MM-DD HH:mm:ss'),
                            formData,
                            // 任务是否挂起，必须明确有值，否则认为无法处理
                            suspended: process.suspended !== undefined ? process.suspended : undefined,
                            endTime: process.endTime ? process.endTime.format('YYYY-MM-DD HH:mm:ss') : '',
                            dueDate: process.dueDate ? moment(process.dueDate).format('YYYY-MM-DD HH:mm:ss') : '',
                            finished: this.dataType === 'finished',
                            deleteReason: process.deleteReason,
                            processDefinitionId: process.processDefinitionId,
                            processDefinitionKey: processDefinitionKey
                        }
                    })
                    this.total = res.data.total
                    this.flows = this.flows.filter(f => {
                        return !!f
                    })
                    if (this.flows.length > 0) {
                        this.$emit('select', this.flows[0])
                    } else {
                        this.$emit('select', undefined)
                    }
                }).catch(() => { })
        }
    }
}