<script>
import TableLayout from './TableLayout'

export default {
    name: 'IiMultiAdd',
    props: ['fetchData', 'nameField', 'recordConvertor', 'columns', 'hidePagination'],
    data() {
        return {
            limit: 20,
            page: 1,
            total: 0,
            rowsOfCurrentPage: [],
            allSelectedRows: []
        }
    },
    computed: {
        selectedRowKeys() {
            const totalSelected = this.allSelectedRows
            // const selected = totalSelected.length
            const rowsOfCurrentPage = this.rowsOfCurrentPage
            const selectedRowKeys = []
            rowsOfCurrentPage.forEach((rowOfPage) => {
                if (totalSelected.some((selected) => {
                    return selected.id === rowOfPage.id
                })) {
                    selectedRowKeys.push(rowOfPage.id)
                    // this.selectedState[rowOfPage.id] = true
                }
                // else {
                // this.selectedState[rowOfPage.id] = false
                // }
            })
            return selectedRowKeys
        }
    },
    mounted() {
        this.innerFetchData()
    },
    methods: {
        onRemove(rm) {
            const allSelectedRows = this.allSelectedRows.filter((row) => {
                return !(row.id === rm.id)
            })
            this.allSelectedRows = allSelectedRows
        },
        onRemoveAll() {
            this.allSelectedRows = []
        },
        onSelectedRows(selectedRowKeys, selectedRows) {
            let rowsOfCurrentPage = this.rowsOfCurrentPage
            let notSelectedIds = []
            rowsOfCurrentPage.forEach((row) => {
                if (!selectedRowKeys.some((id) => {
                    return row.id === id
                })) {
                    notSelectedIds.push(row.id)
                }
            })
            let allSelectedRows = this.allSelectedRows
            //+选中的,-未选中的
            allSelectedRows = allSelectedRows.filter((row) => {
                return !notSelectedIds.some((id) => {
                    return row.id === id
                })
            })
            allSelectedRows = allSelectedRows.concat(selectedRows).filter((row, i, arr) => {
                return arr.findIndex((v) => {
                    return v.id === row.id
                }) === i
            })
            this.allSelectedRows = allSelectedRows
        },
        selectedRows() {
            return this.allSelectedRows
        },
        innerFetchData() {
            let limit = this.limit
            let page = this.page
            if (this.fetchData) {//提供了查询接口
                this.fetchData(limit, (page - 1) * limit)
                    .then((res) => {
                        this.rowsOfCurrentPage = res.data.rows;
                        this.total = res.data.total
                    }).catch(() => { })
            }
        },
        onPageChange(page) {
            this.page = page
            this.innerFetchData()
        },
        onLimitChange(current, pageSize) {
            this.limit = pageSize;
            this.page = 1
            this.innerFetchData()
        },
        renderSelectedList() {
            const selected = this.allSelectedRows
            const nameField = this.nameField ? this.nameField : ''
            return (<div class={'multiAdd__selected'}>
                <div class={'multiAdd__title'}>
                    <span class={'multiAdd__subTitle'}>{this.$t('iota.frame.components.tablelayout.selected', { count: selected.length })}</span>
                    <i class={'iota-icon iota-icon-clean multiAdd__clean'}
                        onClick={this.onRemoveAll} />
                </div>
                <div class={'multiAdd__selected__list'}>
                    {selected.map((row) => {
                        return (
                            <ATag key={row.id}
                                class={'multiAdd__selected__list__tag'}
                                closable
                                afterClose={() => this.onRemove(row)}>{row[nameField]}</ATag>
                        )
                    })}
                </div>
            </div>
            )
        }
    },
    render() {
        let rowsOfCurrentPage = this.rowsOfCurrentPage || []
        let dataSource = []
        const recordConvertor = this.recordConvertor ? this.recordConvertor : (r) => Object.assign({ key: r.id }, r)
        if (Array.isArray(rowsOfCurrentPage)) {
            rowsOfCurrentPage.forEach((row) => {
                dataSource.push(recordConvertor(row))
            })
        }
        const pageSizeOptions = ['20', '40', '60', '80']
        const controls = []
        const rowSelection = { selectedRowKeys: this.selectedRowKeys, onChange: this.onSelectedRows }
        return (
            <div class={'multiAdd'}>
                <ACol span="6">
                    {this.renderSelectedList()}
                </ACol>
                <ACol span="18">
                    <div class={'multiAdd__title'}>
                        列表
                    </div>
                    <TableLayout
                        class={'multiAdd__table'}
                        size='small'
                        showPagination={this.hidePagination ? 'none' : 'top'}
                        onPaginationChange={this.onPageChange}
                        total={this.total}
                        pageSize={this.limit}
                        currentPage={this.page}
                        showSizeChanger={true}
                        onShowSizeChange={this.onLimitChange}
                        pageSizeOptions={pageSizeOptions}
                        controls={controls}
                        rowSelection={rowSelection}
                        columns={this.columns}
                        rows={dataSource}>
                    </TableLayout>
                </ACol>
            </div >
        )
    }
}
</script>

<style lang="stylus" scoped>
.multiAdd {
    height: 448px !important;

    &__table {
        height: 400px !important;
    }

    &__title {
        font-size: 16px;
        margin: 10px 10px 10px 10px;
        border-bottom: 1px solid #e5e5e5;
        line-height: 30px;
    }

    &__subTitle {
        font-size: 12px;
        margin-left: 30px;
    }

    &__clean {
        float: right;
        margin-right: 10px;
        line-height: 30px;
        color: #bcbcbc;
        cursor: pointer;

        &:hover {
            color: #909090;
        }
    }

    &__selected {
        border-right: 1px solid #e5e5e5;
        height: 448px;
        overflow: hidden;
        margin-left: 10px;

        &__list {
            height: calc(100% - 54px);
            margin: 10px 10px 10px 10px;
            overflow-y: auto;

            &__tag {
                margin-top: 10px;
                font-size: 12px;
            }
        }
    }
}
</style>