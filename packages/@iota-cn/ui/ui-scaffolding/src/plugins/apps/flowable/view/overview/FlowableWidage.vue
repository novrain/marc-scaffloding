<script>
// import { message } from 'ant-design-vue/es'
// import * as U from '../../util'
// import StartBySelfExplorer from './StartBySelfExplorer'
import TaskAssigneeExplorer from './SimpleTaskAssigneeExplorer'
// import TaskInvolvedExplorer from './TaskInvolvedExplorer'

export default {
    props: ['flowId', 'flowHelper', 'redirect'],
    components: {
        'assignee-explorer': TaskAssigneeExplorer,
        // 'startby-explorer': StartBySelfExplorer,
        // 'involved-explorer': TaskInvolvedExplorer,
    },
    data() {
        return {
            processDef: undefined,
            activeTab: 'assignee',
            selectedFlowsOfTab: {}
        }
    },
    mounted() {
        this.$axios.silentGet(`/v1/api/processdefs/${this.flowId}`)
            .then((res) => {
                this.processDef = res.data
            })
    },
    computed: {
        user() {
            const state = this.$store.state.iota.global.authentication
            return state.user
        },
    },
    methods: {
        onSelectFlow() {

        }
    },
    render() {
        const name = this.processDef ? this.processDef.name : ''
        return (
            <a-card title={name} size='small' class='ii-flow-widage'
                bodyStyle={{ padding: "1px", flex: 1 }}>
                <a slot='extra' href={this.redirect}>前往处理</a>
                {
                    this.processDef ? <assignee-explorer processDef={this.processDef}
                        user={this.user}
                        flowHelper={this.flowHelper}
                        selectedFlow={this.selectedFlowsOfTab.assignee}
                        active={this.activeTab === "assignee"}
                        onSelect={this.onSelectFlow} />
                        :
                        null
                }
            </a-card>
        )
    }
}
</script>

<style lang="stylus" scoped>
@import '../../../../../styles/imports';

.ii-flow-widage {
    a {
        color: $primary-color;
    }

    /deep/ .table {
        padding: 0;

        * {
            border: none;
        }
    }
}
</style>