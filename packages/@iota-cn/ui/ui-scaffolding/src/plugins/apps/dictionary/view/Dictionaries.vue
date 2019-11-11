
<script>
// <template>
//     <div class="ii-dictionary">
//         <a-row class='row'
//             type='flex'
//             :gutter='16'
//             justify='center'>
//             <a-col class="col"
//                 :span='10'>
//                 <a-card title="数据字典">
//                 </a-card>
//             </a-col>
//             <a-col class="col"
//                 :span='14'>
//                 <a-card title="字典条目">
//                 </a-card>
//             </a-col>
//         </a-row>
//     </div>
// </template>
import { Menu as AMenu } from 'ant-design-vue'
export default {
    data() {
        const dictionaySchema = {
            "type": "object",
            "properties": {
                "key": {
                    "type": "string",
                    "ui": {
                        "label": "字典Key",
                        "placeholder": "字典Key"
                    }
                },
                "name": {
                    "type": "string",
                    "ui": {
                        "label": "字典名称",
                        "placeholder": "字典名称"
                    }
                }
            },
            "ui": {
                "widgetConfig": {
                    "layout": "h"
                }
            }
        }
        const itemSchema = {
            "type": "object",
            "properties": {
                "key": {
                    "type": "string",
                    "ui": {
                        "label": "条目Key",
                        "placeholder": "条目Key"
                    }
                },
                "name": {
                    "type": "string",
                    "ui": {
                        "label": "条目名称",
                        "placeholder": "条目名称"
                    }
                }
            },
            "ui": {
                "widgetConfig": {
                    "layout": "h"
                }
            }
        }
        return {
            dictionary: {
                limit: 20,
                page: 0,
                total: 0,
                newItem: undefined,
                editItem: undefined,
                editValue: undefined,
                items: [],
                schema: dictionaySchema,
                showAdd: false,
                showEdit: false
            },
            dictionaryItem: {
                schema: itemSchema,
                newItem: undefined,
                editItem: undefined,
                editValue: undefined,
                showAdd: false,
                showEdit: false,
                items: []
            }
        }
    },
    mounted() {
        this.refetchDictionaries()
    },
    methods: {
        // dictionary
        onPageChange(page) {
            this.page = page
            this.refetchDictionaries()
        },
        onLimitChange(current, pageSize) {
            this.limit = pageSize
            this.page = 1
            this.refetchDictionaries()
        },
        refetchDictionaries() {
            this.$axios.silentGet(`/v1/api/dictionaries`, true)
                .then((res) => {
                    this.dictionary.items = res.data.dictionaries
                    this.dictionary.total = res.data.total
                    this.dictionary.editItem = undefined
                }).catch(() => { })
        },
        onDictionaryClick(dictionary) {
            this.dictionary.editItem = dictionary
            this.refetchDictionaryItems()
        },
        onDeleteDictionary(dictionary) {
            return () => {
                return this.$axios.silentDelete(`/v1/api/dictionaries/${dictionary.id}`, true)
                    .then(() => {
                        this.refetchDictionaries()
                        this.dictionary.editItem = undefined
                    }).catch(() => { return true })
            }
        },
        // add dictionary
        showAdd() {
            this.dictionary.showAdd = true
        },
        onAddDictOk() {
            this.$ncformValidate('_addDictForm').then(data => {
                if (data.result) {
                    this.$axios.silentPost(`v1/api/dictionaries`, this.dictionary.newItem, true)
                        .then(() => {
                            this.dictionary.showAdd = false
                            this.refetchDictionaries()
                            this.dictionary.newItem = {}
                        }).catch(() => { })
                }
            })
        },
        onAddDictCancel() {
            this.dictionary.showAdd = false
        },
        // add end

        // edit
        onShowEdit(dictionary) {
            return () => {
                this.dictionary.editItem = dictionary
                this.dictionary.editValue = dictionary
                this.dictionary.showEdit = true
            }
        },
        onEditDictOk() {
            this.$ncformValidate('_editDictForm').then(data => {
                if (data.result) {
                    this.$axios.silentPut(`v1/api/dictionaries/${this.dictionary.editItem.id}`, this.dictionary.editValue, true)
                        .then(() => {
                            this.dictionary.showEdit = false
                            this.refetchDictionaries()
                            this.dictionary.editValue = {}
                        }).catch(() => { })
                }
            })
        },
        onEditDictCancel() {
            this.dictionary.showEdit = false
        },
        renderDictionaries() {
            const columns = [
                {
                    title: '字典Key',
                    dataIndex: 'key',
                    key: 'key',
                    width: '40%',
                },
                {
                    title: '字典名称',
                    dataIndex: 'name',
                    key: 'name',
                    width: '40% ',
                },
                {
                    title: '操作',
                    dataIndex: 'operation',
                    width: '20%',
                    customRender: (text, record) => {
                        const operation = (
                            <AMenu styles={{ display: 'inline-block' }} class='noPaddingMenu'>
                                <AMenu.Item key="edit">
                                    <div style={{ padding: '2px 0px', fontiSize: '12px' }} onClick={this.onShowEdit(record)}><AIcon type="edit" /> 编辑 </div>
                                </AMenu.Item>
                                <AMenu.Item key="delete">
                                    <IiModal
                                        title="删除"
                                        content={(<span>是否删除字典:{record.name}</span>)}
                                        button={(<div style={{ padding: '2px 0px', fontiSize: '12px' }}><AIcon type="delete" /> 删除</div>)}
                                        ok={this.onDeleteDictionary(record)}
                                        clearFloat={true} />
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
            // const rowSelection = { onChange: this.onSelectChange }
            const pageSizeOptions = ['20', '40', '60', '80']
            return (
                <a-card title="字典管理"
                    bodyStyle={{ padding: "2px", flex: 1 }}
                    style={{
                        height: '100%', width: '100%', overflow: 'hidden', backgroundColor: 'white',
                        display: 'flex', flexDirection: 'column'                    }}>
                    <AButton style={{ marginRight: '8px' }} slot="extra" size='small' key="refresh" onClick={this.refetchDictionaries}>
                        <AIcon type="reload" /> 刷新
                    </AButton>
                    <AButton style={{ marginRight: '8px' }} slot="extra" size='small' key="add" onClick={this.showAdd}>
                        <AIcon type="plus" /> 创建字典
                    </AButton>
                    <AModal
                        title="新建字典"
                        key={'addDict'}
                        visible={this.dictionary.showAdd}
                        onOk={this.onAddDictOk}
                        onCancel={this.onAddDictCancel}>
                        <ncform formName='_addDictForm' formSchema={this.dictionary.schema} vModel={this.dictionary.newItem} />
                    </AModal>
                    <AModal
                        title="修改字典"
                        key={'editDict'}
                        visible={this.dictionary.showEdit}
                        onOk={this.onEditDictOk}
                        onCancel={this.onEditDictCancel}>
                        <ncform formName='_editDictForm' formSchema={this.dictionary.schema} vModel={this.dictionary.editValue} />
                    </AModal>
                    <IiTableLayout
                        size='middle'
                        headheight={68}
                        total={this.dictionary.total}
                        pageSize={this.dictionary.limit}
                        currentPage={this.dictionary.page}
                        showSizeChanger={true}
                        onShowSizeChange={this.onLimitChange}
                        onPaginationChange={this.onPageChange}
                        pageSizeOptions={pageSizeOptions}
                        onRowClick={this.onDictionaryClick}
                        className={'table'}
                        showPagination='both'
                        // selected={selectedRowKeys.length}
                        showSizeChanger={false}
                        // rowSelection={rowSelection}
                        columns={columns}
                        rows={this.dictionary.items}>
                    </IiTableLayout>
                </a-card>
            )
        },
        //dictionary items
        showItemAdd() {
            this.dictionaryItem.showAdd = true
        },
        onAddItemOk() {
            this.$ncformValidate('_addItemForm').then(data => {
                if (data.result) {
                    this.$axios.silentPost(`v1/api/dictionaries/${this.dictionary.editItem.id}/items`, this.dictionaryItem.newItem, true)
                        .then(() => {
                            this.dictionaryItem.showAdd = false
                            this.refetchDictionaryItems()
                            this.dictionaryItem.newItem = {}
                        }).catch(() => { })
                }
            })
        },
        onAddItemCancel() {
            this.dictionaryItem.showAdd = false
        },
        onShowItemEdit(item) {
            return () => {
                this.dictionaryItem.editItem = item
                this.dictionaryItem.editValue = item
                this.dictionaryItem.showEdit = true
            }
        },
        onEditItemOk() {
            this.$ncformValidate('_editItemForm').then(data => {
                if (data.result) {
                    this.$axios.silentPut(`v1/api/dictionaries/${this.dictionary.editItem.id}/items/${this.dictionaryItem.editItem.id}`,
                        this.dictionaryItem.editValue, true)
                        .then(() => {
                            this.dictionaryItem.showEdit = false
                            this.refetchDictionaryItems()
                            this.dictionaryItem.editValue = {}
                        }).catch(() => { })
                }
            })
        },
        onEditItemCancel() {
            this.dictionaryItem.showEdit = false
        },
        refetchDictionaryItems() {
            this.$axios.silentGet(`/v1/api/dictionaries/${this.dictionary.editItem.id}`, true)
                .then((res) => {
                    this.dictionaryItem.items = res.data.items
                }).catch(() => { })
        },
        onDeleteItem(item) {
            return () => {
                return this.$axios.silentDelete(`/v1/api/dictionaries/${this.dictionary.editItem.id}/items/${item.id}`, true)
                    .then(() => {
                        this.refetchDictionaryItems()
                        this.dictionaryItem.editItem = undefined
                    }).catch(() => { return true })
            }
        },
        renderItems() {
            const columns = [
                {
                    title: '条目Key',
                    dataIndex: 'key',
                    key: 'key',
                    width: '40%',
                },
                {
                    title: '条目名称',
                    dataIndex: 'name',
                    key: 'name',
                    width: '40% ',
                },
                {
                    title: '操作',
                    dataIndex: 'operation',
                    width: '20%',
                    customRender: (text, record) => {
                        const operation = (
                            <AMenu styles={{ display: 'inline-block' }} class='noPaddingMenu'>
                                <AMenu.Item key="edit">
                                    <div style={{ padding: '2px 0px', fontiSize: '12px' }} onClick={this.onShowItemEdit(record)}><AIcon type="edit" /> 编辑 </div>
                                </AMenu.Item>
                                <AMenu.Item key="delete">
                                    <IiModal
                                        title="删除条目"
                                        content={(<span>是否删除字典条目:{record.name}</span>)}
                                        button={(<div style={{ padding: '2px 0px', fontiSize: '12px' }}><AIcon type="delete" /> 删除</div>)}
                                        ok={this.onDeleteItem(record)}
                                        clearFloat={true} />
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
            let children = []
            if (this.dictionary.editItem) {
                children = [
                    <AButton style={{ marginRight: '8px' }} slot="extra" size='small' key="refresh" onClick={this.refetchDictionaryItems}>
                        <AIcon type="reload" /> 刷新
                    </AButton>,
                    <AButton style={{ marginRight: '8px' }} slot="extra" size='small' key="add" onClick={this.showItemAdd}>
                        <AIcon type="plus" /> 创建条目
                    </AButton>,
                    <AModal
                        title="新建条目"
                        key={'addItem'}
                        visible={this.dictionaryItem.showAdd}
                        onOk={this.onAddItemOk}
                        onCancel={this.onAddItemCancel}>
                        <ncform formName='_addItemForm' formSchema={this.dictionaryItem.schema} vModel={this.dictionaryItem.newItem} />
                    </AModal>,
                    <AModal
                        title="修改条目"
                        key={'editItem'}
                        visible={this.dictionaryItem.showEdit}
                        onOk={this.onEditItemOk}
                        onCancel={this.onEditItemCancel}>
                        <ncform formName='_editItemForm' formSchema={this.dictionaryItem.schema} vModel={this.dictionaryItem.editValue} />
                    </AModal>,
                    <IiTableLayout
                        key='table'
                        size='middle'
                        headheight={68}
                        className={'table'}
                        columns={columns}
                        rows={this.dictionaryItem.items}>
                    </IiTableLayout>
                ]
            }
            return (
                <a-card title="字典条目"
                    bodyStyle={{ padding: "2px", flex: 1 }}
                    style={{
                        height: '100%', width: '100%', overflow: 'hidden', backgroundColor: 'white',
                        display: 'flex', flexDirection: 'column'                    }}>
                    {children}
                </a-card>
            )
        }
    },

    render() {
        return (
            <div class='ii-dictionary'>
                <ARow gutter={16} class='row'>
                    <ACol span={10} class='col'>
                        {this.renderDictionaries()}
                    </ACol>
                    <ACol span={14} class='col'>
                        {this.renderItems()}
                    </ACol>
                </ARow>
            </div>
        )
    }
}
</script>

<style lang="stylus" scoped>
.ii-dictionary {
    height: 100%;
    width: 100%;
    overflow: hidden;

    .row {
        height: 100%;
    }

    .col {
        height: 100%;
    }
}
</style>