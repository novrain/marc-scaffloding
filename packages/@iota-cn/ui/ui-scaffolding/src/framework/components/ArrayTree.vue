<script>
export default {
    name: 'IiArrayTree',
    props: [
        'checkStrictly',
        'checkable',
        'checkedKeys',
        // 'onCheck',
        // 'onSelect',
        // 'onRightClick',
        'selectedKeys',
        'tree',
        'disabled'
    ],
    methods: {
        renderTree(tree) {
            return tree.map(item => {
                return (
                    <ATreeNode icon={item.icon ? <ii-icon type='item.icon' /> : undefined}
                        title={item.name} key={item.id} data-key={item.id}
                        data-title={item.categoryName} disableCheckbox={item.disableCheckbox} disabled={item.disabled}
                        selectable={item.selectable !== undefined ? item.selectable : true}>
                        {item.children ? this.renderTree(item.children) : null}
                    </ATreeNode>
                )
            });
        },
        onEvent(event) {
            let that = this
            return function () {
                that.$emit(event, ...arguments)
            }
        }
    },

    render() {
        return (
            <div style={{ height: '100%', overflow: 'auto', padding: '10px', userSelect: 'none', backgroundColor: 'white' }} >
                <ATree
                    style={{ height: 300 }}
                    defaultExpandAll
                    showLine
                    checkStrictly={this.checkStrictly}
                    checkable={this.checkable}
                    disabled={this.disabled}
                    checkedKeys={this.checkedKeys}
                    selectedKeys={this.selectedKeys}
                    onCheck={this.onEvent('check')}
                    onSelect={this.onEvent('select')}
                    onRightClick={this.onEvent('rightClick')}>
                    {this.renderTree(this.tree)}
                </ATree>
            </div>
        );
    }
}
</script>

<style>
</style>