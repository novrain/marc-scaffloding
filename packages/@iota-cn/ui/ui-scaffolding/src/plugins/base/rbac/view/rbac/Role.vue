<script>
import { message } from 'ant-design-vue/es'
import merge from 'deepmerge'
import moment from 'moment'
import classNames from 'classnames'
import { AuthCheckStrictlyTree } from '../../components'
import UserOfRole from './UserOfRole'

export default {
    props: [],
    data() {
        return {
            roles: [],
            selectedRowKeys: [],
            selectedRows: [],
            limit: 20,
            page: 1,
            total: 0,
            multiSelect: false
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

        findRole(id) {
            return this.roles.find(r => {
                return r.id === id
            })
        },

        refetch() {
            // fetch(`${this.apiServer}/authorizations/roles?limit=${limit}&offset=${(page - 1) * limit}`, {
            this.$axios.silentGet('/v1/api/authorizations/roles', true)
                .then((res) => {
                    this.roles = res.data.roles
                    this.total = res.data.total
                    this.selectedRowKeys = []
                    this.selectedRows = []
                }).catch(() => { })
        },

        renderOrganizations() {
            const { selectedRowKeys } = this
            let child = null
            if (selectedRowKeys.length === 1) {
                const role = this.findRole(this.selectedRowKeys[0])
                child = <AuthCheckStrictlyTree target={role} checkStrictly disableUserAssigned
                    sourceUrlKey='organizations' targetUrlKey='roles' resultKey='organizations' />
            }
            return (<ATabPane tab="组织" key="organizations" class='tabpanel'>
                {child}
            </ATabPane>)
        },

        renderPositions() {
            const { selectedRowKeys } = this
            let child = null
            if (selectedRowKeys.length === 1) {
                const role = this.findRole(this.selectedRowKeys[0])
                child = <AuthCheckStrictlyTree target={role} checkStrictly disableUserAssigned
                    sourceUrlKey='positions' targetUrlKey='roles' resultKey='positions' />
            }
            return (<ATabPane tab="职位" key="positions" class='tabpanel'>
                {child}
            </ATabPane>)
        },

        renderUsers() {
            const { selectedRowKeys } = this
            let child = null
            if (selectedRowKeys.length === 1) {
                // const role = this.findRole(this.selectedRowKeys[0])
                child = <UserOfRole role={this.selectedRowKeys[0]} />
            }
            return (<ATabPane tab="用户" key="users" class='tabpanel'>
                {child}
            </ATabPane>)
        },

        renderMenusAndOperations() {
            const { selectedRowKeys } = this
            let role = null
            if (selectedRowKeys.length === 1) {
                role = this.findRole(this.selectedRowKeys[0])
            }
            return (<ATabPane tab="权限" key="menusandoperations" class='tabpanel'>
                <ARow gutter={16} class={classNames('wrapper__row')}>
                    <ACol span={12} class={classNames('wrapper__row__col')}>
                        <AuthCheckStrictlyTree target={role} sourceUrlKey='menus' targetUrlKey='roles' resultKey='menus' />
                    </ACol>
                    <ACol span={12} class={classNames('wrapper__row__col')}>
                        <AuthCheckStrictlyTree target={role} sourceUrlKey='operations' targetUrlKey='roles' resultKey='operations' />
                    </ACol>
                </ARow>
            </ATabPane>)
        },

        renderRelated() {
            return <ATabs type="card" class='ii-tabs'>
                {this.renderMenusAndOperations()}
                {this.renderOrganizations()}
                {this.renderPositions()}
                {this.renderUsers()}
            </ATabs>
        },

        onSelectChange(selectedRowKeys, selectedRows) {
            this.selectedRowKeys = selectedRowKeys
            this.selectedRows = selectedRows
        },

        onMultiSelectChange(e) {
            if (!e.target.checked && this.selectedRowKeys.length > 1) {
                this.selectedRowKeys = [this.selectedRowKeys[0]]
                this.selectedRows = [this.selectedRows[0]]
            }
        },

        onRowClick(record) {
            let { selectedRowKeys, selectedRows } = this
            if (!this.multiSelect) {
                selectedRowKeys = [record.id]
                selectedRows = [record]
            } else {
                if (selectedRowKeys.indexOf(record.id) === -1) {
                    selectedRowKeys.push(record.id)
                    selectedRows.push(record)
                } else {
                    selectedRowKeys = selectedRowKeys.filter(i => i !== record.id)
                    selectedRows = selectedRows.filter(i => i.id !== record.id)
                }
            }
            this.selectedRowKeys = selectedRowKeys
            this.selectedRows = selectedRows
        },

        rowClassName(record) {
            if (this.selected) {
                if (this.selected.path === record.path) {
                    return 'browser__tree__table__item_seleted'
                }
            }
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
            let url = `/v1/api/authorizations/roles?ids=${ids.join(',')}`
            this.$axios.silentDelete(url, true)
                .then(() => {
                    this.refetch()
                    return true
                })
                .catch(() => {
                    return true
                })
        },

        onEdit(record, index) {
            return () => {
                return new Promise((resolve, reject) => {
                    this.$refs._editor.validateFieldsAndScroll((err, values) => {
                        if (!err) {
                            resolve(true)
                            let role = values
                            this.$axios.commonPut(`/v1/api/authorizations/roles/${record.id}`, role, {
                                success: '修改成功',
                                error: '修改失败，没有权限或其他原因。'
                            })
                                .then(() => {
                                    this.$refs._editor.resetFields()
                                    this.$set(this.roles, index, merge(this.roles[index], role))
                                })
                                .catch(() => {
                                    message.error('编辑失败，没有权限或其他原因。')
                                })
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
                        resolve(true)
                        this.$axios.silentPost(`/v1/api/authorizations/roles`, values, true).then(() => {
                            this.$refs._add.resetFields()
                            this.refetch()
                        }).catch(() => { })
                    }
                    else {
                        reject(false)
                    }
                }
                )
            })
        },

        renderRole() {
            const columns = [
                {
                    title: '名称',
                    dataIndex: 'name',
                    key: 'name',
                },
                {
                    title: '描述',
                    dataIndex: 'desc',
                    key: 'desc',
                    width: '30%',
                },
                {
                    title: '创建时间',
                    dataIndex: 'createdAt',
                    key: 'createdAt',
                    width: '30%',
                    customRender: (text, record) => {
                        return record.createdAt ? moment(record.createdAt).format('YYYY-MM-DD HH:mm:ss') : ''
                    }
                },
                {
                    title: '操作',
                    dataIndex: 'operation',
                    key: 'operation',
                    width: '20%',
                    customRender: (text, record, index) => {
                        return (
                            <div class='operation'>
                                <IiModal
                                    title="编辑"
                                    content={(<Form_IiSimpleEditor ref={'_editor'} data={{ name: record.name, desc: record.desc }} />)}
                                    button={(<a>编辑</a>)}
                                    cancle={() => { this.$refs._editor.resetFields() }}
                                    ok={this.onEdit(record, index)}
                                    clearFloat={true}
                                />
                                <ADivider type="vertical" />
                                <IiModal
                                    title="删除"
                                    content={(<span>是否删除角色：{record.name}</span>)}
                                    button={(<a>删除</a>)}
                                    ok={this.onDelete(record)}
                                    clearFloat={true} />
                            </div>
                        )
                    },
                }]
            const { selectedRowKeys } = this
            const rowSelection = { type: this.multiSelect ? 'checkbox' : 'radio', selectedRowKeys, onChange: this.onSelectChange }
            const pageSizeOptions = ['20', '40', '60', '80']
            const hasSelected = selectedRowKeys.length > 0
            const roles = this.roles
            return (
                <a-card title="角色管理"
                    bordered={false}
                    bodyStyle={{ padding: "2px", flex: 1 }}
                    class='ii-card'>
                    <a-checkbox v-model={this.multiSelect} slot='extra' onChange={this.onMultiSelectChange}>多选</a-checkbox>
                    <AButton style={{ marginRight: '8px' }} slot='extra' size='small' key="refresh" onClick={this.refetch}>
                        <AIcon type="reload" /> 刷新
                    </AButton>
                    <IiModal slot='extra'
                        key='new'
                        title="新建"
                        content={(<Form_IiSimpleEditor ref='_add' data={{}} />)}
                        button={(<AButton size='small' icon={'plus'} key="new" style={{ marginRight: '8px' }}> 创建角色</AButton>)}
                        cancel={() => { this.$refs._add.resetFields() }}
                        ok={this.onAdd}
                        clearFloat={true}
                    />
                    {hasSelected ?
                        <APopconfirm slot='extra' placement="top"
                            key="bactchDelete"
                            title={'是否确定删除选中的角色'}
                            onConfirm={this.onBatchDelete}>
                            <AButton size='small' >
                                <AIcon type="delete" />删除
                        </AButton>
                        </APopconfirm>
                        :
                        <AButton slot='extra' size='small' disabled >
                            <AIcon type="delete" />删除
                    </AButton>}
                    <IiTableLayout
                        size='small'
                        headheight={68}
                        onRowClick={this.onRowClick}
                        class={'table'}
                        total={this.total}
                        pageSize={this.limit}
                        currentPage={this.page}
                        showSizeChanger={true}
                        onPaginationChange={this.onPageChange}
                        onShowSizeChange={this.onLimitChange}
                        pageSizeOptions={pageSizeOptions}
                        // showPagination='none'
                        selected={selectedRowKeys.length}
                        showSizeChanger={false}
                        rowSelection={rowSelection}
                        columns={columns}
                        rows={roles}>
                    </IiTableLayout>
                </a-card>
            )
        }
    },

    render() {
        return (
            <div style={{ height: '100%', width: '100%', overflow: 'hidden' }}>
                <ARow gutter={16} class={classNames('wrapper__row')}>
                    <ACol span={10} class={classNames('wrapper__row__col')}>
                        {this.renderRole()}
                    </ACol>
                    <ACol span={14} class={classNames('wrapper__row__col', 'wrapper__row__col_white')}>
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
</style>