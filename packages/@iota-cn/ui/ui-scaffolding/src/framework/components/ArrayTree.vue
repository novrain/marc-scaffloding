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
        'tree'
    ],
    methods: {
        renderTree(tree) {
            return tree.map(item => {
                if (!item.children) {
                    return (
                        <ATreeNode icon={item.icon ? <ii-icon type='item.icon' /> : undefined}
                            title={item.name} key={item.id} data-key={item.id}
                            data-title={item.categoryName} disableCheckbox={item.disableCheckbox} disabled={item.disabled}
                            selectable={item.selectable !== undefined ? item.selectable : true} />
                    );
                } else {
                    return (
                        <ATreeNode icon={item.icon ? <ii-icon type='item.icon' /> : undefined}
                            title={item.name} key={item.id} data-key={item.id}
                            data-title={item.categoryName} disableCheckbox={item.disableCheckbox} disabled={item.disabled}
                            selectable={item.selectable !== undefined ? item.selectable : true}>
                            {this.renderTree(item.children)}
                        </ATreeNode>
                    );
                }
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
            <div style={{ height: '100%', overflow: 'auto', padding: '16px', userSelect: 'none', backgroundColor: 'white' }} >
                <ATree
                    style={{ height: 300 }}
                    defaultExpandAll
                    showLine
                    checkStrictly={this.checkStrictly}
                    checkable={this.checkable}
                    checkedKeys={this.checkedKeys}
                    onCheck={this.onEvent('check')}
                    onSelect={this.onEvent('select')}
                    onRightClick={this.onEvent('rightClick')}
                >
                    {this.renderTree(this.tree)}
                </ATree>
            </div>
        );
    }
}
</script>

<style>
</style>