
<script>
import { message } from 'ant-design-vue/es'
import moment from 'moment'
import * as U from '../../util'

export default {
    props: ['user', 'flow', 'active', 'processDef'],
    data() {
        return {
            running: {
                items: []
            },
            finished: {
                items: []
            },
            // 被赋予的组
            assignedRoles: [],
            assignedOrganizations: [],
            assignedPositions: [],
            // 可操作的组和用户
            subUsers: [],
            roles: [],
            organizations: [],
            positions: [],
            // 任务操作
            currentTask: undefined,
            // 更新指派
            showAssignee: false,
            currentAssigneeUser: undefined,
            // 更新candidateUsers
            candidateUsersSearch: undefined,
            showCandidateUsers: false,
            // 更新candidateGroups
            candidateGroupsSearch: undefined,
            showCandidateGroups: false,
            // 更新dueDate
            showDueDate: false,
            dueDate: moment().add(1, 'd').endOf('day'),
            // bpmn
            bpmnDef: undefined
        }
    },
    mounted() {
        this.refetchRBAC()//只获取一次权限信息
        this.refetch()
        this.fetchBPMNDef()
    },
    watch: {
        flow: {
            handler() {
                this.refetch()
            },
            deep: true
        },
        active: {
            handler() {
                this.refetch()
            }
        }
    },
    methods: {
        async fetchBPMNDef() {
            this.bpmnDef = await U.fetchBPMNDef(this.flow.processDefinitionId)
        },
        refetchRBAC() {
            // 拥有的
            this.$fetchUsers().then((subUsers) => {
                this.subUsers = subUsers
            })
            this.$fetchOrganizations().then((organizations) => {
                this.organizations = organizations
            })
            this.$fetchPositions().then((positions) => {
                this.positions = positions
            })
            this.$fetchRoles().then((roles) => {
                this.roles = roles
            })
            // 被赋予的
            this.$fetchAssignedOrganizations().then((assignedOrganizations) => {
                this.assignedOrganizations = assignedOrganizations
            })
            this.$fetchAssignedPositions().then((assignedPositions) => {
                this.assignedPositions = assignedPositions
            })
            this.$fetchAssignedRoles().then((assignedRoles) => {
                this.assignedRoles = assignedRoles
            })
        },
        refetch() {
            if (!this.active) {
                return
            }
            this.$axios.silentPost(`/fl/process/query/historic-task-instances`, {
                size: 2000,// 不支持分页，暂时认为没有这么多任务流程
                processInstanceId: this.flow.processInstanceId,
                includeIdentityLinks: true,
                sort: 'startTime',
                order: 'desc'
            }, true)
                .then((res) => {
                    this.running.items = []
                    this.finished.items = []
                    res.data.data.forEach(d => {
                        d.assignee = U.parseAssignee(d.assignee)
                        d.startTime = moment(d.startTime).format('YYYY-MM-DD')
                        if (d.endTime) {
                            d.endTime = moment(d.endTime).format('YYYY-MM-DD')
                            this.finished.items.push(d)
                        } else {
                            if (d.dueDate) {
                                d.dueDate = moment(d.dueDate).format('YYYY-MM-DD')
                            }
                            if (this.$refs._bpmn) {
                                this.$refs._bpmn.colorNode(d.taskDefinitionKey)
                            }
                            this.running.items.push(d)
                        }
                    })
                }).catch(() => {
                    this.running.items = []
                    this.finished.items = []
                })
        },
        // Assignee 
        onAssignee(task) {
            this.currentTask = task
            this.showAssignee = true
        },
        onAssigneeOk() {
            if (!this.currentAssigneeUser) {
                return
            }
            this.$axios.silentPut(`/fl/process/runtime/tasks/${this.currentTask.id}`, {
                assignee: this.currentAssigneeUser
            }, true).then(() => {
                message.success('指派成功')
                this.currentTask.assignee = U.parseAssignee(this.currentAssigneeUser)
                this.showAssignee = false
                this.currentAssigneeUser = undefined
            }).catch(() => {
                message.error('指派失败，请稍后再试')
            })
        },
        onAssigneeCancel() {
            this.showAssignee = false
        },

        // Candidate Users
        onCandidateUsers(task) {
            this.currentTask = task
            this.showCandidateUsers = true
        },
        onCandidateUsersCancel() {
            this.showCandidateUsers = false
        },
        onCandidateUserChecked(e, user, link) {
            if (e.target.checked) {
                if (this.$p('/fl/process/runtime/tasks/:taskId/identitylinks/users:POST')) {
                    this.$axios.silentPost(`/fl/process/runtime/tasks/${this.currentTask.id}/identitylinks`, {
                        type: 'candidate',
                        user: U.idOfUser(user)
                    }, true)
                        .then((res) => {
                            this.currentTask.identityLinks.push(res.data)
                        }).catch(() => {
                            message.error('操作失败，请稍后再试')
                        })
                }
            } else {
                if (this.$p('/fl/process/runtime/tasks/:taskId/identitylinks/users/:user/:type:DELETE')) {
                    let filter = () => {
                        this.currentTask.identityLinks = this.currentTask.identityLinks.filter(l => {
                            // return link.id !== l.id
                            return link.user !== l.user
                        })
                    }
                    this.$axios.silentDelete(`/fl/process/runtime/tasks/${this.currentTask.id}/identitylinks/users/${link.user}/${link.type}`, true)
                        .then(() => {
                            filter()
                        }).catch((res) => {
                            if (res.status === 404) {
                                filter()
                            } else {
                                message.error('操作失败，请稍后再试')
                            }
                        })
                }
            }
        },

        // Candidate Groups
        onCandidateGroups(task) {
            this.currentTask = task
            this.showCandidateGroups = true
        },
        onCandidateGroupsCancel() {
            this.showCandidateGroups = false
        },
        onCandidateGroupChecked(e, groupId, link) {
            if (e.target.checked) {
                if (this.$p('/fl/process/runtime/tasks/:taskId/identitylinks/groups:POST')) {
                    this.$axios.silentPost(`/fl/process/runtime/tasks/${this.currentTask.id}/identitylinks`, {
                        type: 'candidate',
                        group: groupId
                    }, true)
                        .then((res) => {
                            this.currentTask.identityLinks.push(res.data)
                        }).catch(() => {
                            message.error('操作失败，请稍后再试')
                        })
                }
            } else {
                if (this.$p('/fl/process/runtime/tasks/:taskId/identitylinks/groups/:group/:type:DELETE')) {
                    let filter = () => {
                        this.currentTask.identityLinks = this.currentTask.identityLinks.filter(l => {
                            // return link.id !== l.id
                            return link.group !== l.group
                        })
                    }
                    this.$axios.silentDelete(`/fl/process/runtime/tasks/${this.currentTask.id}/identitylinks/groups/${link.group}/${link.type}`, true)
                        .then(() => {
                            filter()
                        }).catch((res) => {
                            if (res.status === 404) {
                                filter()
                            } else {
                                message.error('操作失败，请稍后再试')
                            }
                        })
                }
            }
        },

        // claim
        onClaim(task) {
            let assignee = U.idOfUser(this.user)
            // 使用PUT强制认领，但是提前判断了是否可以认领
            this.$axios.silentPut(`/fl/process/runtime/tasks/${task.id}`, {
                // action: 'claim', 
                assignee: assignee
            }, true).then(() => {
                message.success('认领成功')
                task.assignee = U.parseAssignee(assignee)
            }).catch(() => {
                message.error('认领失败，请稍后再试')
            })
        },

        // dueDate 
        onDueDate(task) {
            this.currentTask = task
            this.showDueDate = true
        },
        onDueDateOk() {
            if (!this.dueDate) {
                return
            }
            this.$axios.silentPut(`/fl/process/runtime/tasks/${this.currentTask.id}`, {
                dueDate: this.dueDate
            }, true).then(() => {
                message.success('设置成功')
                this.currentTask.dueDate = this.dueDate.format('YYYY-MM-DD HH:mm:ss')
                this.showDueDate = false
                this.dueDate = moment().add(1, 'd').endOf('day')
            }).catch(() => {
                message.error('设置失败，请稍后再试')
            })
        },
        onDueDateCancel() {
            this.showDueDate = false
        },
        renderBpmn() {
            return (
                <div class='bpmn'>
                    <h6>流程图</h6>
                    {
                        this.bpmnDef ?
                            <ii-bpmn defineXML={this.bpmnDef} ref='_bpmn' />
                            :
                            <ii-empty />
                    }
                </div>
            )
        },
        renderRunning() {
            const disabled = this.flow.finished || this.flow.suspended
            const columns = [
                {
                    title: '流程节点',
                    dataIndex: 'name',
                    key: 'name',
                },
                {
                    title: '处理人',
                    dataIndex: 'assignee',
                    key: 'assignee',
                    width: '12% ',
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
                    dataIndex: 'dueDate',
                    key: 'dueDate',
                    width: '20% '
                },
                {
                    title: '操作',
                    dataIndex: 'operation',
                    width: '18%',
                    customRender: (text, record) => {
                        let claimable = this.$p('/fl/process/runtime/tasks/:id/claim:PUT')
                            && U.isTaskClaimable({
                                task: record,
                                user: this.user,
                                assignedOrganizations: this.assignedOrganizations,
                                assignedPositions: this.assignedPositions,
                                assignedRoles: this.assignedRoles
                            })
                        let assigneeable = this.$p('/fl/process/runtime/tasks/:id/assignee:PUT')
                            && U.isTaskAssigneeable({ task: record, user: this.user })
                        let editCandidateUsers = this.$p('/fl/process/runtime/tasks/:taskId/identitylinks/users:POST')
                            || this.$p('/fl/process/runtime/tasks/:taskId/identitylinks/users/:user/:type:DELETE')
                        let editCandidateGroups = this.$p('/fl/process/runtime/tasks/:taskId/identitylinks/groups:POST')
                            || this.$p('/fl/process/runtime/tasks/:taskId/identitylinks/groups/:group/:type:DELETE')
                        return disabled ?
                            null
                            : <div class='operation' >
                                {assigneeable ? <a onClick={() => this.onAssignee(record)}>{record.assignee && record.assignee.id ? '重新指派' : '指派'}</a> : null}
                                {claimable ? <a onClick={() => this.onClaim(record)}>认领</a> : null}
                                {editCandidateUsers ? <a onClick={() => this.onCandidateUsers(record)}>候选人</a> : null}
                                {editCandidateGroups ? <a onClick={() => this.onCandidateGroups(record)}>候选组</a> : null}
                                <a onClick={() => this.onDueDate(record)}>{record.dueDate ? '更新到期时间' : '设置到期时间'}</a>
                            </div>
                    }
                }
            ]
            return (
                <div class='running'>
                    <h6>待处理</h6>
                    <IiTableLayout
                        size='small'
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
                        size='small'
                        headheight={68}
                        showSizeChanger={false}
                        className={'table'}
                        showPagination='none'
                        columns={columns}
                        rows={this.finished.items}>
                    </IiTableLayout>
                </div>
            )
        },
        renderAssigneeEditor() {
            let filter = (input, option) => {
                return option.componentOptions.children[0].text.toLowerCase().indexOf(input.toLowerCase()) >= 0
            }
            const users = this.subUsers.concat(this.user)
            return (
                <a-modal title="重新指派"
                    bodyStyle={{ maxHeight: "80%", padding: "10px" }}
                    visible={this.showAssignee}
                    onOk={this.onAssigneeOk}
                    onCancel={this.onAssigneeCancel}>
                    <div class='assignee-select' style={{ textAlign: 'center' }}>
                        <span style={{ marginRight: '10px' }}> 指派给: </span>
                        <a-select vModel={this.currentAssigneeUser} showSearch
                            style={{ width: '200px' }} filterOption={filter}>
                            {
                                users.map((user) => {
                                    return <a-select-option value={U.idOfUser(user)}>{U.nameOfUser(user)}</a-select-option>
                                })
                            }
                        </a-select>
                    </div>
                </a-modal>
            )
        },
        renderCandidateUsersEditor() {
            if (!this.currentTask) {
                return null
            }
            const users = this.subUsers.concat(this.user)
            return (
                <a-modal title="候选人"
                    bodyStyle={{ padding: "10px", height: '400px', display: 'flex', flexDirection: 'column' }}
                    visible={this.showCandidateUsers}
                    width={600}
                    onCancel={this.onCandidateUsersCancel}
                    footer={null}>
                    <a-input-search style={{ width: '250px', margin: '0 auto' }} placeholder="用户名" vModel={this.candidateUsersSearch}></a-input-search>
                    <div style={{ flex: 1 }} >
                        {users.map((user) => {
                            let fullname = user.userExt ? user.userExt.fullname : ''
                            if (this.candidateUsersSearch
                                && fullname.toLowerCase().indexOf(this.candidateUsersSearch.toLowerCase()) === -1
                                && user.username.toLowerCase().indexOf(this.candidateUsersSearch.toLowerCase()) === -1) {
                                return null
                            }
                            let link = this.currentTask.identityLinks.find(c => {
                                return c.type === 'candidate' && c.user === U.idOfUser(user)
                            })
                            return (<a-checkbox style={{ width: '50%', padding: '10px', margin: 0 }}
                                checked={link !== undefined} onChange={(e) => this.onCandidateUserChecked(e, user, link)}>
                                {U.nameOfUser(user)}
                            </a-checkbox>)
                        })}
                    </div>
                </a-modal>
            )
        },
        renderCandidateGroupsEditor() {
            if (!this.currentTask) {
                return null
            }
            const colStyle = { height: '100%', overflowY: 'auto' }
            const titleStyle = { fontSize: '15px', fontWeight: '700', borderBottom: '1px solid #eeeeee', margin: '5px' }
            return (
                <a-modal title="候选组"
                    bodyStyle={{ padding: "10px", height: '400px', display: 'flex', flexDirection: 'column' }}
                    visible={this.showCandidateGroups}
                    width={600}
                    onCancel={this.onCandidateGroupsCancel}
                    footer={null}>
                    <a-input-search style={{ width: '250px', margin: '0 auto' }} placeholder="群组名" vModel={this.candidateGroupsSearch}></a-input-search>
                    <a-row style={{ flex: 1 }}>
                        <a-col span={8} style={colStyle}>
                            <div style={titleStyle}>组织</div>
                            {this.organizations.map((organization) => {
                                if (this.candidateGroupsSearch
                                    && organization.name.toLowerCase().indexOf(this.candidateGroupsSearch.toLowerCase()) === -1) {
                                    return null
                                }
                                let link = this.currentTask.identityLinks.find(c => {
                                    return c.type === 'candidate' && c.group === U.idOfOrganization(organization)
                                })
                                return (<a-checkbox style={{ width: '100%', padding: '10px', margin: 0 }}
                                    checked={link !== undefined} onChange={(e) => this.onCandidateGroupChecked(e, U.idOfOrganization(organization), link)}>
                                    {organization.name}
                                </a-checkbox>)
                            })}
                        </a-col >
                        <a-col span={8} style={colStyle}>
                            <div style={titleStyle}>角色</div>
                            {this.roles.map((role) => {
                                if (this.candidateGroupsSearch
                                    && role.name.toLowerCase().indexOf(this.candidateGroupsSearch.toLowerCase()) === -1) {
                                    return null
                                }
                                let link = this.currentTask.identityLinks.find(c => {
                                    return c.type === 'candidate' && c.group === U.idOfRole(role)
                                })
                                return (<a-checkbox style={{ width: '100%', padding: '10px', margin: 0 }}
                                    checked={link !== undefined} onChange={(e) => this.onCandidateGroupChecked(e, U.idOfRole(role), link)}>
                                    {role.name}
                                </a-checkbox>)
                            })}
                        </a-col>
                        <a-col span={8} style={colStyle}>
                            <div style={titleStyle}>职位</div>
                            {this.positions.map((position) => {
                                if (this.candidateGroupsSearch
                                    && position.name.toLowerCase().indexOf(this.candidateGroupsSearch.toLowerCase()) === -1) {
                                    return null
                                }
                                let link = this.currentTask.identityLinks.find(c => {
                                    return c.type === 'candidate' && c.group === U.idOfPosition(position)
                                })
                                return (<a-checkbox style={{ width: '100%', padding: '10px', margin: 0 }}
                                    checked={link !== undefined} onChange={(e) => this.onCandidateGroupChecked(e, U.idOfPosition(position), link)}>
                                    {position.name}
                                </a-checkbox>)
                            })}
                        </a-col>
                    </a-row>
                </a-modal>
            )
        },
        renderDueDateEditor() {
            return (
                <a-modal title="到期时间"
                    bodyStyle={{ maxHeight: "80%", padding: "10px" }}
                    visible={this.showDueDate}
                    onOk={this.onDueDateOk}
                    onCancel={this.onDueDateCancel}>
                    <div class='duedate-select' style={{ textAlign: 'center' }}>
                        <span style={{ marginRight: '10px' }}> 时间: </span>
                        <a-date-picker vModel={this.dueDate}
                            showTime={{ defaultValue: moment('00:00:00', 'HH:mm:ss') }}
                            showToday={false}
                            style={{ width: '200px' }} />
                    </div>
                </a-modal>
            )
        },
    },

    render() {
        return (
            <div class='ii-task'>
                {
                    this.$p('/fl/process/query/historic-task-instances:POST') ?
                        this.renderRunning()
                        : null
                }
                {
                    this.$p('/fl/process/query/historic-task-instances:POST') ?
                        this.renderFinished()
                        : null
                }
                {
                    this.$p('/fl/process/repository/process-definitions/:flowableInstance/resourcedata:GET') ?
                        this.renderBpmn()
                        : null
                }
                {this.renderAssigneeEditor()}
                {this.renderCandidateUsersEditor()}
                {this.renderCandidateGroupsEditor()}
                {this.renderDueDateEditor()}
            </div >
        )
    }
}
</script>

<style lang="stylus" scoped>
@import '../../../../../styles/imports';

.ii-task {
    height: 100%;
    overflow-y: auto;

    h6 {
        margin: 0 10px;
        border-bottom: 1px solid $ii-gray-200;
    }

    .bpmn {
        height: 400px;
        width: 100%;
        background-color: white;
        position: relative;
    }

    .running {
        height: 240px;
        display: flex;
        flex-direction: column;
        background-color: white;

        .operation {
            a {
                display: block;
                color: $primary-color;
            }
        }
    }

    .finished {
        height: 240px;
        display: flex;
        flex-direction: column;
        background-color: white;
    }
}
</style>