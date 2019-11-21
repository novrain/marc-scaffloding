<template>
    <div class="ii-flow-list">
        <a-radio-group v-if="!history.disabled"
            buttonStyle='solid'
            v-model="dataType">
            <a-radio-button value="running">未处理</a-radio-button>
            <a-radio-button value="finished">已处理</a-radio-button>
        </a-radio-group>
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
import * as U from '../util'
import FlowItem from './FlowItem'

export default {
    components: {
        "ii-flow-item": FlowItem
    },
    // flowFuncs queryFilter 需要整理合并
    // queryFilter 是给需要针对某些场景做的查询条件过滤，但只支持在varaible中过滤，参数在发起时就需要配合填入
    props: ['processDef', 'user', 'selectedFlow', 'flowFuncs', 'queryFilter'],
    data() {
        return {
            flows: [],
            dataType: 'running',
            page: 1,
            size: 20,
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
        }
    },
    methods: {
        onSelectFlow(flow) {
            this.$emit('select', flow)
        },

        // 通用方法，与权限相关的应放置后端处理
        async fetchUserInvolvedGroups() {
            const organizations = await this.$fetchOrganizations()
            const positions = await this.$fetchPositions()
            const roles = await this.$fetchRoles()
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

    /deep/ .ant-radio-group {
        width: 100%;
        text-align: center;
        border-bottom: 1px solid $ii-gray-200;
        margin: 0 0 10px 0;

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