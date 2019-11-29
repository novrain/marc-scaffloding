<script>
import { message } from 'ant-design-vue/es'
import * as U from '../util'
import FlowItem from './FlowItem'

export default {
    components: {
        "ii-flow-item": FlowItem
    },
    props: ['processDef', 'user', 'selectedFlow', 'flowHelper', 'active'],
    data() {
        return {
            flows: [],
            dataType: 'running',
            page: 1,
            size: 100,
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
                this.size = 100
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
        }
    },
    render() {
        return (
            <div class="ii-flow-list">
                <div class="toolbar">
                    {
                        this.history.disabled ?
                            null
                            : <a-radio-group
                                buttonStyle='solid'
                                v-model={this.dataType}>
                                <a-radio-button value="running">未处理</a-radio-button>
                                <a-radio-button value="finished">已处理</a-radio-button>
                            </a-radio-group>
                    }
                    <a-input-search placeholder={this.flowHelper.queryPlaceHolder}
                        class="search"
                        v-model={this.fuzzyQuery}
                        onSearch={this.refetch}
                        enterButton />
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
            </div>
        )
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
    padding: 10px 0;

    .toolbar {
        display: flex;
        width: 100%;
        margin: 0 0 10px 0;

        .search {
            flex: 1;
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
    }

    .flows {
        display: flex;
        height: 100%;
        width: 100%;
        flex-direction: column;
        align-items: center;

        .empty {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .list {
            overflow-y: auto;
            width: 100%;
            flex: 1;

            .flow-item {
            }
        }
    }
}
</style>