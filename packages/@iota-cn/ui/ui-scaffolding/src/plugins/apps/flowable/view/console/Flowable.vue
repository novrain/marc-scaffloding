<script>
import { message } from 'ant-design-vue/es'
import * as U from '../../util'
import StartBySelfExplorer from './StartBySelfExplorer'
import TaskAssigneeExplorer from './TaskAssigneeExplorer'
import TaskInvolvedExplorer from './TaskInvolvedExplorer'
import Flow from '../components/Flow'
import FlowHelperMixin from '../components/FlowHelperMixin'

export default {
    components: {
        'assignee-explorer': TaskAssigneeExplorer,
        'startby-explorer': StartBySelfExplorer,
        'involved-explorer': TaskInvolvedExplorer,
        'flow': Flow
    },
    mixins: [FlowHelperMixin],
    props: [
        'processDefinitionKey'
    ],
    data() {
        // 这里无法使用全局的计算属性
        const state = this.$store.state.iota.global.authentication
        const systemVariables = {
            initiatorId: state.user.id,
            initiatorName: U.nameOfUser(state.user),
            initiatorUser: U.idOfUser(state.user)
        }
        return {
            activeTab: 'assignee',
            selectedFlowsOfTab: {},
            // new process
            showAdd: false,
            systemVariables: systemVariables,
            processVariables: {
                ...systemVariables
            }
        }
    },
    mounted() {
    },
    computed: {
        selectedFlow() {
            return this.selectedFlowsOfTab[this.activeTab]
        },
        layout() {
            return this.helper ? this.helper.layout || 'table' : 'table'
        }
    },
    methods: {
        onSelectFlow(flow) {
            this.selectedFlowsOfTab = Object.assign({}, this.selectedFlowsOfTab, { [this.activeTab]: flow })
        },
        // 单流程模式的新建
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
                        processDefinitionKey: this.processDefinitionKey,
                        returnVariables: true,
                        variables: variables
                    }
                    // 允许增加参数
                    if (this.helper && this.helper.create) {
                        process = this.helper.create({ processdef: this.processdef, process: process })
                    }
                    process.variables = U.encodeFormVariables(process.variables)
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
        renderTab(component, key) {
            if (this.processDefinitionKey) {
                if (this.helper && this.processdef) {
                    return <component
                        is={component}
                        id={this.id}
                        containerId={this.containerId}
                        processDefinitionKey={this.processDefinitionKey}
                        processdef={this.processdef}
                        flowHelper={this.helper}
                        layout={this.layout}
                        user={this.$user}
                        selectedFlow={this.selectedFlowsOfTab[key]}
                        active={this.activeTab === key}
                        onSelect={this.onSelectFlow} />
                } else {
                    return null
                }
            } else {
                return <component
                    is={component}
                    id={this.id}
                    containerId={this.containerId}
                    layout={this.layout}
                    user={this.$user}
                    selectedFlow={this.selectedFlowsOfTab[key]}
                    active={this.activeTab === key}
                    onSelect={this.onSelectFlow} />
            }
        },
        renderFlows() {
            return <div class={this.layout}>
                {
                    this.processDefinitionKey ? // 单流程模式
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
                        : null
                }
                {
                    this.processDefinitionKey && this.$p('/fl/process/runtime/process-instances:POST') ? // 单流程模式
                        <a-button size='small'
                            disabled={!this.formDef}
                            class="new-flow"
                            onClick={this.onAddItem}
                            icon='plus'>新建</a-button>
                        : null
                }
                <a-tabs defaultActiveKey="assignee"
                    v-model={this.activeTab}
                    size="small"
                    class="flowtabs">
                    <a-tab-pane tab="待我处理"
                        class="tabpanel"
                        key="assignee">
                        {this.renderTab('assignee-explorer', 'assignee')}
                    </a-tab-pane>
                    <a-tab-pane tab="由我发起"
                        key="startBySelf">
                        {this.renderTab('startby-explorer', 'startBySelf')}
                    </a-tab-pane>
                    <a-tab-pane tab="与我有关"
                        key="involved">
                        {this.renderTab('involved-explorer', 'involved')}
                    </a-tab-pane>
                </a-tabs>
            </div>
        },
        renderSigleFlow() {
            return (
                <div class="detail">
                    {
                        this.selectedFlow ?
                            <flow
                                flow={this.selectedFlow}
                                user={this.$user}
                                processdef={this.findProcessdef(this.selectedFlow.processDefinitionKey)}
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
@import '../../../../../styles/imports';

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
        height: 0;
        flex: 1;
    }

    /deep/ .splitpanes__splitter {
        background-color: $ii-gray-100;
    }
}
</style>