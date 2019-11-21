<script>
import moment from 'moment'
import * as U from '../util'
import BaseFlowList from './BaseFlowList'

export default {
    mixins: [BaseFlowList],
    mounted() {
        this.history.disabled = false
    },
    methods: {
        async refetch() {
            if (this.processDef) {
                let url = '/fl/process/query/tasks'
                let query = {
                    processDefinitionId: this.processDef.flowableInstance,
                    includeProcessVariables: true,
                    includeIdentityLinks: true,
                    sort: 'createTime',
                    order: 'desc',
                    size: this.size,
                    start: (this.page - 1) * this.size
                }
                if (this.dataType === 'finished') {
                    url = '/fl/process/query/historic-task-instances'
                    query = {
                        processDefinitionId: this.processDef.flowableInstance,
                        includeProcessVariables: true,
                        includeIdentityLinks: true,
                        finished: true,
                        sort: 'startTime',
                        order: 'desc',
                        size: this.size,
                        start: (this.page - 1) * this.size
                    }
                }
                // 这样的逻辑要放到封装的接口中去
                if (!this.user.isAdmin) {// 非管理只能查看 有连接 关系的任务以及实例 
                    const involvedUser = U.idOfQueryUser(this.user)
                    try {
                        let involvedGroups = await this.fetchUserInvolvedGroups()
                        involvedGroups = involvedGroups.map(g => {
                            return `${g}%`
                        })
                        if (this.dataType === 'finished') {
                            query.taskInvolvedUser = involvedUser
                            query.taskInvolvedGroups = involvedGroups
                        } else {
                            query.involvedUser = involvedUser
                            query.involvedGroups = involvedGroups
                        }
                    }
                    catch (err) {
                        this.$emit('select', undefined)
                        return
                    }
                }
                this.$axios.silentPost(url, query, true)
                    .then((res) => {
                        this.flows = res.data.data.map(task => {
                            const formData = {}
                            task.variables.forEach(v => {
                                formData[v.name] = v.value
                            })
                            //@ Todo，由每个流程从参数里构造出来
                            // const name = task.name || 'example'
                            // const summary = task.summary || 'summary'
                            // const desc = task.desc || 'desc'
                            const { name, summary, desc } = this.flowFuncs.infoOfFlow.call(this, formData)
                            task.assignee = U.parseAssignee(task.assignee)
                            return {
                                processInstanceId: task.processInstanceId,
                                createTime: moment(task.createTime).format('YYYY-MM-DD HH:mm:ss'),
                                dueDate: task.dueDate,
                                suspended: task.suspended,
                                name,
                                summary,
                                desc,
                                formData,
                                currentNode: task.name,
                                task: task // 自身是task
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