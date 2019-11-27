<script>
import * as TU from '../util'
import * as U from '../../../../framework/util'

export default {
    name: 'IiAuthCheckStrictlyTree',
    props: ['target', 'sourceUrlKey', 'targetUrlKey', 'resultKey', 'disableUserAssigned'],
    data() {
        return {
            assignedNodes: [],
            allNodes: [],
            checkedKeys: [],
            tree: []
        }
    },
    mounted() {
        this.refetchAllNodes()
    },
    watch: {
        $props: {
            handler() {
                this.refetchAssignedNodes()
            },
            deep: true,
            immediate: true,
        }
    },
    methods: {
        refetchAllNodes() {
            this.$axios.silentGet(`/v1/api/authorizations/${this.sourceUrlKey}`, true)
                .then((res) => {
                    this.allNodes = res.data[this.resultKey]
                    this.refetchAssignedNodes()
                }).catch(() => { })
        },

        refetchAssignedNodes() {
            if (this.target) {
                const targetId = this.target.id
                this.$axios.silentGet(`/v1/api/authorizations/${this.targetUrlKey}/${targetId}/${this.sourceUrlKey}`, true)
                    .then((res) => {
                        this.assignedNodes = res.data[this.resultKey]
                        this.refreshTree()
                    }).catch(() => { })
            } else {
                this.assignedNodes = []
            }
        },

        onCheck(checkedKeys, e) {
            const { checkStrictly, target, targetUrlKey, sourceUrlKey } = this
            let checked = checkStrictly ? checkedKeys.checked : checkedKeys
            checked = U.uniqueArray(checked)
            if (target) {
                const targetId = target.id
                let ids = [e.node.eventKey]
                if (!checkStrictly) {//
                    if (e.checked) {
                        ids = checked
                    } else {
                        checked = checked.filter(c => c !== e.node.eventKey)
                        ids = this.checkedKeys.filter((k) => checked.indexOf(k) === -1)
                    }
                }
                if (e.checked) {
                    this.$axios.silentPost(`/v1/api/authorizations/${targetUrlKey}/${targetId}/${sourceUrlKey}`, {
                        ids: ids
                    }, true)
                        .then(() => {
                            this.checkedKeys = checked
                        }).catch(() => { })
                } else {
                    this.$axios.silentDelete(`/v1/api/authorizations/${targetUrlKey}/${targetId}/${sourceUrlKey}?ids=${ids.join(',')}`, true)
                        .then(() => {
                            this.checkedKeys = checked
                        }).catch(() => { })
                }
            } else {
                this.checkedKeys = checked
            }
        },

        refreshTree() {
            const { allNodes, assignedNodes, checkStrictly, disableUserAssigned } = this
            //组织 · 标记 · 创建树
            let tree = allNodes || []
            let idIndexMap = {}
            let checkedKeys = []
            tree = tree.map((o, i) => {
                idIndexMap[o.id] = i
                return Object.assign({ disabled: !(o.hasRight || (!disableUserAssigned && o.assigned)), selectable: false }, o)
            })
            if (assignedNodes) {
                assignedNodes.forEach(o => {
                    if (o.assigned && idIndexMap[o.id] !== undefined) {
                        tree[idIndexMap[o.id]].disabled = false
                        tree[idIndexMap[o.id]].selectable = true
                        checkedKeys.push(o.id)
                    }
                })
            }
            tree = TU.createTree(tree)
            if (!checkStrictly) {
                // filter halfchecked node
                checkedKeys = checkedKeys.filter(k => {
                    const n = tree.idMap[k]
                    if (!n) {
                        return false
                    }
                    return n.children.every(c => checkedKeys.indexOf(c.id) !== -1) // every k and c.key must not confilct.
                })
            }
            this.tree = tree.roots
            this.checkedKeys = checkedKeys
        }
    },

    render() {
        let { tree, checkedKeys, checkStrictly, target } = this
        const checkable = !!target
        if (checkStrictly) {
            checkedKeys = {
                checked: checkedKeys,
                halfChecked: []
            }
        }
        return tree.length > 0 ? <IiArrayTree tree={tree} checkable={checkable} onCheck={this.onCheck} checkedKeys={checkedKeys} checkStrictly={checkStrictly} /> : null
    }
}
</script>

<style>
</style>