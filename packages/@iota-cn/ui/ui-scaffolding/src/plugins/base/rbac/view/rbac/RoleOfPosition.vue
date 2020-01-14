<script>
import { message } from 'ant-design-vue/es'
import moment from 'moment'
import uuid from 'uuid'

export default {
    props: ['position'],
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
            this.limit = pageSize
            this.page = 1
            this.refetch()
        },

        refetch() {
            const limit = this.limit
            const page = this.page
            const { position } = this
            if (position) {
                this.$axios.silentGet(`/v1/api/authorizations/positions/${position}/roles?limit=${limit}&offset=${(page - 1) * limit}`, true)
                    .then((res) => {
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
            let { position } = this
            let url = `/v1/api/authorizations/positions/${position}/roles?ids=${ids.join(',')}`
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
            let newRoles = this.$refs._addRelated.selectedRows()
            if (newRoles.length <= 0) {
                return true
            }
            let position = this.position
            let url = `/v1/api/authorizations/positions/${position}/roles`
            return this.$axios.silentPost(url, { ids: newRoles.map(r => r.id) }, true)
                .then(() => {
                    this.modalKey = uuid.v4()
                    this.refetch()
                    return true
                }).catch(() => {
                    message.error("关联职位角色失败。")
                    return false
                })
        },

        findPositionNotBindToRole(limit, offset) {
            let position = this.position
            let url = `/v1/api/authorizations/positions/${position}/not_assigned/roles?limit=${limit}&offset=${offset}`
            return this.$axios.silentGet(url, true)
                .then((res) => {
                    return {
                        status: res.status,
                        data: {
                            rows: res.data.roles,
                            total: res.data.total
                        }
                    }
                }).catch(() => { })
        },

        onCancel() {
            this.modalKey = uuid.v4()
        }
    },

    render() {
        let canDelete = this.$p('/authorizations/positions/:positionId/roles/:id?:DELETE')
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
                dataIndex: 'positionRole.createdAt',
                key: 'positionRole.createdAt',
                width: '25%',
                customRender: (text, record) => {
                    return record.positionRole && record.positionRole.createdAt ? moment(record.positionRole.createdAt).format('YYYY-MM-DD HH:mm:ss') : ''
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
                                        content={(<span>是否删除关联角色：{record.name}</span>)}
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
                fetchData={this.findPositionNotBindToRole}
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
            this.$p('/authorizations/positions/:positionId/roles:GET') ?
                <AButton size='small' key="refresh" onClick={this.refetch}>
                    <AIcon type="reload" /> 刷新
                </AButton>
                : null,
            this.$p('/authorizations/positions/:positionId/roles:POST') ?
                <IiModal key={this.modalKey}
                    width={1150}
                    title="添加关联角色"
                    content={(addRelated)}
                    button={(<AButton size='small' icon={'plus'} key="new" style={{ marginRight: '8px' }}  >添加关联角色</AButton>)}
                    ok={this.onAdd}
                    clearFloat={true}
                    cancel={this.onCancel} />
                : null,
            this.$p('/authorizations/positions/:positionId/roles/:id?:DELETE') ?
                (hasSelected ?
                    <APopconfirm placement="top" key="bactchDelete"
                        title={'是否确定删除选中的关联角色'}
                        onConfirm={this.onBatchDelete}>
                        <AButton size='small' >
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
        const roles = this.roles
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
                showSizeChanger={true}
                controls={controls}
                rowSelection={rowSelection}
                columns={columns}
                rows={roles}>
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