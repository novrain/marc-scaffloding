<script>
import { Menu as AMenu } from 'ant-design-vue'
import { convertArrayToTree } from '@iota-cn/ui-scaffolding/src/framework/util'

const VIRTUAl_ROOT = 'virtual-root'

export default {
    props: ['flowId', 'flowFuncs'],
    data() {
        const wrappderFlowFuncs = Object.assign({}, this.flowFuncs)
        return {
            categories: [],
            selectedKeys: [],
            currentEditNode: {},
            rightClickNodeTreeItem: {},
            addNode: false,
            propEditNode: false,
            wrappderFlowFuncs: wrappderFlowFuncs
        }
    },
    mounted() {
        this.refetch()
    },
    methods: {
        refetch() {
            this.$axios.silentGet(`/v1/api/communist_party/processes/categories`, true)
                .then(res => {
                    this.categories = res.data.categories
                    // 如果选择的key不存在，则触发刷新
                    if (this.selectedKeys === 1 && this.selectedKeys[0] !== VIRTUAl_ROOT && !this.categories.find(c => {
                        return c.id === this.selectedKeys[0]
                    })) {
                        this.selectedKeys = []
                    }
                    this.currentEditNode = {}
                }).catch(() => { })
        },
        handleHoverOff() {
            this.rightClickNodeTreeItem = {}
        },
        treeNodeonRightClick(e) {
            this.rightClickNodeTreeItem = {
                pageX: e.event.pageX,
                pageY: e.event.pageY,
                id: e.node.eventKey,
                categoryName: e.node.title
            }
            // this.selectedKeys = [e.node.eventKey]
            this.currentEditNode = e.node
        },
        isEmpty(obj) {
            for (let key in obj) {
                return false;
            }
            return true;
        },
        getNodeTreeRightClickMenu() {
            const { pageX, pageY } = { ...this.rightClickNodeTreeItem }
            const tmpStyle = {
                position: 'absolute',
                left: `${pageX - 180}px`,
                top: `${pageY - 50}px`,
                backgroundColor: '#fffa2'
            }
            const menu = (
                <div {...{ on: { mouseleave: this.handleHoverOff } }}>
                    <AMenu
                        class='rightMenu'
                        onClick={this.handleMenuClick}
                        style={tmpStyle}
                    >
                        <AMenu.Item key='addChildNode'><AIcon type='plus-circle-o' />{'增加子分类'}</AMenu.Item>
                        {this.rightClickNodeTreeItem.id === VIRTUAl_ROOT ? null : <AMenu.Item key='editNode'><AIcon type='edit' />{'编辑'}</AMenu.Item>}
                        {this.rightClickNodeTreeItem.id === VIRTUAl_ROOT ? null : <AMenu.Item key='delConfirm'><AIcon type='minus-circle-o' />{'删除'}</AMenu.Item>}
                    </AMenu>
                </div>
            )
            return (this.isEmpty(this.rightClickNodeTreeItem)) ? '' : menu
        },
        handleMenuClick(e) {
            this[`${e.key}`]()
            this.rightClickNodeTreeItem = {}
        },
        addChildNode() {
            this.addNode = true
        },
        editNode() {
            this.propEditNode = true
        },
        delConfirm() {
            const that = this
            this.$confirm({
                title: '确认删除此分类？',
                content: `${this.currentEditNode.title}`,
                onOk() {
                    that.delNode()
                },
                onCancel() { },
            })
        },
        delNode() {
            return this.$axios.silentDelete(`/v1/api/communist_party/processes/categories/${this.currentEditNode.eventKey}`, true)
                .then(() => {
                    this.refetch()
                    return true
                })
                .catch(() => {
                    return true
                })
        },
        onAddOk() {
            this.addNode = false
            return new Promise((resolve, reject) => {
                this.$refs._addForm.validateFieldsAndScroll((err, values) => {
                    if (!err) {
                        resolve(true)
                        values.parentId = this.currentEditNode.eventKey
                        if (values.parentId === VIRTUAl_ROOT) {
                            delete values.parentId
                        }
                        this.$axios.silentPost(`/v1/api/communist_party/processes/categories`, values, true)
                            .then(() => {
                                this.$refs._addForm.resetFields()
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
        onEditOk() {
            this.propEditNode = false
            return new Promise((resolve, reject) => {
                this.$refs._editForm.validateFieldsAndScroll((err, values) => {
                    if (!err) {
                        resolve(true)
                        this.$axios.silentPut(`/v1/api/communist_party/processes/categories/${this.currentEditNode.eventKey}`, values, true)
                            .then(() => {
                                this.$refs._editForm.resetFields()
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
        onAddCancel() {
            this.addNode = false
        },
        onEditCancel() {
            this.propEditNode = false
        },
        onTreeSelect(selectedKeys, e) {
            this.selectedKeys = selectedKeys
            this.currentEditNode = e.node
        },
    },
    watch: {
        selectedKeys: {
            handler() {
                if (this.flowFuncs && this.selectedKeys.length === 1) {
                    let categories = []
                    let key = this.selectedKeys[0]
                    if (key !== VIRTUAl_ROOT) {
                        let idMap = this.tree.idMap
                        let node = idMap[key]
                        categories.push(node)
                        while (node && node.parentId !== VIRTUAl_ROOT) {
                            node = idMap[node.parentId]
                            if (node) {
                                categories.push(node)
                            }
                        }
                    }
                    //扩展query，传递自定义参数
                    if (this.flowFuncs.query) {
                        const oldQuery = this.flowFuncs.query
                        let query = function (opts) {
                            opts.categories = categories
                            return oldQuery(opts)
                        }
                        this.wrappderFlowFuncs = Object.assign({}, this.wrappderFlowFuncs, { query: query })
                    }
                    if (this.flowFuncs.create) {
                        const oldCreate = this.flowFuncs.create
                        let create = function (opts) {
                            opts.categories = categories
                            return oldCreate(opts)
                        }
                        this.wrappderFlowFuncs = Object.assign({}, this.wrappderFlowFuncs, { create: create })
                    }
                }
            }
        }
    },
    computed: {
        tree() {
            let converted = convertArrayToTree(this.categories.map(c => {
                if (!c.parentId) {
                    c.parentId = VIRTUAl_ROOT
                }
                return c
            }).concat({
                name: '所有分类',
                id: VIRTUAl_ROOT,
                parentId: null
            }))
            return converted
        }
    },
    render() {
        let tree = this.tree.roots
        return (
            <a-row class="ii-row"
                gutter={16}>
                <a-col class="col"
                    span={4}>
                    <a-card title="任务分类"
                        bordered={false}
                        bodyStyle={{ padding: '2px', overflow: 'scroll', height: '100%' }}
                        class='ii-card'>
                        <div class='categories'>
                            <div class='operation'>
                                <AButton style={{ marginRight: '8px' }} size='small' key="refresh" onClick={this.refetch}>
                                    <AIcon type="reload" /> 刷新
                            </AButton>
                                <AButton style={{ marginRight: '8px' }} size='small' key="new" onClick={this.addChildNode}>
                                    <AIcon type="plus" /> 创建分类
                            </AButton>
                            </div>
                            {
                                tree.length > 0 ? <IiArrayTree
                                    tree={tree}
                                    onSelect={this.onTreeSelect}
                                    selectedKeys={this.selectedKeys}
                                    onRightClick={this.treeNodeonRightClick}
                                /> : null
                            }
                        </div>
                        <AModal
                            title="增加分类"
                            key={'addNode'}
                            visible={this.addNode}
                            onOk={this.onAddOk}
                            onCancel={this.onAddCancel}>
                            <Form_IiSimpleEditor ref={'_addForm'} data={{}} disableDesc />
                        </AModal>
                        <AModal
                            title="编辑分类"
                            key={'editNode'}
                            visible={this.propEditNode}
                            onOk={this.onEditOk}
                            onCancel={this.onEditCancel}>
                            <Form_IiSimpleEditor ref={'_editForm'} data={{ name: this.currentEditNode ? this.currentEditNode.title : '' }} disableDesc />
                        </AModal>
                    </a-card>
                </a-col>
                <a-col class="col"
                    span={20}>
                    <ii-flowable flowId={this.flowId} flowFuncs={this.wrappderFlowFuncs} />
                </a-col>
                {this.getNodeTreeRightClickMenu()}
            </a-row>
        )
    }
}
</script>

<style lang="stylus" scoped>
@import '~@iota-cn/ui-scaffolding/src/styles/imports';

.ii-row {
    width: 100%;
    height: 100%;
    overflow: hidden;

    .rightMenu {
        box-shadow: $ii-box-shadow;
    }

    .col {
        height: 100%;
    }

    .ii-card {
        height: 100%;
        width: 100%;
        overflow: hidden;
        background-color: white;
        display: flex;
        flex-direction: column;
    }

    .categories {
        height: 100%;
        width: 100%;
        display: flex;
        flex-direction: column;

        .operation {
            margin: 10px 10px 0 10px;
        }
    }
}
</style>>