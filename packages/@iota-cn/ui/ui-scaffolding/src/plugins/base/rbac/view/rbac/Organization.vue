<script>
import classNames from 'classnames'
import { Menu as AMenu } from 'ant-design-vue'
import { AuthTree } from '../../components'
import * as U from '../../util'

import UserOfOrganization from './UserOfOrganization'
import RoleOfOrganization from './RoleOfOrganization'

export default {
    props: [],
    data() {
        return {
            organizations: [],
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
            this.$axios.silentGet(`/v1/api/authorizations/organizations`, true)
                .then(res => {
                    this.organizations = res.data.organizations
                    this.selectedKeys = []
                    this.selectedNode = {}
                }).catch(() => { })
        },

        handleHoverOff() {
            this.rightClickNodeTreeItem = {}
        },

        hasRight(key) {
            let has = false
            this.organizations.map(item => {
                if (item.id === key) {
                    has = item.hasRight !== undefined ? item.hasRight : false
                }
            })
            return has
        },

        hasAuthOfAddNode(key) {
            let has = true
            this.organizations.map(item => {
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
                        onClick={this.handleMenuClick}
                        style={tmpStyle}
                    //class={style.categs_tree_rightmenu}
                    >
                        {this.hasAuthOfAddNode(this.rightClickNodeTreeItem.id) ? <AMenu.Item key='addChildNode'><AIcon type='plus-circle-o' />{'增加子组织'}</AMenu.Item> : null}
                        {this.hasRight(this.rightClickNodeTreeItem.id) ? <AMenu.Item key='propEditNode'><AIcon type='edit' />{'编辑'}</AMenu.Item> : null}
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
            confirm({
                title: '确认删除此组织？',
                content: `${this.state.selectedNode.props.title}`,
                onOk() {
                    this.delNode()
                },
                onCancel() {

                },
            })
        },

        delNode() {
            return this.$axios.silentDelete(`/v1/api/authorizations/organizations/${this.selectedKeys[0]}`, true)
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
                        this.$axios.silentPost(`/v1/api/authorizations/organizations`, values, true)
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
                        this.$axios.silentPost(`/v1/api/authorizations/organizations/${this.state.selectedKeys[0]}`, values, true)
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
            const { selectedKeys, organizations } = this
            let role = null
            let user = null
            if (selectedKeys.length === 1) {
                const key = selectedKeys[0]
                let organization = organizations.find(o => o.id === key)
                if (organization) {
                    if (organization.hasRight) {
                        role = <RoleOfOrganization organization={key} key={key + 'role'} />
                    }
                    if (organization.hasRight || organization.assigned) {
                        user = <UserOfOrganization organization={key} key={key + 'user'} />
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
        let tree = this.organizations.map((o) => {
            return Object.assign({ selectable: !!o.hasRight || !!o.assigned }, o)
        })
        tree = U.createTree(tree).roots
        return (
            <div style={{ height: '100%', width: '100%', overflow: 'hidden' }}>
                <ARow gutter={16} class={classNames('wrapper__row')}>
                    <ACol span={8} class={classNames('wrapper__row__col')}>
                        {
                            tree.length > 0 ? <AuthTree
                                tree={tree}
                                onSelect={this.onTreeSelect}
                                onRightClick={this.treeNodeonRightClick}
                            /> : null
                        }
                        {this.getNodeTreeRightClickMenu()}
                        <AModal
                            title="增加组织"
                            key={'addNode'}
                            visible={this.addNode}
                            onOk={this.onAddOk}
                            onCancel={this.onAddCancel}>
                            <Form_IiSimpleEditor ref={'_addForm'} data={{}} disableDesc />
                        </AModal>
                        <AModal
                            title="编辑组织"
                            key={'propEditNode'}
                            visible={this.propEditNode}
                            onOk={this.onEditOk}
                            onCancel={this.onEditCancel}>
                            <Form_IiSimpleEditor ref={'_editForm'} data={{ name: this.selectedNode.props ? this.selectedNode.props.title : '' }} disableDesc />
                        </AModal>
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