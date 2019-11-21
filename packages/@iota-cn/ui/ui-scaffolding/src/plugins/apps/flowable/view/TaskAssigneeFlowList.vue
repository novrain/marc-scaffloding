<script>
import moment from 'moment'
import * as U from '../util'
import BaseFlowList from './BaseFlowList'

export default {
    mixins: [BaseFlowList],
    methods: {
        refetch() {
            if (this.processDef) {
                this.$axios.silentPost('/fl/process/query/tasks', {
                    processDefinitionId: this.processDef.flowableInstance,
                    assigneeLike: `${U.idOfQueryUser(this.user)}%`, // 查询的时候模糊
                    includeProcessVariables: true,
                    includeIdentityLinks: true,
                    sort: 'createTime',
                    order: 'desc',
                    size: this.size,
                    start: (this.page - 1) * this.size
                }, true)
                    .then((res) => {
                        // 转为统一的Flow数据结构 
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
                    }).catch((err) => { console.log(err) })
            }
        }
    }
}
</script>