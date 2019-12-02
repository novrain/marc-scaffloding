<script>
import { message } from 'ant-design-vue/es'
import * as U from '../util'
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
    props: ['flowId', 'flowHelper'],
    data() {
        const state = this.$store.state.iota.global.authentication
        const systemVariables = {
            initiatorId: state.user.id,
            initiatorName: state.user.fullname || state.user.username,
            initiatorUser: U.idOfUser(state.user)
        }
        const layout = this.flowHelper.layout || 'table'
        return {
            processDef: undefined,
            selectedAssigneeFlow: undefined,
            activeTab: 'assignee',
            selectedFlowsOfTab: {},
            // new process
            showAdd: false,
            systemVariables: systemVariables,
            processVariables: {
                ...systemVariables
            },
            layout
        }
    },
    mounted() {
        this.$axios.silentGet(`/v1/api/processdefs/${this.flowId}`)
            .then((res) => {
                this.processDef = res.data
                this.$axios.silentGet(`/fl/process/repository/process-definitions/${this.processDef.flowableInstance}/resourcedata`)
                    .then(res => {
                        this.processDef.bpmnDef = res.data
                    })
            })
    },
    computed: {
        user() {
            const state = this.$store.state.iota.global.authentication
            return state.user
        },
        selectedFlow() {
            return this.selectedFlowsOfTab[this.activeTab]
        },
        formDef() {
            if (this.processDef) {
                let def = JSON.parse(this.processDef.formDef)
                def.globalConfig = {
                    style: {
                        formCls: 'ii-nc-form'
                    },
                    constants: {
                        initiatorId: this.user.id,
                        initiatorName: this.user.fullname || this.user.username,
                        currentTaskId: 'start'
                    }
                }
                return def
            } else {
                return undefined
            }
        },
        formWidth() {
            const formUi = this.processDef ? (this.processDef.formDef.ui || { width: 700 }) : { width: 700 }
            return formUi.width || 700
        }
    },
    methods: {
        onSelectFlow(flow) {
            this.selectedFlowsOfTab = Object.assign({}, this.selectedFlowsOfTab, { [this.activeTab]: flow })
        },
        onSwitchTabs() {
        },
        onAddItem() {
            this.showAdd = true
        },
        onAddItemOk() {
            this.$ncformValidate('_addItemForm').then(data => {
                if (data.result) {
                    const variables = []
                    Object.keys(this.processVariables).forEach(k => {
                        variables.push({
                            name: k,
                            value: this.processVariables[k]
                        })
                    })
                    Object.keys(this.systemVariables).forEach(k => {
                        variables.push({
                            name: k,
                            value: this.systemVariables[k]
                        })
                    })
                    let process = {
                        processDefinitionId: this.processDef.flowableInstance,
                        returnVariables: true,
                        variables: variables
                    }
                    // 允许增加参数
                    if (this.flowHelper && this.flowHelper.create) {
                        process = this.flowHelper.create({ processDef: this.processDef, process: process })
                    }
                    this.$axios.silentPost(`/fl/process/runtime/process-instances`, process, true)
                        .then(() => {
                            message.success('新建成功，请在 由我发起 中查看')
                            this.showAdd = false
                            this.processVariables = {
                                ...this.systemVariables
                            }
                        }).catch(() => {
                            message.error('新建失败，请稍后再试')
                        })
                }
            })
        },
        onAddItemCancel() {
            this.showAdd = false
            this.processVariables = {
                ...this.systemVariables
            }
        },
        onSubmit({ flow }) {
            let task = Object.assign({}, flow.task, { finished: true })
            this.selectedFlowsOfTab[this.activeTab] = Object.assign({}, flow, {
                // finished: true, //强制修改临时状态，防止误操作
                task: task
            })
        },
        renderFlows() {
            return (
                <div class={this.layout}>
                    <a-modal title="新建任务"
                        bodyStyle={{ maxHeight: "80%", padding: "10px" }}
                        width={this.formWidth}
                        visible={this.showAdd}
                        onOk={this.onAddItemOk}
                        onCancel={this.onAddItemCancel}>
                        {
                            this.formDef ?
                                <ncform formName='_addItemForm'
                                    formSchema={this.formDef}
                                    v-model={this.processVariables} />
                                :
                                null
                        }
                    </a-modal>
                    <a-button size='small'
                        disabled={!this.formDef}
                        class="new-flow"
                        onClick={this.onAddItem}
                        icon='plus'>新建</a-button>
                    <a-tabs defaultActiveKey="assignee"
                        v-model={this.activeTab}
                        size="small"
                        class="flowtabs">
                        <a-tab-pane tab="待我处理"
                            class="tabpanel"
                            key="assignee">
                            <assignee-flow-list processDef={this.processDef}
                                layout={this.layout}
                                user={this.user}
                                flowHelper={this.flowHelper}
                                selectedFlow={this.selectedFlowsOfTab.assignee}
                                active={this.activeTab === "assignee"}
                                onSelect={this.onSelectFlow} />
                        </a-tab-pane>
                        <a-tab-pane tab="由我发起"
                            key="startBySelf">
                            <startby-flow-list processDef={this.processDef}
                                layout={this.layout}
                                user={this.user}
                                flowHelper={this.flowHelper}
                                selectedFlow={this.selectedFlowsOfTab.startBySelf}
                                active={this.activeTab === "startBySelf"}
                                onSelect={this.onSelectFlow} />
                        </a-tab-pane>
                        <a-tab-pane tab="与我有关"
                            key="involved">
                            <involved-flow-list processDef={this.processDef}
                                layout={this.layout}
                                user={this.user}
                                flowHelper={this.flowHelper}
                                selectedFlow={this.selectedFlowsOfTab.involved}
                                active={this.activeTab === "involved"}
                                onSelect={this.onSelectFlow} />
                        </a-tab-pane>
                    </a-tabs>
                </div>
            )
        },
        renderSigleFlow() {
            return (
                <div class="detail">
                    {
                        this.selectedFlow ?
                            <flow
                                flow={this.selectedFlow}
                                user={this.user}
                                processDef={this.processDef}
                                onSubmit={this.onSubmit} />
                            :
                            <ii-empty />
                    }
                </div>
            )
        }
    },
    render() {
        return (
            <div class="ii-flowable">
                {
                    this.layout === 'list' ?
                        <a-row gutter={16}
                            class="row">
                            <a-col span={10}
                                class="col">
                                {this.renderFlows()}
                            </a-col>
                            <a-col span={14}
                                class="col">
                                {this.renderSigleFlow()}
                            </a-col>
                        </a-row>
                        :
                        <splitpanes horizontal class="default-theme">
                            <splitpane size='35' min-size="20" max-size="60">
                                {this.renderFlows()}
                            </splitpane>
                            <splitpane size='65' style={{ flex: 1 }}>
                                {this.renderSigleFlow()}
                            </splitpane>
                        </splitpanes>
                }
            </div>
        )
    }
}
</script>

<style lang="stylus" scoped>
@import '../../../../styles/imports';

.ii-flowable {
    height: 100%;
    width: 100%;
    overflow: hidden;

    .row {
        height: 100%;
    }

    .col {
        height: 100%;
    }

    .list, .table {
        height: 100%;
        position: relative;

        .new-flow {
            position: absolute;
            right: 18px;
            z-index: 1;
            top: 11px;
        }

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

    /deep/ .splitpanes__splitter {
        background-color: $ii-gray-100;
    }
}
</style>