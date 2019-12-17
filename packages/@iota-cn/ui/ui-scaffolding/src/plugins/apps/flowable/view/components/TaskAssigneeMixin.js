import moment from 'moment'
import * as U from '../../util'

export default {
    data() {
        return {
            showNode: true
        }
    },
    methods: {
        refetch() {
            if (this.processDef) {
                let query = {
                    processDefinitionKey: this.processDef.flowableInstance,
                    assigneeLike: `${U.idOfQueryUser(this.user)}%`, // 查询的时候模糊
                    includeProcessVariables: true,
                    // includeIdentityLinks: true,
                    sort: 'createTime',
                    order: 'desc',
                    size: this.size,
                    start: (this.page - 1) * this.size
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
                    if (query.variables) {
                        query.processInstanceVariables = query.variables
                        delete query.variables
                    }
                    if (query.orVariables) {
                        query.orProcessInstanceVariables = query.orVariables
                        delete query.orVariables
                    }
                }
                this.$axios.silentPost('/fl/iota/query/tasks', query, true)
                    .then((res) => {
                        // 转为统一的Flow数据结构 
                        this.flows = res.data.data.map(task => {
                            const formData = {}
                            U.decodeFormVariables(task.variables).forEach(v => {
                                formData[v.name] = v.value
                            })
                            const { name, summary, desc } = this.flowHelper.simplified.call(this, { formData })
                            task.assignee = U.parseAssignee(task.assignee)
                            return {
                                id: task.id,
                                processInstanceId: task.processInstanceId,
                                createTime: moment(task.createTime).format('YYYY-MM-DD HH:mm:ss'),
                                dueDate: task.dueDate,
                                suspended: task.suspended,
                                name,
                                summary,
                                desc,
                                formData,
                                task: task, // 自身是task
                                finished: this.dataType === 'finished',
                                processDefinitionId: task.processDefinitionId
                            }
                        })
                        this.total = res.data.total
                        if (this.flows.length > 0) {
                            this.$emit('select', this.flows[0])
                        } else {
                            this.$emit('select', undefined)
                        }
                    }).catch((err) => { console.log(err) })
            }
        }
    }
}