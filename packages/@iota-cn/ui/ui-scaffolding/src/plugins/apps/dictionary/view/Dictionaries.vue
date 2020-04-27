
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
import { Validator } from '@iota-cn/util-validation'
import { message } from 'ant-design-vue/es'

export default {
    name: 'IiDictionaries',
    data() {
        const dictionaySchema = {
            "type": "object",
            "properties": {
                "key": {
                    "type": "string",
                    rules: {
                        required: {
                            value: true,
                            errMsg: '请输入字典Key'
                        },
                        iivalidator: {
                            value: 'isCommonName',
                            errMsg: Validator.commonNameHelp
                        },
                    },
                    "ui": {
                        "label": "字典Key",
                        "placeholder": "字典Key"
                    }
                },
                "name": {
                    "type": "string",
                    rules: {
                        required: {
                            value: true,
                            errMsg: '请输入字典名称'
                        },
                        iivalidator: {
                            value: 'isCommonName',
                            errMsg: Validator.commonNameHelp
                        },
                    },
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
                    rules: {
                        required: {
                            value: true,
                            errMsg: '请输入条目Key'
                        },
                        iivalidator: {
                            value: 'isCommonName',
                            errMsg: Validator.commonNameHelp
                        },
                    },
                    "ui": {
                        "label": "条目Key",
                        "placeholder": "条目Key"
                    }
                },
                "name": {
                    "type": "string",
                    rules: {
                        required: {
                            value: true,
                            errMsg: '请输入条目名称'
                        },
                        iivalidator: {
                            value: 'isCommonName',
                            errMsg: Validator.commonNameHelp
                        },
                    },
                    "ui": {
                        "label": "条目名称",
                        "placeholder": "条目名称"
                    }
                },
                "index": {
                    "type": "string",
                    rules: {
                        required: false,
                        number: {
                            value: true,
                            minimum: 0,
                            maximum: 100
                        }
                    },
                    "ui": {
                        "label": "条目序号",
                        "placeholder": "条目序号"
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
            this.dictionary.page = page
            this.refetchDictionaries()
        },
        onLimitChange(current, pageSize) {
            this.dictionary.limit = pageSize
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
        onDeleteDictionary({ dictionary }) {
            return () => {
                return this.$axios.silentDelete(`/v1/api/dictionaries/${dictionary.key}`, true)
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
                        }).catch(() => {
                            // if (err.response && err.response.status === 409) { message.error('该条目Key已存在，请修改后再提交') }
                            message.error('该字典Key已存在，请修改后再提交')
                        })
                }
            })
        },
        onAddDictCancel() {
            this.dictionary.showAdd = false
            this.dictionary.editValue = {}
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
                    this.$axios.silentPut(`v1/api/dictionaries/${this.dictionary.editItem.key}`, this.dictionary.editValue, true)
                        .then(() => {
                            this.dictionary.showEdit = false
                            this.refetchDictionaries()
                            this.dictionary.editValue = {}
                        }).catch(() => {
                            // if (err.response && err.response.status === 409) { message.error('该条目Key已存在，请修改后再提交') }
                            message.error('该字典Key已存在，请修改后再提交')
                        })
                }
            })
        },
        onEditDictCancel() {
            this.dictionary.showEdit = false
            this.dictionary.editValue = {}
        },
        renderDictionaries() {
            let canUpdate = this.$p('/dictionaries/:id:PUT')
            let canDelete = this.$p('/dictionaries/:id:DELETE')
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
                },
                {
                    title: '操作',
                    dataIndex: 'operation',
                    width: '20%',
                    customRender: (text, record, index) => {
                        return (
                            <div class='operation'>
                                {
                                    canUpdate ?
                                        <a onClick={this.onShowEdit(record)}>编辑</a>
                                        : null
                                }
                                <ADivider type="vertical" />
                                {
                                    canDelete ?
                                        <IiModal
                                            title="删除"
                                            content={(<span>是否删除字典:{record.name}</span>)}
                                            button={(<a>删除</a>)}
                                            ok={this.onDeleteDictionary({ dictionary: record, index })}
                                            clearFloat={true} />
                                        : null
                                }
                            </div>
                        )
                    },
                }]
            // const rowSelection = { onChange: this.onSelectChange }
            const pageSizeOptions = ['20', '40', '60', '80']
            return (
                <ii-card title='字典管理'>
                    <IiIcon type='dictionary' slot='icon' />
                    {
                        this.$p('/dictionaries/:key?:GET') ?
                            <AButton style={{ marginRight: '8px' }} slot="extra" size='small' key="refresh" onClick={this.refetchDictionaries}>
                                <AIcon type="reload" /> 刷新
                            </AButton>
                            : null
                    }
                    {
                        this.$p('/dictionaries:POST') ?
                            <AButton style={{ marginRight: '8px' }} slot="extra" size='small' key="add" onClick={this.showAdd}>
                                <AIcon type="plus" /> 创建字典
                            </AButton>
                            : null
                    }
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
                        rowSelection={{ type: 'radio', selectedRowKeys: [this.dictionary.editItem ? this.dictionary.editItem.id : undefined] }}
                        size='small'
                        headheight={68}
                        total={this.dictionary.total}
                        pageSize={this.dictionary.limit}
                        currentPage={this.dictionary.page}
                        showSizeChanger={true}
                        onShowSizeChange={this.onLimitChange}
                        onPaginationChange={this.onPageChange}
                        pageSizeOptions={pageSizeOptions}
                        onRowClick={this.onDictionaryClick}
                        class={'table'}
                        showPagination='both'
                        columns={columns}
                        rows={this.dictionary.items}>
                    </IiTableLayout>
                </ii-card>
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
                        }).catch((err) => {
                            if (err.response && err.response.status === 409) { message.error('该条目Key已存在，请修改后再提交') }
                        })
                }
            })
        },
        onAddItemCancel() {
            this.dictionaryItem.showAdd = false
            this.dictionaryItem.editValue = {}
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
                        }).catch((err) => {
                            if (err.response && err.response.status === 409) { message.error('该条目Key已存在，请修改后再提交') }
                        })
                }
            })
        },
        onEditItemCancel() {
            this.dictionaryItem.showEdit = false
        },
        refetchDictionaryItems() {
            this.$axios.silentGet(`/v1/api/dictionaries/${this.dictionary.editItem.key}`, true)
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
            let canUpdate = this.$p('/dictionaries/:dictionaryId/items/:id:PUT')
            let canDelete = this.$p('/dictionaries/:dictionaryId/items/:id:DELETE')
            const columns = [
                {
                    title: '条目Key',
                    dataIndex: 'key',
                    key: 'key',
                    width: '25%',
                },
                {
                    title: '条目名称',
                    dataIndex: 'name',
                    key: 'name',
                    width: '30% ',
                },
                {
                    title: '条目序号',
                    dataIndex: 'index',
                    key: 'index',
                    width: '25% ',
                },
                {
                    title: '操作',
                    dataIndex: 'operation',
                    width: '20%',
                    customRender: (text, record) => {
                        return (
                            <div class='operation'>
                                {
                                    canUpdate ?
                                        <a onClick={this.onShowItemEdit(record)}>编辑</a>
                                        : null
                                }
                                <ADivider type="vertical" />
                                {
                                    canDelete ?
                                        <IiModal
                                            title="删除"
                                            content={(<span>是否删除字典条目:{record.name}</span>)}
                                            button={(<a>删除</a>)}
                                            ok={this.onDeleteItem(record)}
                                            clearFloat={true} />
                                        : null
                                }
                            </div>
                        )
                    },
                }]
            let children = []
            if (this.dictionary.editItem) {
                children = [
                    this.$p('/dictionaries/:dictionaryId/items:GET') ?
                        <AButton style={{ marginRight: '8px' }} slot="extra" size='small' key="refresh" onClick={this.refetchDictionaryItems}>
                            <AIcon type="reload" /> 刷新
                        </AButton>
                        : null,
                    this.$p('/dictionaries/:dictionaryId/items:POST') ?
                        <AButton style={{ marginRight: '8px' }} slot="extra" size='small' key="add" onClick={this.showItemAdd}>
                            <AIcon type="plus" /> 创建条目
                        </AButton>
                        : null,
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
                        size='small'
                        headheight={68}
                        class={'table'}
                        columns={columns}
                        rows={this.dictionaryItem.items}>
                    </IiTableLayout>
                ]
            }
            return (
                <ii-card title='字典条目'>
                    <IiIcon type='list' slot='icon' />
                    {children}
                </ii-card>
            )
        }
    },

    render() {
        return (
            <div class='ii-dictionary'>
                <splitpanes class="default-theme">
                    <splitpane size='35' min-size="20" max-size="60">
                        {this.renderDictionaries()}
                    </splitpane>
                    <splitpane size='65' style={{ flex: 1 }}>
                        {this.renderItems()}
                    </splitpane>
                </splitpanes>
            </div>
        )
    }
}
</script>

<style lang="stylus" scoped>
@import '../../../../styles/imports';

.operation {
    display: flex;
    justify-content: left;
    align-items: center;

    a {
        color: $primary-color;
    }
}

.ii-dictionary {
    height: 100%;
    width: 100%;
    overflow: hidden;
}
</style>