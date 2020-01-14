
<script>
// import { Validator } from '@iota-cn/util-validation'
import { message } from 'ant-design-vue/es'
import BpmnModeler from './components/bpmn-modeler/Modeler'
import FormEditor from './components/FormEditor'

/**
 * 
 */
const createBpmnXML = (processDefinitionKey) => {
    return `<?xml version="1.0" encoding="UTF-8"?> \
            <bpmn:definitions xmlns:bpmn="http://www.omg.org/spec/BPMN/20100524/MODEL" xmlns:bpmndi="http://www.omg.org/spec/BPMN/20100524/DI" xmlns:di="http://www.omg.org/spec/DD/20100524/DI" xmlns:dc="http://www.omg.org/spec/DD/20100524/DC" id="Definitions_03dabax" targetNamespace="http://bpmn.io/schema/bpmn" exporter="Modeler" exporterVersion="2.0.3"> \
                <bpmn:process id="${processDefinitionKey || 'process_x'}" isExecutable="true"> \
                </bpmn:process> \
                <bpmndi:BPMNDiagram id="BPMNDiagram_1"> \
                    <bpmndi:BPMNPlane id="BPMNPlane_1" bpmnElement="Process_1"> \
                    </bpmndi:BPMNPlane> \
                </bpmndi:BPMNDiagram> \
            </bpmn:definitions> \
            `
}
export default {
    name: 'IiFlowDefinitions',
    components: {
        'ii-bpmn-modeler': BpmnModeler,
        'ii-form-editor': FormEditor
    },
    data() {
        const formSchema = {
            "type": "object",
            "properties": {
                "processDefinitionKey": {
                    "type": "string",
                    "rules": {
                        "required": {
                            "value": true,
                            "errMsg": "请输入Key"
                        },
                        "iivalidator": {
                            "value": "isCommonName",
                            "errMsg": "Validator.commonNameHelp"
                        }
                    },
                    "ui": {
                        "label": "Key",
                        "placeholder": "Key"
                    }
                },
                "name": {
                    "type": "string",
                    "rules": {
                        "required": {
                            "value": true,
                            "errMsg": "请输入名称"
                        },
                        "iivalidator": {
                            "value": "isCommonName",
                            "errMsg": "Validator.commonNameHelp"
                        }
                    },
                    "ui": {
                        "label": "名称",
                        "placeholder": "名称"
                    }
                },
                "desc": {
                    "type": "string",
                    "rules": {

                    },
                    "ui": {
                        "label": "描述",
                        "placeholder": "描述"
                    }
                },
                "category": {
                    "type": "string",
                    "ui": {
                        "label": "分类",
                        "placeholder": "请选择分类",
                        "widget": "select",
                        "widgetConfig": {
                            "itemLabelField": "name",
                            "itemValueField": "key",
                            "enumSourceRemote": {
                                "remoteUrl": "/v1/api/dictionaries/frame_flowable_categories",
                                "resField": "items"
                            }
                        }
                    }
                },
                "disabled": {
                    "type": "boolean",
                    "ui": {
                        "widget": "switch",
                        "label": "禁用"
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
            limit: 20,
            page: 1,
            total: 0,
            newItem: undefined,
            editItem: undefined,
            editIndex: undefined,
            showEdit: false,
            editValue: {},
            items: [],
            schema: formSchema,
            showBpmnModal: false,
            categories: [],
            showFormModal: false
        }
    },
    beforeCreate() {
        this.$axios.silentGet('/v1/api/dictionaries/frame_flowable_categories').then((res) => {
            if (res) {
                this.categories = {}
                res.data.items.forEach(i => {
                    this.categories[i.key] = { name: i.name, index: i.index }
                })
            }
        })
    },
    mounted() {
        this.refetchDefinistions()
    },
    methods: {
        // processdef
        onPageChange(page) {
            this.page = page
            this.refetchDefinistions()
        },
        onLimitChange(current, pageSize) {
            this.limit = pageSize
            this.page = 1
            this.refetchDefinistions()
        },
        refetchDefinistions() {
            this.clearSelect()
            // if (this.$p('/processdefs_include_bpmn/:processDefinitionKey?:GET')) {
            this.$axios.silentGet(`/v1/api/processdefs_include_bpmn?limit=${this.limit}&offset=${(this.page - 1) * this.limit}`, true)
                .then((res) => {
                    this.items = res.data.processdefs
                    this.total = res.data.total
                }).catch(() => { })
            // }
        },
        onSelect({ processdef, index }) {
            this.editItem = processdef
            this.editIndex = index
            this.editValue = processdef
        },
        clearSelect() {
            this.editItem = undefined
            this.editIndex = undefined
            this.editValue = {}
        },
        onClick(processdef, index) {
            this.onSelect({ processdef, index })
        },
        onDelete({ processdef }) {
            return () => {
                return this.$axios.silentDelete(`/v1/api/processdefs/${processdef.processDefinitionKey}`, true)
                    .then(() => {
                        this.refetchDefinistions()
                    }).catch(() => {
                        message.error('删除失败，请稍后再试')
                        return true
                    })
            }
        },
        // add processdef
        onAddOk() {
            return this.$ncformValidate('_addProcessdefForm').then(data => {
                if (data.result) {
                    return this.$axios.silentPost(`v1/api/processdefs`, this.newItem, true)
                        .then(() => {
                            this.refetchDefinistions()
                            this.newItem = {}
                            return true
                        }).catch(() => {
                            message.error('该流程Key已存在，请修改后再提交')
                        })
                }
            })
        },
        onAddCancel() {
            this.editValue = {}
        },
        // add end

        // edit
        onShowEdit({ processdef, index }) {
            return () => {
                this.onSelect({ processdef, index })
                this.showEdit = true
            }
        },
        onEditOk() {
            this.$ncformValidate('_editProcessdefForm').then(data => {
                if (data.result) {
                    if (this.editItem.processDefinitionKey !== this.editValue.processDefinitionKey) {
                        //@Todo 
                        // change key of model
                        // delete old model?
                    }
                    this.updateProcessdef(this.editItem, this.editIndex, this.editValue).then(() => {
                        this.showEdit = false
                    }).catch(() => {
                        // if (err.response && err.response.status === 409) { message.error('该条目Key已存在，请修改后再提交') }
                        message.error('该流程Key已存在，请修改后再提交')
                    })
                }
            })
        },
        onEditCancel() {
            this.showEdit = false
        },
        onDeploy({ processdef }) {
            return () => {
                return this.$axios.silentPost(`v1/api/processdefs/deploy/${processdef.processDefinitionKey}`, {}, true)
                    .then(() => {
                        message.success('流程部署成功')
                        return true
                    }).catch(() => {
                        message.error('流程部署失败，请检查流程定义，稍后再试')
                        return true
                    })
            }
        },
        onEditBpmn({ processdef, index }) {
            return () => {
                this.onSelect({ processdef, index })
                this.showBpmnModal = true
            }
        },
        onEditBpmnCancel() {
            this.showBpmnModal = false
        },
        onSaveBpmn(bpmnXML) {
            try {
                let parser = new DOMParser()
                let doc = parser.parseFromString(bpmnXML, "text/xml")
                if (doc && doc.querySelector('process')) {
                    doc.querySelector('process').setAttribute('id', this.editItem.processDefinitionKey)
                } else {
                    message.error('无效的流程模型')
                    return
                }
                let xmlSerializer = new XMLSerializer()
                this.updateProcessdef(this.editItem, this.editIndex, { bpmnXML: xmlSerializer.serializeToString(doc) }).then(() => {
                    this.showBpmnModal = false
                }).catch(() => {
                    message.error('修改流程模型失败，请稍后再试')
                })
            } catch (err) {
                message.error('无效的流程模型')
            }
        },
        onEditForm({ processdef, index }) {
            return () => {
                this.onSelect({ processdef, index })
                this.showFormModal = true
            }
        },
        onEditFormCancel() {
            this.showFormModal = false
        },
        onSaveForm(formDef) {
            this.updateProcessdef(this.editItem, this.editIndex, { formDef }).then(() => {
                this.showFormModal = false
            }).catch(() => {
                message.error('修改表单失败，请稍后再试')
            })
        },
        async updateProcessdef(processdef, index, changed) {
            return this.$axios.silentPut(`v1/api/processdefs/${processdef.processDefinitionKey}`, changed, true).then(() => {
                processdef = Object.assign({}, processdef, changed)
                this.items.splice(index, 1, processdef)
            })
        }
    },

    render() {

        // @Todo support delete
        // <ADivider type="vertical" />
        // {
        //     this.$p('/processdefs/:processDefinitionKey:DELETE') ?
        //         <IiModal
        //             title="删除"
        //             content={(<span>是否删除流程:{record.name}</span>)}
        //             button={(<a>删除</a>)}
        //             ok={this.onDelete({ processdef: record, index })}
        //             clearFloat={true} />
        //         : null
        // }        
        let canUpdate = this.$p('/processdefs/:processDefinitionKey:PUT')
        let canDeploy = this.$p('/processdefs/deploy/:processDefinitionKey:POST')
        const columns = [
            {
                title: 'Key',
                dataIndex: 'processDefinitionKey',
                key: 'processDefinitionKey',
            },
            {
                title: '名称',
                dataIndex: 'name',
                key: 'name',
                width: '20%',
            },
            {
                title: '分类',
                dataIndex: 'category',
                key: 'category',
                width: '20%',
                customRender: (text, record) => {
                    return this.categories[record.category] ? this.categories[record.category].name : ''
                }
            },
            {
                title: '状态',
                dataIndex: 'disabled',
                key: 'disabled',
                width: '10%',
                customRender: (text, record) => {
                    return (<IiStatus revert={true} value={record.disabled} text={record.disabled ? '禁用' : '启用'} />)
                }
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
                                    <a onClick={this.onShowEdit({ processdef: record, index })}>编辑</a>
                                    : null
                            }
                            <ADivider type="vertical" />
                            {
                                canUpdate ?
                                    <a onClick={this.onEditBpmn({ processdef: record, index })}>流程模型</a>
                                    : null
                            }
                            <ADivider type="vertical" />
                            {
                                canUpdate ?
                                    <a onClick={this.onEditForm({ processdef: record, index })}>表单</a>
                                    : null
                            }
                            <ADivider type="vertical" />
                            {
                                canDeploy && record.bpmnXML && record.formDef ?
                                    <IiModal
                                        title="部署"
                                        content={(<span>是否部署流程:{record.name}</span>)}
                                        button={(<a>部署</a>)}
                                        ok={this.onDeploy({ processdef: record, index })}
                                        clearFloat={true} />
                                    : null
                            }
                        </div>
                    )
                },
            }]
        // const rowSelection = {onChange: this.onSelectChange }
        const pageSizeOptions = ['20', '40', '60', '80']
        const controls = [
            this.$p('/processdefs_include_bpmn/:processDefinitionKey?:GET') ?
                <AButton style={{ marginRight: '8px' }} slot="extra" size='small' key="refresh" onClick={this.refetchDefinistions}>
                    <AIcon type="reload" /> 刷新
                    </AButton>
                : null,
            this.$p('/processdefs:POST') ?
                <IiModal
                    title="新建流程"
                    content={<ncform formName='_addProcessdefForm' formSchema={this.schema} vModel={this.newItem} />}
                    button={
                        <AButton style={{ marginRight: '8px' }} slot="extra" size='small' key="add">
                            <AIcon type="plus" /> 创建流程
                            </AButton>
                    }
                    ok={this.onAddOk}
                    cancel={this.onEditCancel}
                    clearFloat={true} />
                : null
        ]
        return (
            <div class='ii-processdef-definitions'>
                <IiTableLayout
                    rowKey='processDefinitionKey'
                    rowSelection={{ type: 'radio', selectedRowKeys: [this.editItem ? this.editItem.processDefinitionKey : undefined] }}
                    size='small'
                    headheight={68}
                    controls={controls}
                    total={this.total}
                    pageSize={this.limit}
                    currentPage={this.page}
                    showSizeChanger={true}
                    onShowSizeChange={this.onLimitChange}
                    onPaginationChange={this.onPageChange}
                    pageSizeOptions={pageSizeOptions}
                    onRowClick={this.onClick}
                    class={'table'}
                    showPagination='both'
                    columns={columns}
                    rows={this.items}>
                </IiTableLayout>
                {
                    this.editItem ?
                        <AModal
                            title="修改流程"
                            key={'editProcessdef'}
                            visible={this.showEdit}
                            closable={true}
                            onOk={this.onEditOk}
                            onCancel={this.onEditCancel}>
                            <ncform formName='_editProcessdefForm' formSchema={this.schema} vModel={this.editValue} />
                        </AModal>
                        : null
                }
                {
                    this.editItem ?
                        <AModal
                            wrapClassName='ii-modeler-wrap'
                            title={<div class='ii-card-head'><IiIcon type='antv-share-alt' /><span>修改流程模型</span></div>}
                            key={'editBpmn'}
                            visible={this.showBpmnModal}
                            closable={true}
                            maskClosable={false}
                            footer={null}
                            centered={true}
                            onCancel={this.onEditBpmnCancel}>
                            <ii-bpmn-modeler bpmnXML={this.editItem.bpmnXML || createBpmnXML(this.editItem.processDefinitionKey)}
                                processId={this.editItem.processDefinitionKey}
                                onSave={this.onSaveBpmn}
                                on={{ ['save-error']: () => { message.error('流程定义不完整，请检查') } }} s />
                        </AModal>
                        : null
                }
                {
                    this.editItem ?
                        <AModal
                            wrapClassName='ii-modeler-wrap ii-modeler-with-footer-wrap'
                            title={<div class='ii-card-head'><IiIcon type='antv-table' /><span>修改表单</span></div>}
                            key={'editForm'}
                            visible={this.showFormModal}
                            closable={true}
                            maskClosable={false}
                            centered={true}
                            footer={null}
                            onCancel={this.onEditFormCancel}>
                            <ii-form-editor schema={this.editItem.formDef} onCancel={this.onEditFormCancel} onOk={this.onSaveForm} />
                        </AModal>
                        : null
                }
            </div>
        )
    }
}
</script>
<style lang="stylus">
.ii-modeler-wrap {
    overflow: hidden;

    .ant-modal {
        width: 95% !important;
        height: 90%;
        top: 0;
        padding: 0;

        .ant-modal-content {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;

            .ant-modal-body {
                width: 100%;
                height: calc(100% - 55px);
                margin: 0;
                padding: 0;
            }
        }
    }
}
</style>

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

.ii-processdef-definitions {
    height: 100%;
    width: 100%;
    overprocessdef: hidden;
}
</style>