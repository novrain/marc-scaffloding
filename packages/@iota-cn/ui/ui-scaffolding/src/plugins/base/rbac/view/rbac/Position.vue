<script>
import { Menu as AMenu } from 'ant-design-vue'
import * as U from '../../util'

import UserOfPosition from './UserOfPosition'
import RoleOfPosition from './RoleOfPosition'

export default {
    name: 'IiRBACPosition',
    props: [],
    data() {
        return {
            positions: [],
            selectedKeys: [],
            currentEditNode: {},
            rightClickNodeTreeItem: {},
            addNode: false,
            propEditNode: false
        }
    },

    mounted() {
        this.refetch()
    },

    methods: {
        isEmpty(obj) {
            for (let key in obj) {
                return false;
            }
            return true;
        },

        refetch() {
            this.$axios.silentGet(`/v1/api/authorizations/positions`, true)
                .then(res => {
                    this.positions = res.data.positions
                    // 其实只有一个key
                    let keys = []
                    this.selectedKeys.forEach(k => {
                        if (this.positions.find(c => {
                            return c.id === k
                        })) {
                            keys.push(k)
                        }
                    })
                    this.selectedKeys = keys
                    this.currentEditNode = {}
                }).catch(() => { })
        },

        handleHoverOff() {
            this.rightClickNodeTreeItem = {}
        },

        hasRight(key) {
            let has = false
            this.positions.map(item => {
                if (item.id === key) {
                    has = item.hasRight !== undefined ? item.hasRight : false
                }
            })
            return has
        },

        hasAuthOfAddNode(key) {
            let has = true
            this.positions.map(item => {
                if (item.id === key) {
                    if (item.assigned === undefined && item.hasRight === undefined) {
                        has = false
                    }
                }
            })
            return has
        },

        treeNodeonRightClick(e) {
            this.rightClickNodeTreeItem = {
                pageX: e.event.pageX,
                pageY: e.event.pageY,
                id: e.node.eventKey,
                categoryName: e.node.title
            }
            this.currentEditNode = e.node
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
                        style={tmpStyle} >
                        {
                            this.$p('/authorizations/positions:POST') && this.hasAuthOfAddNode(this.rightClickNodeTreeItem.id) ?
                                <AMenu.Item key='addChildNode'><AIcon type='plus-circle-o' />{'增加子职位'}</AMenu.Item>
                                : null
                        }
                        {
                            this.$p('/authorizations/positions/:id:PUT') && this.hasRight(this.rightClickNodeTreeItem.id) ?
                                <AMenu.Item key='editNode'><AIcon type='edit' />{'编辑'}</AMenu.Item>
                                : null
                        }
                        {
                            this.$p('/authorizations/positions/:id:DELETE') && this.hasRight(this.rightClickNodeTreeItem.id) ?
                                <AMenu.Item key='delConfirm'><AIcon type='minus-circle-o' />{'删除'}</AMenu.Item>
                                : null
                        }
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
                title: '确认删除此职位？',
                content: `${this.currentEditNode.title}`,
                onOk() {
                    that.delNode()
                },
                onCancel() {

                },
            })
        },

        delNode() {
            return this.$axios.silentDelete(`/v1/api/authorizations/positions/${this.currentEditNode.eventKey}`, true)
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
                        this.$axios.silentPost(`/v1/api/authorizations/positions`, values, true)
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
                        this.$axios.silentPut(`/v1/api/authorizations/positions/${this.currentEditNode.eventKey}`, values, true)
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

        renderRelated() {
            const { selectedKeys, positions } = this
            let role = null
            let user = null
            if (selectedKeys.length === 1) {
                const key = selectedKeys[0]
                let position = positions.find(o => o.id === key)
                if (position) {
                    if (position.hasRight) {
                        role = <RoleOfPosition position={key} key={key + 'role'} />
                    }
                    if (position.hasRight || position.assigned) {
                        user = <UserOfPosition position={key} key={key + 'user'} />
                    }
                }
            }
            return <ATabs type="card" class='ii-tabs'>
                <ATabPane tab="角色" key="roles" class='tabpanel'>
                    {role}
                </ATabPane>
                <ATabPane tab="用户" key="users" class='tabpanel'>
                    {user}
                </ATabPane>
            </ATabs>
        }
    },

    render() {
        let tree = this.positions.map((o) => {
            return Object.assign({ selectable: !!o.hasRight || !!o.assigned }, o)
        })
        tree = U.createTree(tree).roots
        return (
            <splitpanes class="default-theme">
                <splitpane size='35' min-size="20" max-size="60">
                    <a-card title={<div class='ii-card-head'><IiIcon type='user-position' /><span>职位管理</span></div>}
                        bordered={false}
                        bodyStyle={{ padding: '2px', overflow: 'auto', height: '100%' }}
                        class='ii-card'>
                        {
                            this.$p('/authorizations/positions:GET') ?
                                <AButton style={{ marginRight: '8px' }} slot='extra' size='small' key="refresh" onClick={this.refetch}>
                                    <AIcon type="reload" /> 刷新
                                    </AButton>
                                : null
                        }
                        {
                            this.$p('/authorizations/positions:POST') ?
                                <AButton style={{ marginRight: '8px' }} slot='extra' size='small' key="new" onClick={this.addChildNode}>
                                    <AIcon type="plus" /> 创建职位
                                    </AButton>
                                : null
                        }
                        {
                            tree.length > 0 ? <IiArrayTree
                                tree={tree}
                                onSelect={this.onTreeSelect}
                                selectedKeys={this.selectedKeys}
                                onRightClick={this.treeNodeonRightClick}
                            /> : null
                        }
                        <AModal
                            title="增加职位"
                            key={'addNode'}
                            visible={this.addNode}
                            onOk={this.onAddOk}
                            onCancel={this.onAddCancel}>
                            <Form_IiSimpleEditor ref={'_addForm'} data={{}} disableDesc />
                        </AModal>
                        <AModal
                            title="编辑职位"
                            key={'propEditNode'}
                            visible={this.propEditNode}
                            onOk={this.onEditOk}
                            onCancel={this.onEditCancel}>
                            <Form_IiSimpleEditor ref={'_editForm'} data={{ name: this.currentEditNode ? this.currentEditNode.title : '' }} disableDesc />
                        </AModal>
                    </a-card>
                </splitpane>
                <splitpane size='65' style={{ flex: 1 }}>
                    {this.renderRelated()}
                </splitpane>
                {this.getNodeTreeRightClickMenu()}
            </splitpanes>
        )
    }
}
</script>

<style lang="stylus" scoped>
@import '../../../../../styles/imports';

.rightMenu {
    box-shadow: $ii-box-shadow;
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
</style>