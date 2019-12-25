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
            let query = {
                assigneeLike: `${U.idOfQueryUser(this.user)}%`, // 查询的时候模糊
                includeProcessVariables: true,
                // includeIdentityLinks: true,
                sort: 'createTime',
                order: 'desc',
                size: this.size,
                start: (this.page - 1) * this.size
            }
            if (this.processDefinitionKey) {
                query.processDefinitionKey = this.processDefinitionKey
                if (this.flowHelper.query) { // 允许扩展查询条件
                    query = this.flowHelper.query({
                        basic: query,
                        conditions: {
                            fuzzyQuery: this.fuzzyQuery
                        },
                        dataType: this.dataType,
                        processdef: this.processdef
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
            }
            this.$axios.silentPost('/fl/iota/query/tasks', query, true)
                .then((res) => {
                    // 转为统一的Flow数据结构 
                    this.flows = res.data.data.map(task => {
                        // 非单流程模式下，依赖flowable的processDefinitionId
                        let processDefinitionKey = this.processDefinitionKey || task.processDefinitionId.split(':')[0]
                        if (!this.findProcessdef(processDefinitionKey)) {
                            return
                        }
                        const formData = {}
                        U.decodeFormVariables(task.variables).forEach(v => {
                            formData[v.name] = v.value
                        })
                        task.assignee = U.parseAssignee(task.assignee)
                        return {
                            id: task.id,
                            processInstanceId: task.processInstanceId,
                            createTime: moment(task.createTime).format('YYYY-MM-DD HH:mm:ss'),
                            dueDate: task.dueDate ? moment(task.dueDate).format('YYYY-MM-DD HH:mm:ss') : '',
                            suspended: task.suspended,
                            formData,
                            task: task, // 自身是task
                            finished: this.dataType === 'finished',
                            processDefinitionId: task.processDefinitionId,
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
                }).catch((err) => { console.log(err) })
        }
    }
}