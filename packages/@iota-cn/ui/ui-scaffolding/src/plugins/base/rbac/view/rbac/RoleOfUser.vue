
<script>
import { message } from 'ant-design-vue/es'
import { Menu as AMenu } from 'ant-design-vue'
import moment from 'moment'
import uuid from 'uuid'

export default {
    props: ['user'],
    data() {
        return {
            roles: [],
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
            this.pageSize = pageSize
            this.page = 1
            this.refetch()
        },

        refetch() {
            const { user, limit, page } = this
            if (user) {
                this.$axios.silentGet(`/v1/api/authorizations/users/${user.id}/roles?limit=${limit}&offset=${(page - 1) * limit}`, true)
                    .then(res => {
                        this.roles = res.data.roles
                        this.total = res.data.total
                        this.selectedRowKeys = []
                        this.selectedRows = []
                    }).catch(() => { })
            }
        },

        onSelectChange(selectedRowKeys, selectedRows) {
            this.selectedRowKeys = selectedRowKeys
            this.selectedRows = selectedRows
        },

        onRowClick(record, index) {
            let { selectedRowKeys, selectedRows } = this
            if (selectedRowKeys.indexOf(index) === -1) {
                selectedRowKeys.push(index)
                selectedRows.push(record)
            } else {
                selectedRowKeys = selectedRowKeys.filter(i => i !== index)
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
            let user = this.user
            let url = `/v1/api/authorizations/users/${user.id}/roles?ids=${ids.join(',')}`
            return this.$axios.silentDelete(url, true)
                .then(() => {
                    this.refetch()
                    return true
                })
                .catch(() => {
                    return true
                })
        },

        onAdd() {
            let newSubUsers = this.$refs._addRelated.selectedRows()
            if (newSubUsers.length <= 0) {
                return true
            }
            let user = this.user
            let url = `/v1/api/authorizations/users/${user.id}/roles`
            return this.$axios.silentPost(url, { ids: newSubUsers.map(r => r.id) }, true).then(() => {
                this.modalKey = uuid.v4()
                this.refetch()
                return true
            }).catch(() => {
                message.error("关联用户角色失败。")
                return false
            })
        },

        findUserNotBindToRole(limit, offset) {
            let user = this.user
            let url = `/v1/api/authorizations/users/${user.id}/not_assigned/roles?limit=${limit}&offset=${offset}`
            return this.$axios.silentGet(url, true)
                .then((res) => {
                    return Promise.resolve({
                        status: res.status,
                        data: {
                            rows: res.data.roles,
                            total: res.data.total
                        }
                    })
                }).catch(() => { })
        },

        onCancel() {
            this.modalKey = uuid.v4()
        },
    },

    render() {
        const columns = [
            {
                title: '角色',
                dataIndex: 'name',
                key: 'name',
                width: '15%',
            },
            {
                title: '描述',
                dataIndex: 'desc',
                key: 'desc',
                width: '45%',
            },
            {
                title: '关联时间',
                dataIndex: 'userRole.createdAt',
                key: 'userRole.createdAt',
                width: '25%',
                customRender: (text, record) => {
                    return record.userRole && record.userRole.createdAt ? moment(record.userRole.createdAt).format('YYYY-MM-DD HH:mm:ss') : ''
                }
            },
            {
                title: '操作',
                dataIndex: 'operation',
                key: 'operation',
                width: '15%',
                customRender: (text, record) => {
                    const operation = (
                        <AMenu styles={{ display: 'inline-block' }} className='noPaddingAMenu'>
                            <AMenu.Item key="delete">
                                <IiModal
                                    title="删除关联"
                                    content={(<span>是否删除关联角色：{record.name}</span>)}
                                    button={(<div style={{ padding: '2px 0px', fontiSize: '12px' }}><AIcon type="delete" /> 删除关联</div>)}
                                    ok={this.onDelete(record)}
                                    clearFloat={true}
                                />
                            </AMenu.Item>
                        </AMenu>
                    )
                    return (
                        <ADropdown overlay={operation}>
                            <AButton size='small' onClick={e => e.stopPropagation()}>
                                <AIcon type="appstore" /> 操作 <AIcon type="down" />
                            </AButton>
                        </ADropdown>
                    )
                },
            }]
        const columnsAdd = [
            {
                title: '角色',
                dataIndex: 'name',
                key: 'name',
                width: '25%',
            },
            {
                title: '描述',
                dataIndex: 'desc',
                key: 'desc',
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
        const addRelated = (
            <IiMultiAdd
                ref={'_addRelated'}
                fetchData={this.findUserNotBindToRole}
                nameField='name'
                columns={columnsAdd}
                // hidePagination={true}
                recordConvertor={row => {
                    return {
                        key: row.id,
                        id: row.id,
                        name: row.name,
                        desc: row.desc,
                        createdAt: moment(row.createdAt).format('YYYY-MM-DD HH:mm:ss')
                    }
                }} />
        )
        const { selectedRowKeys } = this
        const rowSelection = { selectedRowKeys, onChange: this.onSelectChange }
        const pageSizeOptions = ['20', '40', '60', '80']
        const hasSelected = selectedRowKeys.length > 0
        const controls = [
            <AButton size='small' key="refresh" onClick={this.refetch}>
                <AIcon type="reload" /> 刷新
            </AButton>,
            <IiModal key={this.modalKey}
                width={1150}
                title="添加关联角色"
                content={(addRelated)}
                button={(<AButton size='small' icon='plus' key="new">添加关联角色</AButton>)}
                ok={this.onAdd}
                clearFloat={true}
                cancel={this.onCancel}
            />,
            hasSelected ?
                <APopconfirm placement="top" key="bactchDelete"
                    title={'是否确定删除选中的关联角色'}
                    onConfirm={this.onBatchDelete} disabled={!hasSelected}>
                    <AButton size='small'>
                        <AIcon type="delete" />删除关联
                    </AButton>
                </APopconfirm>
                :
                <AButton size='small' disabled>
                    <AIcon type="delete" />删除关联
                </AButton>
        ]
        const roles = this.roles
        return (
            <IiTableLayout
                size='middle'
                headheight={68}
                onPaginationChange={this.onPageChange}
                total={this.total}
                pageSize={this.limit}
                currentPage={this.page}
                showSizeChanger={true}
                onShowSizeChange={this.onLimitChange}
                pageSizeOptions={pageSizeOptions}
                onRowClick={this.onRowClick}
                className={'wrapper__row__col__tabs__table'}
                showPagination='both'
                selected={selectedRowKeys.length}
                showSizeChanger={false}
                controls={controls}
                rowSelection={rowSelection}
                columns={columns}
                rows={roles} >
            </IiTableLayout>
        )
    }
}
</script>

<style>
</style>