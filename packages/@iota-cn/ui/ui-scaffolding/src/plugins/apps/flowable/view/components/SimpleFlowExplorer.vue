<script>
import { message } from 'ant-design-vue/es'
import * as U from '../../util'
import StoreReaderMixin from './StoreReaderMixin'

export default {
    mixins: [StoreReaderMixin],
    props: ['id', 'containerId', 'processDefinitionKey', 'processdef', 'user', 'selectedFlow', 'flowHelper', 'active'],
    data() {
        return {
            flows: [],
            dataType: 'running',
            page: 1,
            size: 20,
            total: 0
        }
    },
    mounted() {
        this.refetch()
    },
    watch: {
        processdef: {
            handler() {
                this.callRefetch(true)
            }
        },
        dataType: {
            handler() {
                this.callRefetch(true)
            }
        },
        flowHelper: {
            handler() {
                this.callRefetch(true)
            }
        },
        active: {
            handler() {
                this.callRefetch()
            }
        }
    },
    methods: {
        callRefetch(reset) {
            if (!this.active) {
                return
            }
            if (reset) {
                this.page = 1
                this.size = 80
                this.total = 0
                this.flows = []
            }
            this.refetch()
        },
        onSelectFlow(flow) {
            this.$emit('select', flow)
        },
        // 通用方法，与权限相关的应放置后端处理
        // 相关方法是全局注入的
        async fetchUserInvolvedGroups() {
            const organizations = await this.$fetchAssignedOrganizations()
            const positions = await this.$fetchAssignedPositions()
            const roles = await this.$fetchAssignedRoles()
            let involvedGroups = organizations.map(organization => {
                return U.idOfQueryOrganization(organization)
            })
            involvedGroups = involvedGroups.concat(positions.map(position => {
                return U.idOfQueryPosition(position)
            }))
            involvedGroups = involvedGroups.concat(roles.map(role => {
                return U.idOfQueryRole(role)
            }))
            return involvedGroups
        },
        // 针对流程的操作
        onCancel({ flow }) {
            return this.$axios.silentDelete(`/fl/process/runtime/process-instances/${flow.processInstanceId}`, true)
                .then(() => {
                    message.success('任务已取消')
                    this.refetch()
                }).catch(() => {
                    message.success('任务取消失败，请稍后再试')
                })
        },
        onSuspend({ flow }) {
            return this.$axios.silentPut(`/fl/process/runtime/process-instances/${flow.processInstanceId}`, {
                action: 'suspend'
            }, true)
                .then(() => {
                    message.success('任务已挂起')
                    flow.suspended = true
                    // this.refetch()
                }).catch(() => {
                    message.success('任务挂起失败，请稍后再试')
                })
        },
        onActive({ flow }) {
            return this.$axios.silentPut(`/fl/process/runtime/process-instances/${flow.processInstanceId}`, {
                action: 'activate'
            }, true)
                .then(() => {
                    message.success('任务已激活')
                    flow.suspended = false
                    // this.refetch()
                }).catch(() => {
                    message.success('任务激活失败，请稍后再试')
                })
        },
        renderTable() {
            let columns = [
                {
                    title: '名称',
                    dataIndex: 'name',
                    key: 'name'
                },
                {
                    title: '概要',
                    dataIndex: 'summary',
                    key: 'summary',
                    width: '30%',
                }
            ]
            if (typeof this.flowHelper.columnsForWidget === 'function') {
                columns = this.flowHelper.columnsForWidget() || columns
            }
            if (this.showNode) { // 扩展类提供
                const taskNodeColumn = {
                    title: '流程节点',
                    dataIndex: 'task.name',
                    key: 'task.name',
                    width: '15%',
                    customRender: (text, flow) => {
                        if (flow.finished) {
                            return ''
                        } else if (flow.task) {
                            return flow.task.name
                        }
                        return ''
                    }
                }
                columns.push(taskNodeColumn)
            }
            // const operationColumn = {
            //     title: '操作',
            //     dataIndex: 'operation',
            //     width: '10%',
            //     customRender: (text, flow) => {
            //         const cancelable = U.cancelable({ user: this.user, flow })
            //         const suspendable = U.suspendable({ user: this.user, flow })
            //         const activeable = U.activeable({ user: this.user, flow })
            //         return flow.finished ?
            //             null
            //             : <div class='operations'>
            //                 {
            //                     cancelable ?
            //                         <a-popconfirm
            //                             title="确认取消？"
            //                             okText="确认"
            //                             onConfirm={() => { this.onCancel({ flow }) }}
            //                             cancelText="取消">
            //                             <a>取消</a>
            //                         </a-popconfirm>
            //                         :
            //                         null
            //                 }
            //                 {cancelable ? <a-divider type="vertical" /> : null}
            //                 {
            //                     suspendable ?
            //                         <a-popconfirm
            //                             title="确认挂起？"
            //                             okText="确认"
            //                             onConfirm={() => { this.onSuspend({ flow }) }}
            //                             cancelText="取消">
            //                             <a>挂起</a>
            //                         </a-popconfirm>
            //                         :
            //                         null
            //                 }
            //                 {suspendable ? <a-divider type="vertical" /> : null}
            //                 {
            //                     activeable ?
            //                         <a-popconfirm
            //                             title="确认激活？"
            //                             okText="确认"
            //                             onConfirm={() => { this.onActive({ flow }) }}
            //                             cancelText="取消">
            //                             <a>激活</a>
            //                         </a-popconfirm>
            //                         :
            //                         null
            //                 }
            //             </div>
            //     },
            // }
            //columns.push(operationColumn)
            return (
                <div class="ii-flow-simple">
                    <IiTableLayout
                        // rowSelection={{ type: 'radio', selectedRowKeys: [this.selectedFlow ? this.selectedFlow.id : undefined] }}
                        size='small'
                        headheight={68}
                        onRowClick={this.onSelectFlow}
                        showSizeChanger={true}
                        class={'table'}
                        columns={columns}
                        rows={this.flows}>
                    </IiTableLayout>
                </div>
            )
        }
    },
    render() {
        return this.renderTable()
    }
}
</script>

<style lang="stylus" scoped>
@import '../../../../../styles/imports';

.ii-flow-simple {
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;

    .table {
        /deep/ .ant-input-group-wrapper {
            width: auto;
        }

        .operations {
            a {
                color: $primary-color;
                cursor: pointer;
            }
        }
    }
}
</style>