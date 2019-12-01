<script>
import merge from 'deepmerge'
import moment from 'moment'
import classNames from 'classnames'
import { AuthCheckStrictlyTree, Status, UserEditor } from '../../components'
import RoleOfUser from './RoleOfUser'
import { Menu as AMenu } from 'ant-design-vue'

export default {
    beforeCreate() {
        this.userExtentionForm = this.$form.createForm(this, { name: 'user_extends' });
    },
    data() {
        return {
            users: [],
            selectedRowKeys: [],
            selectedRows: [],
            limit: 20,
            page: 1,
            total: 0,
            currentUserExtention: {},
            currentUserId: undefined
        }
    },
    mounted() {
        this.refetch()
    },
    computed: {
        user() {
            const state = this.$store.state.iota.global.authentication
            return state.user
        }
    },
    methods: {
        onPageChange(page) {
            this.page = page
            this.refetch()
        },

        findUser(id) {
            return this.users.find(u => {
                return u.id === id
            })
        },

        onLimitChange(current, pageSize) {
            this.limit = pageSize
            this.page = 1
            this.refetch()
        },

        refetch() {
            this.$axios.silentGet(`/v1/api/authorizations/users`, true)
                .then((res) => {
                    this.users = res.data.users
                    this.total = res.data.total
                    this.selectedRowKeys = []
                    this.selectedRows = []
                }).catch(() => { })
        },

        renderOrganizations() {
            const { selectedRowKeys } = this
            let child = null
            if (selectedRowKeys.length === 1) {
                const user = this.findUser(this.selectedRowKeys[0])
                child = <AuthCheckStrictlyTree target={user} checkStrictly key={user.id + 'o'}
                    sourceUrlKey='organizations' targetUrlKey='users' resultKey='organizations' />
            }
            return (<ATabPane tab="组织" key="organizations" class='tabpanel'>
                {child}
            </ATabPane>)
        },

        renderPositions() {
            const { selectedRowKeys } = this
            let child = null
            if (selectedRowKeys.length === 1) {
                const user = this.findUser(this.selectedRowKeys[0])
                child = <AuthCheckStrictlyTree target={user} checkStrictly key={user.id + 'p'}
                    sourceUrlKey='positions' targetUrlKey='users' resultKey='positions' />
            }
            return (<ATabPane tab="职位" key="positions" class='tabpanel'>
                {child}
            </ATabPane>)
        },

        renderRoles() {
            const { selectedRowKeys } = this
            let child = null
            if (selectedRowKeys.length === 1) {
                const user = this.findUser(this.selectedRowKeys[0])
                child = <RoleOfUser user={user} key={user.id + 'r'} />
            }
            return (<ATabPane tab="角色" key="roles" class='tabpanel'>
                {child}
            </ATabPane>)
        },

        onSaveUserExtention() {
            this.userExtentionForm.validateFields((err, values) => {
                if (!err) {
                    values.userId = this.currentUserId
                    this.$axios.commonPut(`/v1/api/authorizations/users/${this.currentUserId}/extention`, values, {
                        success: '更新成功',
                        error: '更新失败'
                    }).then(() => {
                    }).catch(() => {
                    })
                }
            })
        },

        renderUserExtention() {
            const { selectedRowKeys } = this
            let child = null
            if (selectedRowKeys.length === 1) {
                child = <div class='user_extends'>
                    <AForm form={this.userExtentionForm}>
                        <ii-user-extends-form form={this.userExtentionForm}
                            extention={this.currentUserExtention}>
                            <a-form-item wrapper-col={{ span: 16, offset: 7 }}
                                slot="item">
                                <a-button type='primary'
                                    onClick={this.onSaveUserExtention}>保存</a-button>
                            </a-form-item>
                        </ii-user-extends-form>
                    </AForm>
                </div>
            }
            return (<ATabPane tab="详细信息" key="extention" class='tabpanel'>
                {child}
            </ATabPane>)
        },

        renderRelated() {
            return <ATabs type="card" class='ii-tabs'>
                {this.renderRoles()}
                {this.renderOrganizations()}
                {this.renderPositions()}
                {this.renderUserExtention()}
            </ATabs>
        },

        onSelectChange(selectedRowKeys, selectedRows) {
            this.selectedRowKeys = selectedRowKeys
            this.selectedRows = selectedRows
        },

        onRowClick(record) {
            let { selectedRowKeys, selectedRows } = this
            if (selectedRowKeys.indexOf(record.id) === -1) {
                selectedRowKeys.push(record.id)
                selectedRows.push(record)
            } else {
                selectedRowKeys = selectedRowKeys.filter(i => i !== record.id)
                selectedRows = selectedRows.filter(i => i.id !== record.id)
            }
            this.selectedRowKeys = selectedRowKeys
            this.selectedRows = selectedRows
            if (selectedRowKeys.length === 1) {
                let userId = selectedRowKeys[0]
                if (userId !== this.currentUserId) {
                    this.currentUserId = userId
                    this.$axios.silentGet(`/v1/api/authorizations/users/${userId}/extention`)
                        .then((res) => {
                            this.currentUserExtention = res.data
                            this.currentUserExtention.birthday = moment(this.currentUserExtention.birthday)
                        })
                }
            }
        },

        rowClassName(record) {
            if (this.selected) {
                if (this.selected.path === record.path) {
                    return 'browser__tree__table__item_seleted'
                }
            }
        },

        onDelete(row) {
            return async () => {
                this.batchDelete(([row.key]), [row])
                return true
            }
        },

        batchDelete(selectedRowKeys, selectedRows) {
            let ids = []
            for (let row of selectedRows) {
                ids.push(row.id)
            }
            return this.$axios.silentDelete(`/v1/api/authorizations/users/${ids[0]}`, true)
                .then(() => {
                    this.refetch()
                }).catch(() => { return true })
        },

        onChangePwd(record, index) {
            return () => {
                return new Promise((resolve, reject) => {
                    this.$refs['password' + record.id].validateFieldsAndScroll((err, values) => {
                        if (!err) {
                            resolve(true)
                            let user = values
                            return this.$axios.commonPut(`/v1/api/authorizations/users/${record.id}`, user, {
                                success: '修改成功',
                                error: '修改失败，没有权限或其他原因。'
                            })
                                .then(() => {
                                    this.users[index] = merge(this.users[index], user)
                                }).catch(() => { return true })
                        }
                        else {
                            reject(false)
                        }
                    }
                    )
                })
            }
        },

        batchOperate(e) {
            let { selectedRows } = this
            let ids = []
            for (let row of selectedRows) {
                ids.push(row.id)
            }
            return this.$axios.commonPost(`/v1/api/authorizations/users/${e.key}`, { ids }, {
                success: '修改成功',
                error: '修改失败，没有权限或其他原因。'
            })
                .then(() => {
                    this.refetch()
                    return true
                }).catch(() => { return true })
        },

        onEdit(record, index) {
            return () => {
                return new Promise((resolve, reject) => {
                    this.$refs['edit' + record.id].validateFieldsAndScroll((err, values) => {
                        if (!err) {
                            resolve(true)
                            let user = values
                            user.subExt = {
                                enable: values.enable
                            }
                            delete user.enable
                            return this.$axios.commonPut(`/v1/api/authorizations/users/${record.id}`, user, {
                                success: '修改成功',
                                error: '修改失败，没有权限或其他原因。'
                            })
                                .then(() => {
                                    this.$refs['edit' + record.id].resetFields()
                                    this.$set(this.users, index, merge(this.users[index], user))
                                }).catch(() => { return true })
                        }
                        else {
                            reject(false)
                        }
                    })
                })
            }
        },

        onAdd() {
            return new Promise((resolve, reject) => {
                this.$refs._add.validateFieldsAndScroll((err, values) => {
                    if (!err) {
                        values.subExt = { enable: values.enable }
                        resolve(true)
                        return this.$axios.commonPost(`/v1/api/authorizations/users`, values, {
                            success: '创建成功',
                            error: '创建失败，没有权限或其他原因。'
                        })
                            .then(() => {
                                this.$refs._add.resetFields()
                                this.refetch()
                            }).catch(() => { return true })
                    }
                    else {
                        reject(false)
                    }
                })
            })
        },

        renderUser() {
            let { user } = this
            const columns = [
                {
                    title: '用户名',
                    dataIndex: 'username',
                    key: 'username',
                    width: '20%',
                },
                {
                    title: '邮箱',
                    dataIndex: 'email',
                    key: 'email',
                    width: '30% ',
                },
                {
                    title: '状态',
                    dataIndex: 'enable',
                    key: 'enable',
                    filters: [{
                        text: '活跃',
                        value: 'true',
                    }, {
                        text: '已禁用',
                        value: 'false',
                    }],
                    width: '15%',
                    onFilter: (value, record) => record.subExt.enable + '' == value,
                    customRender: (text, record) => {
                        return (<Status value={record.subExt.enable} text={record.subExt.enable ? '活跃' : '已禁用'} />)
                    }
                },
                {
                    title: '管理员',
                    dataIndex: 'isAdmin',
                    key: 'isAdmin',
                    filters: [{
                        text: '管理员',
                        value: 'true',
                    }, {
                        text: '非管理员',
                        value: 'false',
                    }],
                    width: '15%',
                    onFilter: (value, record) => record.isAdmin + '' == value,
                    customRender: (text, record) => {
                        return (<Status value={record.isAdmin} text={record.isAdmin ? '' : ''} />)
                    }
                },
                {
                    title: '操作',
                    dataIndex: 'operation',
                    width: '20%',
                    customRender: (text, record, index) => {
                        const operation = (
                            <AMenu styles={{ display: 'inline-block' }} class='noPaddingMenu'>
                                <AMenu.Item key="edit">
                                </AMenu.Item>
                                <AMenu.Item key="changePwd" >
                                    <IiModal
                                        title="修改密码"
                                        content={<UserEditor ref={'password' + record.id} type="changePwd" data={{}} user={user} />}
                                        button={(<div style={{ padding: '2px 0px', fontiSize: '12px' }}>修改密码</div>)}
                                        ok={this.onChangePwd(record, index)}
                                        cancel={() => this.$refs['password' + record.id].resetFields()}
                                        clearFloat={true} />
                                </AMenu.Item>
                                <AMenu.Item key="delete">
                                    <IiModal
                                        title="删除"
                                        content={(<span>是否删除用户：{record.username}</span>)}
                                        button={(<div style={{ padding: '2px 0px', fontiSize: '12px' }}>删除</div>)}
                                        ok={this.onDelete(record)}
                                        clearFloat={true} />
                                </AMenu.Item>
                            </AMenu>
                        )
                        return (
                            <div class='operation'>
                                <IiModal
                                    title="编辑"
                                    content={(<UserEditor type="edit" ref={'edit' + record.id} data={{
                                        username: record.username, email: record.email, isAdmin: record.isAdmin, enable: record.subExt.enable
                                    }} user={user} />)}
                                    button={(<a>编辑</a>)}
                                    ok={this.onEdit(record, index)}
                                    cancel={() => this.$refs['edit' + record.id].resetFields()}
                                    clearFloat={true} />
                                <ADivider type="vertical" />
                                <ADropdown overlay={operation}>
                                    <a onClick={e => e.stopPropagation()}>
                                        更多<AIcon type="down" />
                                    </a>
                                </ADropdown>
                            </div>
                        )
                    },
                }]
            const { selectedRowKeys } = this
            const rowSelection = { selectedRowKeys, onChange: this.onSelectChange }
            const pageSizeOptions = ['20', '40', '60', '80']
            const hasSelected = selectedRowKeys.length > 0
            const batchOperation = (
                <AMenu styles={{ display: 'inline-block', margin: 20, padding: 5 }} onClick={this.batchOperate}>
                    <AMenu.Item key="enable" disabled={!hasSelected}> 激活</AMenu.Item>
                    <AMenu.Item key="disable" disabled={!hasSelected}> 禁用</AMenu.Item>
                </AMenu>
            )
            const users = this.users
            return (
                <a-card title="用户管理"
                    bordered={false}
                    bodyStyle={{ padding: "2px", flex: 1 }}
                    class='ii-card'>
                    <AButton style={{ marginRight: '8px' }} slot="extra" size='small' key="refresh" onClick={this.refetch}>
                        <AIcon type="reload" /> 刷新
                    </AButton>
                    <IiModal slot="extra"
                        key='new'
                        title="新建"
                        content={(<UserEditor type="create" ref={'_add'} data={{}} user={user} />)}
                        button={(<AButton size='small' icon={'plus'} key="new" style={{ marginRight: '8px' }}>创建用户</AButton>)}
                        ok={this.onAdd}
                        cancel={() => this.$refs._add.resetFields()}
                        clearFloat={true}
                    />
                    <ADropdown slot="extra"
                        key='more'
                        overlay={batchOperation}>
                        <AButton size='small' onClick={e => e.stopPropagation()}>
                            <AIcon type="appstore" /> 更多操作 <AIcon type="down" />
                        </AButton>
                    </ADropdown>
                    <IiTableLayout
                        size='small'
                        headheight={68}
                        total={this.total}
                        pageSize={this.limit}
                        currentPage={this.page}
                        showSizeChanger={true}
                        onShowSizeChange={this.onLimitChange}
                        onPaginationChange={this.onPageChange}
                        pageSizeOptions={pageSizeOptions}
                        // showPagination='both'
                        onRowClick={this.onRowClick}
                        className={'table'}
                        selected={selectedRowKeys.length}
                        showSizeChanger={false}
                        rowSelection={rowSelection}
                        columns={columns}
                        rows={users}>
                    </IiTableLayout>
                </a-card>
            )
        }
    },
    render() {
        return (
            <div style={{ height: '100%', width: '100%', overflow: 'hidden' }}>
                <ARow gutter={16} class={classNames('wrapper__row')}>
                    <ACol span={12} class={classNames('wrapper__row__col')}>
                        {this.renderUser()}
                    </ACol>
                    <ACol span={12} class={classNames('wrapper__row__col', 'wrapper__row__col_white')}>
                        {this.renderRelated()}
                    </ACol>
                </ARow>
            </div>
        )
    }
}
</script>

<style lang="stylus" scoped>
@import '../../../../../styles/imports';

.operation {
    display: flex;
    justify-content: left;
    align-items: center;

    a {
        color: $primary-color;
    }
}

.ii-card {
    height: 100%;
    width: 100%;
    overflow: hidden;
    background-color: white;
    display: flex;
    flex-direction: column;
}

.ii-tabs {
    height: 100%;
    display: flex;
    flex-direction: column;
    background-color: white;

    /deep/ .ant-tabs-content {
        padding-left: 0;
        height: 100%;
    }

    .tabpanel {
        height: 100%;
    }

    /deep/ .ant-tabs-bar {
        margin: 0;
    }
}

.table {
    :global(.ant-table-fixed-header .ant-table-scroll .ant-table-header) {
        height: 59px;
    }
}

.wrapper {
    &__row {
        height: 100% !important;

        &__col {
            height: 100% !important;

            &_white {
                background-color: white;
            }
        }
    }
}

.user_extends {
    margin: 10px;
    height: 100%;
    overflow-y: auto;
}
</style>