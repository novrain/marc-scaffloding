<script>
import { message } from 'ant-design-vue/es'
import moment from 'moment'
import uuid from 'uuid'

export default {
    props: ['role'],
    data() {
        return {
            users: [],
            selectedRowKeys: [],
            selectedRows: [],
            limit: 20,
            page: 1,
            total: 0,
            modalKey: uuid.v4()
        }
    },

    mounted() {
        this.refetch()
    },

    methods: {
        onPageChange(page) {
            this.page = page
            this.refetch()
        },

        onLimitChange(current, pageSize) {
            this.limit = pageSize
            this.page = 1
            this.refetch()
        },

        refetch() {
            const limit = this.limit
            const page = this.page
            const { role } = this
            if (role) {
                this.$axios.silentGet(`/v1/api/authorizations/roles/${role}/users?limit=${limit}&offset=${(page - 1) * limit}`, true)
                    .then((res) => {
                        this.users = res.data.users
                        this.total = res.data.total
                        this.selectedRowKeys = []
                        this.selectedRows = []
                        this.newSubUsers = []
                    }).catch(() => { })
            }
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
        },

        onBatchDelete() {
            let { selectedRowKeys, selectedRows } = this
            this.batchDelete(selectedRowKeys, selectedRows)
            return true
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
            const role = this.role
            let url = `/v1/api/authorizations/roles/${role}/users?ids=${ids.join(',')}`
            return this.$axios.silentDelete(url, true)
                .then(() => {
                    this.refetch()
                    return true
                })
                .catch(() => {
                    return true
                })
        },

        findUserNotBindToRole(limit, offset) {
            let role = this.role
            let url = `/v1/api/authorizations/roles/${role}/not_bind/users?limit=${limit}&offset=${offset}`
            return this.$axios.silentGet(url, true)
                .then(async function (res) {
                    return {
                        status: res.status,
                        data: {
                            rows: res.data.users,
                            total: res.data.total
                        }
                    }
                }).catch((err) => { throw err })
        },

        onCancel() {
            this.modalKey = uuid.v4()
        },

        onAdd() {
            let newSubUsers = this.$refs._addRelated.selectedRows()
            if (newSubUsers.length <= 0) {
                return true
            }
            let role = this.role
            let url = `/v1/api/authorizations/roles/${role}/users`
            return this.$axios.silentPost(url, { ids: newSubUsers.map(r => r.id) }, true)
                .then(() => {
                    this.modalKey = uuid.v4()
                    this.refetch()
                    return true
                }).catch(() => {
                    message.error("关联用户角色失败。")
                    return false
                })
        }
    },

    render() {
        let canDelete = this.$p('/authorizations/roles/:roleId/users/:id?:DELETE')
        const columns = [
            {
                title: '用户名',
                dataIndex: 'username',
                key: 'username',
                width: '15%',
            },
            {
                title: '用户名',
                dataIndex: 'fullname',
                key: 'fullname'
            },
            {
                title: '邮箱',
                dataIndex: 'email',
                key: 'email',
                width: '25%',
            },
            {
                title: '关联时间',
                dataIndex: 'userRole.createdAt',
                key: 'userRole.createdAt',
                width: '25%',
                customRender: (text, record) => {
                    return record.createdAt ? moment(record.createdAt).format('YYYY-MM-DD HH:mm:ss') : ''
                }
            },
            {
                title: '操作',
                dataIndex: 'operation',
                key: 'operation',
                width: '15%',
                customRender: (text, record) => {
                    return (
                        <div class='operation'>
                            {
                                canDelete ?
                                    <IiModal
                                        title="删除关联"
                                        content={(<span>是否删除关联用户：{record.username}</span>)}
                                        button={(<a> 删除关联</a>)}
                                        ok={this.onDelete(record)}
                                        clearFloat={true} />
                                    : null
                            }
                        </div>
                    )
                },
            }]
        const columnsAdd = [
            {
                title: '登录名',
                dataIndex: 'username',
                key: 'username',
                width: '25%',
            },
            {
                title: '用户名',
                dataIndex: 'fullname',
                key: 'fullname',
                width: '45%',
            },
            {
                title: '创建时间',
                dataIndex: 'createdAt',
                key: 'createdAt',
                width: '30%',
                customRender: (text, record) => {
                    return record.createdAt ? moment(record.createdAt).format('YYYY-MM-DD HH:mm:ss') : ''
                }
            }]
        const { selectedRowKeys } = this
        const rowSelection = { selectedRowKeys, onChange: this.onSelectChange }
        const pageSizeOptions = ['20', '40', '60', '80']
        const hasSelected = selectedRowKeys.length > 0
        const addRelated = (
            <IiMultiAdd
                ref={'_addRelated'}
                fetchData={this.findUserNotBindToRole}
                nameField='username'
                columns={columnsAdd}
                // hidePagination={true}
                recordConvertor={row => {
                    return {
                        key: row.id,
                        id: row.id,
                        username: row.username,
                        email: row.email,
                        fullname: row.userExt ? row.userExt.fullname : '',
                        mobile: row.mobile,
                        enable: row.subExt ? row.subExt.enable : true,
                        createdAt: moment(row.createdAt).format('YYYY-MM-DD HH:mm:ss')
                    }
                }} />
        )
        const controls = [
            this.$p('/authorizations/roles/:roleId/users:GET') ?
                <AButton size='small' key="refresh" onClick={this.refetch}>
                    <AIcon type="reload" /> 刷新
                </AButton>
                : null,
            this.$p('/authorizations/roles/:roleId/users:POST') ?
                <IiModal
                    key={this.modalKey}
                    width={1150}
                    title="添加关联用户"
                    content={(addRelated)}
                    button={(<AButton size='small' icon={'plus'} key="new" style={{ marginRight: '8px' }} >添加关联用户</AButton>)}
                    ok={this.onAdd}
                    cancel={this.onCancel}
                    clearFloat={true} />
                : null,
            this.$p('/authorizations/roles/:roleId/users/:id?:DELETE') ?
                (hasSelected ?
                    <APopconfirm placement="top" key="bactchDelete"
                        title={'是否确定删除选中的关联用户'}
                        onConfirm={this.onBatchDelete}>
                        <AButton size='small'>
                            <AIcon type="delete" />删除关联
                        </AButton>
                    </APopconfirm>
                    :
                    <AButton size='small' disabled>
                        <AIcon type="delete" />删除关联
                    </AButton>
                )
                : null
        ]
        const users = this.users
        return (
            <IiTableLayout
                size='small'
                headheight={68}
                onPaginationChange={this.onPageChange}
                total={this.total}
                pageSize={this.limit}
                currentPage={this.page}
                showSizeChanger={true}
                onShowSizeChange={this.onLimitChange}
                pageSizeOptions={pageSizeOptions}
                onRowClick={this.onRowClick}
                class={'table'}
                showPagination='both'
                selected={selectedRowKeys.length}
                showSizeChanger={false}
                controls={controls}
                rowSelection={rowSelection}
                columns={columns}
                rows={users}>
            </IiTableLayout>
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

.table {
}
</style>