<template>
    <div class="ii-flowable">
        <a-row :gutter='16'
            class="row">
            <a-col :span='10'
                class="col">
                <a-button size='small'
                    slot='extra'
                    icon='plus'>新建</a-button>
                <a-tabs defaultActiveKey="assignee"
                    v-model="activeTab"
                    size="small"
                    @change="onSwitchTabs"
                    class="flowtabs">
                    <a-tab-pane tab="待我处理"
                        class="tabpanel"
                        key="assignee">
                        <assignee-flow-list :processDef="processDef"
                            :user='user'
                            :flowFuncs='flowFuncs'
                            :selectedFlow='selectedFlowsOfTab.assignee'
                            @select="onSelectFlow" />
                    </a-tab-pane>
                    <a-tab-pane tab="由我发起"
                        key="startBySelf">
                        <startby-flow-list :processDef="processDef"
                            :user='user'
                            :flowFuncs='flowFuncs'
                            :selectedFlow='selectedFlowsOfTab.startBySelf'
                            @select="onSelectFlow" />
                    </a-tab-pane>
                    <a-tab-pane tab="与我有关"
                        key="involved">
                        <involved-flow-list :processDef="processDef"
                            :user='user'
                            :flowFuncs='flowFuncs'
                            :selectedFlow='selectedFlowsOfTab.involved'
                            @select="onSelectFlow" />
                    </a-tab-pane>
                </a-tabs>
            </a-col>
            <a-col :span='14'
                class="col">
                <div class="detail">
                    <flow v-if="selectedFlow"
                        :flow='selectedFlow'
                        :user='user'
                        :processDef='processDef' />
                    <ii-empty v-else />
                </div>
            </a-col>
        </a-row>
    </div>
</template>

<script>
import StartBySelfFlowList from './StartBySelfFlowList'
import TaskAssigneeFlowList from './TaskAssigneeFlowList'
import TaskInvolvedFlowList from './TaskInvolvedFlowList'
import Flow from './Flow'

export default {
    components: {
        'assignee-flow-list': TaskAssigneeFlowList,
        'startby-flow-list': StartBySelfFlowList,
        'involved-flow-list': TaskInvolvedFlowList,
        'flow': Flow
    },
    props: ['flowId', 'flowFuncs'],
    data() {
        return {
            processDef: undefined,
            selectedAssigneeFlow: undefined,
            activeTab: 'assignee',
            selectedFlowsOfTab: {}
        }
    },
    mounted() {
        this.$axios.silentGet(`/v1/api/processdefs/${this.flowId}`, true)
            .then((res) => {
                this.processDef = res.data
            })
    },
    methods: {
        onSelectFlow(flow) {
            this.selectedFlowsOfTab = Object.assign({}, this.selectedFlowsOfTab, { [this.activeTab]: flow })
        },
        onSwitchTabs() {
        }
    },
    computed: {
        user() {
            const state = this.$store.state.iota.global.authentication
            return state.user
        },
        selectedFlow() {
            return this.selectedFlowsOfTab[this.activeTab]
        }
    }
}
</script>

<style lang="stylus" scoped>
.ii-flowable {
    height: 100%;
    width: 100%;
    overflow: hidden;

    .row {
        height: 100%;
    }

    .col {
        height: 100%;

        .flowtabs {
            height: 100%;
            display: flex;
            flex-direction: column;
            background-color: white;
            padding: 10px;

            .tabpanel {
                height: 100%;
            }

            /deep/ .ant-tabs-bar {
                margin: 0;
            }
        }
    }

    .detail {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        height: 100%;
        background-color: white;
    }

    /deep/ .ant-tabs-content {
        padding-left: 0;
        height: 100%;
    }
}
</style>