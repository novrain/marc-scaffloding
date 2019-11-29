<script>
import { message } from 'ant-design-vue/es'
import * as U from '../util'
import FlowItem from './FlowItem'

export default {
    components: {
        "ii-flow-item": FlowItem
    },
    props: ['processDef', 'user', 'selectedFlow', 'flowHelper', 'active', 'layout'],
    data() {
        return {
            flows: [],
            dataType: 'running',
            page: 1,
            size: 80,
            total: 0,
            history: {
                disabled: true,
            },
            fuzzyQuery: undefined
        }
    },
    mounted() {
        this.refetch()
    },
    watch: {
        processDef: {
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
        renderConrols() {
            return [
                this.history.disabled ?
                    null
                    : <a-radio-group key='dataType'
                        buttonStyle='solid'
                        v-model={this.dataType}>
                        <a-radio-button value="running">未处理</a-radio-button>
                        <a-radio-button value="finished">已处理</a-radio-button>
                    </a-radio-group>
                ,
                <a-input-search key='search'
                    placeholder={this.flowHelper.queryPlaceHolder}
                    class="search"
                    v-model={this.fuzzyQuery}
                    onSearch={this.refetch}
                    enterButton />
            ]
        },
        renderList() {
            return (<div class="ii-flow-list">
                <div class="toolbar">
                    {this.renderConrols()}
                </div>
                {
                    this.flows.length <= 0 ?
                        <div class="flows">
                            <ii-empty class="empty" />
                        </div>
                        :
                        <div class="flows">
                            <div class="list">
                                {this.flows.map((flow) => {
                                    return <ii-flow-item key='index'
                                        onClick={this.onSelectFlow}
                                        flow={flow}
                                        user={this.user}
                                        onCancel={this.onCancel}
                                        onSuspend={this.onSuspend}
                                        onActive={this.onActive}
                                        selected={this.selectedFlow ? this.selectedFlow.processInstanceId === flow.processInstanceId : false}
                                    />
                                })}
                            </div>
                            <a-pagination size="small"
                                class="pagination"
                                total={this.total}
                                v-model={this.page}
                                showTotal={() => `共 ${this.total} 条`} />
                        </div>
                }
            </div>)
        },
        onPageChange(page) {
            this.page = page
            this.refetch()
        },
        onLimitChange(current, pageSize) {
            this.limit = pageSize
            this.page = 1
            this.refetch()
        },
        renderTable() {
            let columns = this.flowHelper.columns
            if (typeof this.flowHelper.columns === 'function') {
                columns = this.flowHelper.columns.call(this)
            }
            if (!columns) {
                return this.renderList()
            }
            if (this.showNode) { // 扩展类提供
                const taskNodeColumn = {
                    title: '流程节点',
                    dataIndex: 'task.name',
                    key: 'task.name',
                    width: '10%',
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
            // 操作
            if (this.dataType === 'running') {
                const operationColumn = {
                    title: '操作',
                    dataIndex: 'operation',
                    width: '10%',
                    customRender: (text, flow) => {
                        const cancelable = U.cancelable({ user: this.user, flow })
                        const suspendable = U.suspendable({ user: this.user, flow })
                        const activeable = U.activeable({ user: this.user, flow })
                        return flow.finished ?
                            null
                            : <div class='operations'>
                                {
                                    cancelable ?
                                        <a-popconfirm
                                            title="确认取消？"
                                            okText="确认"
                                            onConfirm={() => { this.onCancel({ flow }) }}
                                            cancelText="取消">
                                            <a>取消</a>
                                        </a-popconfirm>
                                        :
                                        null
                                }
                                {cancelable ? <a-divider type="vertical" /> : null}
                                {
                                    suspendable ?
                                        <a-popconfirm
                                            title="确认挂起？"
                                            okText="确认"
                                            onConfirm={() => { this.onSuspend({ flow }) }}
                                            cancelText="取消">
                                            <a>挂起</a>
                                        </a-popconfirm>
                                        :
                                        null
                                }
                                {suspendable ? <a-divider type="vertical" /> : null}
                                {
                                    activeable ?
                                        <a-popconfirm
                                            title="确认激活？"
                                            okText="确认"
                                            onConfirm={() => { this.onActive({ flow }) }}
                                            cancelText="取消">
                                            <a>激活</a>
                                        </a-popconfirm>
                                        :
                                        null
                                }
                            </div>
                    },
                }
                columns.push(operationColumn)
            }
            const pageSizeOptions = ['20', '40', '60', '80']
            return (
                <div class="ii-flow-list">
                    <IiTableLayout
                        rowSelection={{ type: 'radio', selectedRowKeys: [this.selectedFlow ? this.selectedFlow.id : undefined] }}
                        size='small'
                        controls={this.renderConrols()}
                        headheight={68}
                        total={this.total}
                        pageSize={this.size}
                        currentPage={this.page}
                        showSizeChanger={true}
                        onShowSizeChange={this.onLimitChange}
                        onPaginationChange={this.onPageChange}
                        pageSizeOptions={pageSizeOptions}
                        onRowClick={this.onSelectFlow}
                        showPagination={'top'}
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
        return this.layout === 'list' ? this.renderList() : this.renderTable()
    }
}
</script>

<style lang="stylus" scoped>
@import '../../../../styles/imports';

.ii-flow-list {
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;

    .toolbar {
        display: flex;
        width: 100%;
        margin: 10px 0px 10px 0;

        .search {
            flex: 1;
        }
    }

    /deep/ .ant-radio-group {
        text-align: center;

        // border-bottom: 1px solid $ii-gray-200;
        .ant-radio-button-wrapper, .ant-radio-button-wrapper-checked {
            border: none;
            box-shadow: none;

            &:hover {
                border: none;
                box-shadow: none;
            }

            &:focus {
                border: none;
                box-shadow: none;
            }

            &:focus-within {
                outline: none;
            }
        }

        .ant-radio-button-wrapper-checked {
            background-color: $ii-gray-100;
            color: $primary-color;
        }
    }

    .flows {
        display: flex;
        height: 100%;
        width: 100%;
        flex-direction: column;
        align-items: center;
        overflow-y: auto;

        .empty {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .list {
            width: 100%;

            .flow-item {
            }
        }
    }

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