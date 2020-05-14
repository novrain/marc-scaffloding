<script>
export default {
    name: 'IiPaginationSelect',
    props: {
        showPagination: {
            type: String,
            validator: function (value) {
                return ['top', 'bottom', 'both', 'none'].indexOf(value) !== -1
            },
            default: 'bottom'
        },
        pageSizeOptions: {
            type: Array,
            default: function () {
                return ['20', '40', '60', '80']
            }
        },
        size: {
            type: String,
            validator: function (value) {
                return ['default', 'large', 'small'].indexOf(value) !== -1
            },
            default: 'small'
        },
        fetchData: {
            type: Function,
            default: undefined
        },
        dataKey: {
            type: String,
            required: true
        },
        itemId: {
            type: String,
            default: 'id'
        },
        itemName: {
            type: String,
            default: 'name'
        },
        value: {
            type: Object
        },
        placeholder: {
            type: String
        },
        searchEnable: {
            type: Boolean
        },
        minWidth: {
            type: String
        }
    },
    data() {
        return {
            total: 0,
            limit: 20,
            page: 1,
            dataSource: [],
            isOpen: false
        }
    },
    methods: {
        refetchData() {
            let limit = this.limit
            let page = this.page
            let searchCondition = this.searchCondition
            if (typeof this.fetchData === 'function') {
                this.fetchData(limit, (page - 1) * limit, searchCondition)
                    .then((result) => {
                        this.dataSource = result.data[this.dataKey]
                        this.total = result.data.total
                    })
                    .catch(() => { })
            }
        },
        onPageChange(page) {
            this.page = page
            this.refetchData()
        },
        onLimitChange(current, pageSize) {
            this.limit = pageSize
            this.page = 1
            this.refetchData()
        },
        handleVisibleChange(visible) {
            this.isOpen = visible
            this.dataSource = []
            if (visible) {
                this.refetchData()
            }
        },
        onChange(item) {
            let that = this
            return (e) => {
                e.stopPropagation()
                that.isOpen = false
                that.$emit('change', item)
            }
        },
        onClear(e) {
            e.stopPropagation()
            this.isOpen = false
            this.$emit('change', undefined)
        },
        onSearch(value) {
            this.searchCondition = value
            this.page = 1
            this.refetchData()
        },
        onSearchChange(e) {
            this.searchCondition = e.target.value
        },
        renderOptions() {
            let dataSource = this.dataSource
            let value = this.value || {}
            let itemIdKey = this.itemId
            let searchEnable = !!this.searchEnable
            let searchPlaceHodler = this.searchPlaceHodler
            return dataSource.length > 0
                ? (
                    <div>
                        <div class='select__list' style={{ minWidth: this.minWidth }}>
                            {searchEnable ? <a-input-search
                                class='select__search'
                                placeholder={searchPlaceHodler}
                                onSearch={this.onSearch}
                                value={this.searchCondition}
                                onChange={this.onSearchChange}
                            />
                                : null}
                            <ul style={{ margin: 0, padding: 0 }}>
                                {dataSource.map((item, i) => {
                                    let isSelected = value
                                        ? value[itemIdKey] === item[itemIdKey]
                                        : false
                                    return (
                                        <li
                                            key={i + ""}
                                            unselectable="unselectable"
                                            class={["ant-select-dropdown-menu-item", isSelected
                                                ? "ant-select-dropdown-menu-item_selected"
                                                : ""]}
                                            role="menuitem"
                                            aria-selected="false"
                                            onClick={this.onChange(item)}
                                            style={{
                                                userSelect: "none"
                                            }}>
                                            {item.name}</li>
                                    )
                                })}
                            </ul>
                        </div>
                        <div class='select__pagination'>
                            <a-pagination
                                onChange={this.onPageChange}
                                current={this.page}
                                total={this.total}
                                pageSize={this.limit}
                                onShowSizeChange={this.onLimitChange}
                                pageSizeOptions={this.pageSizeOptions}
                                size="small"
                                showSizeChanger
                                showTotal={total => `总共 ${total} 条`} />
                        </div>
                    </div >
                )
                : (
                    <div class='select__list' style={{ minWidth: this.minWidth }}>
                        {searchEnable ? <a-input-search
                            class='select__search'
                            placeholder={searchPlaceHodler}
                            onSearch={this.onSearch}
                            value={this.searchCondition}
                            onChange={this.onSearchChange}
                        />
                            : null}
                        <ul
                            class="ant-select-dropdown-menu ant-select-dropdown-menu-vertical ant-select-dropdown-menu-root"
                            role="menu"
                            aria-activedescendant="">
                            <li
                                unselectable="unselectable"
                                class="ant-select-dropdown-menu-item-disabled ant-select-dropdown-menu-item"
                                role="menuitem"
                                aria-selected="false"
                                aria-disabled="true"
                                style={{
                                    userSelect: "none"
                                }}>{'无匹配结果'}</li>
                        </ul>
                    </div>
                )
        },
    },
    render() {
        let value = this.value
        let allowClear = this.allowClear
        let sizeClass = ''
        switch (this.size) {
            case 'large':
                sizeClass = 'ant-select-lg'
                break
            case 'small':
                sizeClass = 'ant-select-sm'
                break
        }

        return (
            <a-popover
                content={this.renderOptions()}
                overlayClassName='select__popover'
                overlayStyle={{ minWidth: this.width }}
                placement="bottom"
                trigger="click"
                visible={this.isOpen}
                onVisibleChange={this.handleVisibleChange}>
                <div
                    class={[sizeClass, 'select', this.className, 'ant-select', 'ant-select-enabled',
                        this.isOpen
                            ? 'ant-select-open'
                            : '']}>
                    <div
                        class={["ant-select-selection", "ant-select-selection--single"]}
                        role="combobox"
                        aria-autocomplete="list"
                        aria-haspopup="true"
                        aria-expanded="false"
                        tabIndex="0">
                        {value
                            ? <div class="ant-select-selection__rendered">
                                <div
                                    class="ant-select-selection-selected-value"
                                    style={{
                                        display: "block",
                                        opacity: 1
                                    }}>{value[this.itemName]}</div>
                            </div>
                            : <div class="ant-select-selection__rendered">
                                <div
                                    unselectable="unselectable"
                                    class="ant-select-selection__placeholder"
                                    style={{
                                        display: "block",
                                        userSelect: "none"
                                    }}>{this.placeholder || '请选择'}</div>
                            </div>}
                        {
                            allowClear && this.value
                                ? <span unselectable="unselectable"
                                    class="ant-select-selection__clear"
                                    onClick={this.onClear}
                                    style={{ userSelect: "none", display: "block" }}></span>
                                : null}
                        <span
                            class="ant-select-arrow"
                            unselectable="unselectable"
                            style={{
                                userSelect: "none"
                            }}>
                            <b></b>
                        </span>
                    </div>
                </div>
            </a-popover>
        )
    }
}
</script>

<style lang="stylus" scoped>
smallPaddingLR() {
    padding-left: $smallPadding;
    padding-right: $smallPadding;
}

.select {
    width: 200px;
    display: inline-block;

    &__render {
        user-select: none;
        box-sizing: border-box;
        display: block;
        background-color: #fff;
        border: 1px solid #d9d9d9;
        transition: all 0.3s cubic-bezier(0.645, 0.045, 0.355, 1);
    }

    &__popover {
        max-width: 600px;

        :global(.ant-popover-arrow) {
            display: none;
        }

        :global(.ant-popover-title) {
            display: none;
        }

        :global(.ant-popover-inner-content) {
            padding: 0;
        }
    }

    &__list {
        overflow-y: auto;
        overflow-x: hidden;
        max-height: 200px;
    }

    &__pagination {
        padding: 7px 8px;
    }

    &__search {
        padding: 5px;

        :global(.ant-input-suffix) {
            right: 12px !importan;
        }
    }
}
</style>