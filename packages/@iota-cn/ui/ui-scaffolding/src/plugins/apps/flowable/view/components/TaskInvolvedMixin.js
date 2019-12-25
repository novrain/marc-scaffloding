import moment from 'moment'
import * as U from '../../util'

export default {
    mounted() {
        this.history.disabled = false
    },
    methods: {
        async refetch() {
            let url = '/fl/iota/query/historic-process-instances'
            let query = {
                includeProcessVariables: true,
                includeIdentityLinks: true,
                finished: false,
                sort: 'startTime',
                order: 'desc',
                size: this.size,
                start: (this.page - 1) * this.size
            }
            if (this.dataType === 'finished') {
                query.finished = true
            }
            // 这样的逻辑要放到封装的接口中去
            if (!this.user.isAdmin) {// 非管理只能查看 有连接 关系的任务以及实例 
                const involvedUser = U.idOfQueryUser(this.user)
                query.involvedUser = `${involvedUser}%`
                try {
                    let involvedGroups = await this.fetchUserInvolvedGroups()
                    if (involvedGroups.length > 0) {
                        involvedGroups = involvedGroups.map(g => {
                            return `${g}%`
                        })
                        query.involvedGroups = involvedGroups
                    }
                }
                catch (err) {
                    this.$emit('select', undefined)
                    return
                }
            }
            if (this.processDefinitionKey) {
                if (this.flowHelper.query) { // 允许扩展查询条件
                    query.processDefinitionKey = this.processDefinitionKey
                    query = this.flowHelper.query({
                        basic: query,
                        conditions: {
                            fuzzyQuery: this.fuzzyQuery
                        },
                        dataType: this.dataType,
                        processdef: this.processdef
                    })
                }
            }
            this.$axios.silentPost(url, query, true)
                .then((res) => {
                    this.flows = res.data.data.map(flow => {
                        // 非单流程模式下，依赖flowable的processDefinitionId
                        let processDefinitionKey = this.processDefinitionKey || flow.processDefinitionId.split(':')[0]
                        if (!this.findProcessdef(processDefinitionKey)) {
                            return
                        }
                        const formData = {}
                        U.decodeFormVariables(flow.variables).forEach(v => {
                            formData[v.name] = v.value
                        })
                        return {
                            id: flow.id,
                            processInstanceId: flow.id,
                            createTime: moment(flow.createTime).format('YYYY-MM-DD HH:mm:ss'),
                            dueDate: flow.dueDate ? moment(flow.dueDate).format('YYYY-MM-DD HH:mm:ss') : '',
                            suspended: flow.suspended,
                            formData,
                            finished: this.dataType === 'finished',
                            deleteReason: flow.deleteReason,
                            processDefinitionId: flow.processDefinitionId,
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