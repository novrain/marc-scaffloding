<script>
import classNames from 'classnames'
import { Menu as AMenu } from 'ant-design-vue'
import { AuthTree } from '../../components'
import * as U from '../../util'

import UserOfPosition from './UserOfPosition'
import RoleOfPosition from './RoleOfPosition'

export default {
    props: [],
    data() {
        return {
            positions: [],
            selectedKeys: [],
            selectedNode: {},
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
                    this.selectedKeys = []
                    this.selectedNode = {}
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
            this.selectedKeys = [e.node.eventKey]
            this.selectedNode = e.node
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
                <div onMouseLeave={this.handleHoverOff}>
                    <AMenu
                        class='rightMenu'
                        onClick={this.handleMenuClick}
                        style={tmpStyle}
                    //class={style.categs_tree_rightmenu}
                    >
                        {this.hasAuthOfAddNode(this.rightClickNodeTreeItem.id) ? <AMenu.Item key='addChildNode'><AIcon type='plus-circle-o' />{'增加子职位'}</AMenu.Item> : null}
                        {this.hasRight(this.rightClickNodeTreeItem.id) ? <AMenu.Item key='editNode'><AIcon type='edit' />{'编辑'}</AMenu.Item> : null}
                        {this.hasRight(this.rightClickNodeTreeItem.id) ? <AMenu.Item key='delConfirm'><AIcon type='minus-circle-o' />{'删除'}</AMenu.Item> : null}
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
                content: `${this.selectedNode.title}`,
                onOk() {
                    that.delNode()
                },
                onCancel() {

                },
            })
        },

        delNode() {
            return this.$axios.silentDelete(`/v1/api/authorizations/positions/${this.selectedKeys[0]}`, true)
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
                        values.parentId = this.selectedKeys[0]
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
                        this.$axios.silentPut(`/v1/api/authorizations/positions/${this.selectedKeys[0]}`, values, true)
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
            this.selectedNode = e.node
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
            return <ATabs type="card" style={{
                height: '100%',
                display: 'flex',
                flexDirection: 'column'
            }}>
                <ATabPane tab="角色" key="roles">
                    {role}
                </ATabPane>
                <ATabPane tab="用户" key="users">
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
            <div style={{ height: '100%', width: '100%', overflow: 'hidden' }}>
                <ARow gutter={16} class={classNames('wrapper__row')}>
                    <ACol span={8} class={classNames('wrapper__row__col')}>
                        <a-card title="职位管理"
                            bordered={false}
                            bodyStyle={{ padding: '2px', overflow: 'scroll', height: '100%' }}
                            style={{ height: '100%', width: '100%', overflow: 'hidden', backgroundColor: 'white' }}>
                            <AButton style={{ marginRight: '8px' }} slot='extra' size='small' key="refresh" onClick={this.refetch}>
                                <AIcon type="reload" /> 刷新
                            </AButton>
                            <AButton style={{ marginRight: '8px' }} slot='extra' size='small' key="new" onClick={this.addChildNode}>
                                <AIcon type="plus" /> 创建职位
                            </AButton>
                            {
                                tree.length > 0 ? <AuthTree
                                    tree={tree}
                                    onSelect={this.onTreeSelect}
                                    onRightClick={this.treeNodeonRightClick}
                                /> : null
                            }
                            {this.getNodeTreeRightClickMenu()}
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
                                <Form_IiSimpleEditor ref={'_editForm'} data={{ name: this.selectedNode ? this.selectedNode.title : '' }} disableDesc />
                            </AModal>
                        </a-card>
                    </ACol>
                    <ACol span={16} class={classNames('wrapper__row__col', 'wrapper__row__col_white')}>
                        <div class={classNames('wrapper__row__col__tabs', 'detailCard')}>
                            {this.renderRelated()}
                        </div>
                    </ACol>
                </ARow>
            </div>
        )
    }
}
</script>

<style lang="stylus" scoped>
@import '../../../../../styles/imports';

.rightMenu {
    box-shadow: $ii-box-shadow;
}

.wrapper {
    &__row {
        height: 100% !important;

        &__col {
            height: 100% !important;

            &_white {
                background-color: white;
            }

            &__tabs {
                margin: 10px 0 10px 0;
                background-color: white;

                &__table {
                    padding: 0;
                }
            }
        }
    }
}
</style>