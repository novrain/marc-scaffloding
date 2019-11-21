
<script>
import moment from 'moment'
import * as U from '../util'

export default {
    props: ['user', 'flow'],
    data() {
        return {
            running: {
                items: []
            },
            finished: {
                items: []
            }
        }
    },
    mounted() {
        this.refetch()
    },
    methods: {
        refetch() {
            this.$axios.silentPost(`/fl/process/query/historic-task-instances`, {
                size: 2000,// 不支持分页，暂时认为没有这么多任务流程
                processInstanceId: this.flow.processInstanceId,
                includeIdentityLinks: true
            }, true)
                .then((res) => {
                    res.data.data.forEach(d => {
                        d.assignee = U.parseAssignee(d.assignee)
                        d.startTime = moment(d.startTime).format('YYYY-MM-DD HH:mm:ss')
                        if (d.endTime) {
                            d.endTime = moment(d.endTime).format('YYYY-MM-DD HH:mm:ss')
                            this.finished.push(d)
                        } else {
                            if (d.dueDate) {
                                d.dueDate = moment(d.dueDate).format('YYYY-MM-DD HH:mm:ss')
                            }
                            this.running.items.push(d)
                        }
                    })
                }).catch(() => { })
        },
        renderBpmn() {
            return (
                <div class='bpmn'>
                    <ii-empty />
                </div>
            )
        },
        renderRunning() {

            const columns = [
                {
                    title: '流程节点',
                    dataIndex: 'name',
                    key: 'name',
                    width: '20%',
                },
                {
                    title: '处理人',
                    dataIndex: 'assignee',
                    key: 'assignee',
                    width: '20% ',
                    customRender: (text, record) => {
                        let user = record.assignee || {}
                        return user.fullname || user.username || record.createdBy
                    }
                },
                {
                    title: '开始时间',
                    dataIndex: 'startTime',
                    key: 'startTime',
                    width: '20% '
                },
                {
                    title: '截至时间',
                    dataIndex: 'endTime',
                    key: 'endTime',
                    width: '20% '
                },
                {
                    title: '操作',
                    dataIndex: 'operation',
                    width: '20%',
                    customRender: () => {
                        return (
                            <div class='operation'>
                                <a>指派</a>
                                <ADivider type="vertical" />
                                <a>认领</a>
                                <ADivider type="vertical" />
                                <a>取消</a>
                            </div>
                        )
                    }
                }
            ]
            return (
                <div class='running'>
                    <h6>待处理</h6>
                    <IiTableLayout
                        size='middle'
                        headheight={68}
                        showSizeChanger={false}
                        className={'table'}
                        showPagination='none'
                        columns={columns}
                        rows={this.running.items}>
                    </IiTableLayout>
                </div>
            )
        },
        renderFinished() {

            const columns = [
                {
                    title: '流程节点',
                    dataIndex: 'name',
                    key: 'name',
                    width: '30%',
                },
                {
                    title: '处理人',
                    dataIndex: 'assignee',
                    key: 'assignee',
                    width: '30% ',
                    customRender: (text, record) => {
                        let user = record.assignee || {}
                        return user.fullname || user.username || record.createdBy
                    }
                },
                {
                    title: '开始时间',
                    dataIndex: 'startTime',
                    key: 'startTime',
                    width: '20% '
                },
                {
                    title: '完成时间',
                    dataIndex: 'endTime',
                    key: 'endTime',
                    width: '20% '
                }
            ]
            return (
                <div class='finished'>
                    <h6>已完成</h6>
                    <IiTableLayout
                        size='middle'
                        headheight={68}
                        showSizeChanger={false}
                        className={'table'}
                        showPagination='none'
                        columns={columns}
                        rows={this.finished.items}>
                    </IiTableLayout>
                </div>
            )
        }
    },

    render() {
        return (
            <div class='ii-task'>
                {this.renderBpmn()}
                {this.renderRunning()}
                {this.renderFinished()}
            </div >
        )
    }
}
</script>

<style lang="stylus" scoped>
@import '../../../../styles/imports';

.ii-task {
    height: 100%;
    display: flex;
    flex-direction: column;

    h6 {
        margin: 0 10px;
        border-bottom: 1px solid $ii-gray-200;
    }

    .bpmn {
        height: 36%;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .running {
        height: 32%;

        .operation {
            display: flex;
            justify-content: left;
            align-items: center;

            a {
                color: $primary-color;
            }
        }
    }

    .finished {
        height: 32%;
    }
}
</style>