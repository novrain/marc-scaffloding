<template>
    <div class="ii-flow-list">
        <div class="toolbar">
            <a-radio-group v-if="!history.disabled"
                buttonStyle='solid'
                v-model="dataType">
                <a-radio-button value="running">未处理</a-radio-button>
                <a-radio-button value="finished">已处理</a-radio-button>
            </a-radio-group>
            <a-input-search placeholder="按名称搜索"
                class="search"
                @search="refetch"
                enterButton />
        </div>
        <div class="flows"
            v-if="flows.length <= 0">
            <ii-empty class="empty" />
        </div>
        <div class="flows"
            v-else>
            <div class="list">
                <template v-for="(flow, index) in flows">
                    <ii-flow-item :key='index'
                        @click="onSelectFlow"
                        :flow='flow'
                        :user='user'
                        :onCancel='onCancel'
                        :onSuspend='onSuspend'
                        :onActive='onActive'
                        :selected='selectedFlow ? selectedFlow.processInstanceId===flow.processInstanceId : false' />
                </template>
            </div>
            <a-pagination size="small"
                class="pagination"
                :total="total"
                :showTotal="total => `共 ${total} 条`" />
        </div>
    </div>
</template>

<script>
import { message } from 'ant-design-vue/es'
import * as U from '../util'
import FlowItem from './FlowItem'

export default {
    components: {
        "ii-flow-item": FlowItem
    },
    // flowFuncs queryFilter 需要整理合并
    // queryFilter 是给需要针对某些场景做的查询条件过滤，但只支持在varaible中过滤，参数在发起时就需要配合填入
    props: ['processDef', 'user', 'selectedFlow', 'flowFuncs', 'queryFilter', 'active'],
    data() {
        return {
            flows: [],
            dataType: 'running',
            page: 1,
            size: 100,
            total: 0,
            history: {
                disabled: true,
            }
        }
    },
    mounted() {
        this.refetch()
    },
    watch: {
        processDef: {
            handler() {
                this.flows = []
                this.refetch()
            }
        },
        dataType: {
            handler() {
                this.page = 1
                this.size = 20
                this.total = 0
                this.flows = []
                this.refetch()
            }
        },
        active: {
            handler() {
                if (this.active) {//变化前的状态
                    this.refetch()
                }
            }
        }
    },
    methods: {
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