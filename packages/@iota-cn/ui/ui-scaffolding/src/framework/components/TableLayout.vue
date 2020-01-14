<script>

const TABLE_DEFAULT_HEAD_HEIGHT = 68
const TABLE_MIDDLE_HEAD_HEIGHT = 58
const TABLE_SMALL_HEAD_HEIGHT = 48
const TABLE_CONTROLS_HEIGHT = 20
// const TABLE_CONTROL_HEIGHT = 40;
export default {
    name: 'IiTableLayout',
    // 待限制类型
    props: [
        'showPagination',
        'onPaginationChange',
        'total',
        'pageSize',
        'currentPage',
        'showSizeChanger',
        'onShowSizeChange',
        'pageSizeOptions',
        //control
        'controls',
        'selected',
        'rowSelection',
        'rowClassName',
        'rows',
        'columns',
        'size',
        'rowKey',
        'component'
    ],
    data() {
        return {
            tabScroll: { y: 200 }
        }
    },
    mounted() {
        // window.addEventListener('resize', this.onResize)
        if (this.$refs._tableContainer) {
            this.tabScroll = { y: this.$refs._tableContainer.clientHeight }
        }
    },
    updated() {
        if (this.$refs._tableContainer) {
            if (this.tabScroll.y !== this.$refs._tableContainer.clientHeight) {
                this.tabScroll = { y: this.$refs._tableContainer.clientHeight }
            }
        }
    },
    destroyed() {
        // window.removeEventListener('resize', this.onResize)
    },
    methods: {
        onResize() {
            this.change = true;
            this.tabScroll = { y: this.$refs._tableContainer.clientHeight + 20 }
        },
        onEvent(event) {
            let that = this
            return function () {
                that.$emit(event, ...arguments)
            }
        }
    },
    render() {
        const showBottomPagination = this.showPagination === 'bottom' || this.showPagination === 'both';
        const showTopPagination = this.showPagination === 'top' || this.showPagination === 'both';
        let headHeight = this.headheight || TABLE_CONTROLS_HEIGHT;
        let bottomHeight = this.bottomHeight || TABLE_CONTROLS_HEIGHT;
        let space = TABLE_DEFAULT_HEAD_HEIGHT
        switch (this.size) {
            case 'small':
                space = TABLE_SMALL_HEAD_HEIGHT
                break
            case 'middle':
                space = TABLE_MIDDLE_HEAD_HEIGHT
                break
        }
        space += showTopPagination ? headHeight : 0
        space += showBottomPagination ? bottomHeight : 0
        const size = this.size || 'middle'
        const pagination = showBottomPagination || showTopPagination ? (
            <APagination onChange={this.onEvent('paginationChange')}
                defaultCurrent={this.currentPage}
                current={this.currentPage}
                total={this.total}
                size={size}
                showSizeChanger={this.showSizeChanger}
                pageSize={this.pageSize}
                onShowSizeChange={this.onEvent('showSizeChange')}
                pageSizeOptions={this.pageSizeOptions}
                showTotal={total => this.$t('iota.frame.components.tablelayout.total', { total })} />
        ) : null;
        let rowSelection = this.rowSelection
        if (rowSelection && rowSelection.type === 'radio') {
            rowSelection = Object.assign({
                onSelect: (row) => {
                    this.onEvent('rowClick')(row)
                }
            }, rowSelection
            )
        }
        return (
            <div class='layout'>
                {
                    this.controls || showTopPagination ? <div class={'layout__controls'}>
                        {this.controls}
                        <span
                            class='layout__controls__item layout__controls__selected'>
                            {this.selected ? this.$t('iota.frame.components.tablelayout.selected', { count: this.selected }) : ''}
                        </span>
                        <span class={'layout__controls__pagination'}>
                            {showTopPagination ? pagination : null}
                        </span>
                    </div> : null
                }
                {
                    this.chart ?
                        <div class={'layout__chart'}>
                            {this.chart}
                        </div> :
                        null
                }
                <div class={'layout__table'} ref='_tableContainer'>
                    <resize-observer onNotify={this.onResize} />
                    {
                        this.component === 'el-table' ?
                            <el-table data={this.rows}
                                border={this.bordered}
                                rowKey={this.rowKey || 'id'}
                                maxHeight={this.tabScroll.y}
                                highlightCurrentRow={this.rowSelection && this.rowSelection.type === 'radio'}
                                on={{
                                    'row-click': (row, column) => {
                                        this.onEvent('rowClick')(row, column.index)
                                    },
                                    'current-change': (currentRow) => {
                                        if (this.rowSelection && typeof this.rowSelection.onChange === 'function') {
                                            this.rowSelection.onChange([currentRow[this.rowKey || 'id']], [currentRow])
                                        }
                                    },
                                    'selection-change': (selection) => {
                                        if (this.rowSelection && typeof this.rowSelection.onChange === 'function') {
                                            this.rowSelection.onChange(selection.map(s => s[this.rowKey || 'id']), selection)
                                        }
                                    }
                                }}
                                size={size}>
                                {
                                    this.rowSelection && this.rowSelection.type === 'checkbox' ?
                                        <el-table-column
                                            key='checkbox'
                                            type="selection"
                                            width="55">
                                        </el-table-column>
                                        : null
                                }
                                {this.columns.map(c => {
                                    return <el-table-column
                                        prop={c.dataIndex}
                                        columnKey={c.key}
                                        label={c.title}
                                        filters={c.filters}
                                        filterMethod={c.onFilter}
                                        formatter={(row, column, cellValue, index) => {
                                            return c.customRender ? c.customRender(cellValue, row, index) : cellValue
                                        }} />
                                })}
                            </el-table>
                            :
                            <ATable rowSelection={rowSelection}
                                rowKey={this.rowKey || 'id'}
                                columns={this.columns}
                                scroll={{ y: this.tabScroll.y - space, x: true }}
                                dataSource={this.rows}
                                expandedRowRender={this.expandedRowRender}
                                onExpand={this.onEvent('expand')}
                                // onRow={this.onRow}
                                title={typeof this.title === 'function' ? this.title : (this.title ? () => this.title : undefined)}
                                rowClassName={this.rowClassName}
                                customRow={(row, index) => {
                                    return {
                                        on: {
                                            click: () => {
                                                this.onEvent('rowClick')(row, index)
                                            }
                                        }
                                    }
                                }}
                                onRowDoubleClick={this.onEvent('rowDoubleClick')}
                                onRowContextMenu={this.onEvent('rowContextMenu')}
                                bordered={this.bordered}
                                rowKey={this.rowKey || 'id'}
                                size={size}
                                pagination={false} />
                    }
                    {
                        showBottomPagination ? <div class='layout__controls layout__controls__bottom'>
                            <span class={'layout__controls__pagination'}>
                                {pagination}
                            </span>
                        </div> : null
                    }
                </div>
            </div>)
    }
}
</script>

<style lang="stylus" scoped>
.layout {
    background-color: white;
    padding: 10px;
    display: flex;
    flex-direction: column;
    height: 100%;
    width: 100%;

    &__controls {
        margin-top: 0;
        margin-bottom: 0px;
        height: 30px;
        display: flex;
        justify-content: flex-start;

        &__item {
            margin-left: 0px;
            font-size: 12px;
        }

        &__pagination {
            display: inline-block;
            position: absolute;
            right: 12px;
        }

        &__top {
            margin-bottom: 10px;
        }

        &__bottom {
            margin-top: 10px;
        }

        button {
            margin-right: 10px;

            &:last-child {
                margin-right: 0;
            }
        }
    }

    &__chart {
        min-height: 300px;
    }

    &__table {
        // margin-bottom: 10px;
        flex: 1;
        overflow: hidden;

        /deep/ .ant-table td {
            white-space: nowrap;
        }

        /deep/ .ant-table th {
            word-break: keep-all;
            white-space: nowrap;
        }
    }
}
</style>