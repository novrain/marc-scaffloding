<script>
// import { message } from 'ant-design-vue/es'
// import * as U from '../../util'
// import StartBySelfExplorer from './StartBySelfExplorer'
import TaskAssigneeExplorer from './SimpleTaskAssigneeExplorer'
// import TaskInvolvedExplorer from './TaskInvolvedExplorer'
import FlowHelperMixin from '../components/FlowHelperMixin'

export default {
    props: ['processDefinitionKey', 'redirect'],
    components: {
        'assignee-explorer': TaskAssigneeExplorer,
        // 'startby-explorer': StartBySelfExplorer,
        // 'involved-explorer': TaskInvolvedExplorer,
    },
    mixins: [FlowHelperMixin],
    data() {
        return {
            activeTab: 'assignee',
            selectedFlowsOfTab: {}
        }
    },
    mounted() {
    },
    computed: {
    },
    methods: {
        onSelectFlow() {

        }
    },
    render() {
        // 没有这个模块的访问权限，就不显示
        return this.$m(this.redirect) && this.processDefinitionKey ? (
            <a-card title={this.processdef ? this.processdef.name : ''} size='small' class='ii-flow-widget'
                bodyStyle={{ padding: "10px", flex: 1 }}>
                <a slot='extra' onClick={() => {
                    this.$router.push({ path: this.redirect })
                }}>前往处理</a>
                <assignee-explorer
                    processDefinitionKey={this.processDefinitionKey}
                    processdef={this.processdef}
                    flowHelper={this.helper}
                    user={this.$user}
                    selectedFlow={this.selectedFlowsOfTab.assignee}
                    active={this.activeTab === "assignee"}
                    onSelect={this.onSelectFlow} />
            </a-card>)
            : null
    }
}
</script>

<style lang="stylus" scoped>
@import '../../../../../styles/imports';

.ii-flow-widget {
    display: flex;
    flex-direction: column;
    width: 100%;
    height: 100%;

    a {
        color: $primary-color;
    }

    /deep/ .table {
        padding: 0;
    }
}
</style>