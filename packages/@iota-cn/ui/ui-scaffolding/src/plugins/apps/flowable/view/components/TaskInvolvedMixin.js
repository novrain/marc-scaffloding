import moment from 'moment'
import * as U from '../../util'

export default {
    mounted() {
        this.history.disabled = false
    },
    methods: {
        async refetch() {
            if (this.processDef) {
                let url = '/fl/iota/query/historic-process-instances'
                let query = {
                    processDefinitionId: this.processDef.flowableInstance,
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
                        this.flows = res.data.data.map(flow => {
                            const formData = {}
                            U.decodeFormVariables(flow.variables).forEach(v => {
                                formData[v.name] = v.value
                            })
                            const { name, summary, desc } = this.flowHelper.simplified.call(this, { formData })
                            return {
                                id: flow.id,
                                processInstanceId: flow.id,
                                createTime: moment(flow.createTime).format('YYYY-MM-DD HH:mm:ss'),
                                dueDate: flow.dueDate,
                                suspended: flow.suspended,
                                name,
                                summary,
                                desc,
                                formData,
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