<script>
import * as U from '../../util'

export default {
    name: 'IiRBACOverview',
    data() {
        return {
            menus: [],
            operations: []
        }
    },

    mounted() {
        this.$axios.silentGet('/v1/api/authorizations/menus', true)
            .then((res) => {
                this.menus = U.createTree(res.data.menus).roots
            }).catch((err) => { console.log(err) })

        this.$axios.silentGet('/v1/api/authorizations/operations', true)
            .then((res) => {
                this.operations = U.createTree(res.data.operations).roots
            }).catch((err) => { console.log(err) })
    },
    render() {
        return (
            <splitpanes class="default-theme">
                <splitpane size='50' min-size="20" max-size="80">
                    <ii-card title='我的菜单'>
                        <IiIcon type='menu' slot='slot' />
                        {this.menus.length > 0 ? <IiArrayTree tree={this.menus} /> : null}
                    </ii-card>
                </splitpane>
                <splitpane size='50' style={{ flex: 1 }}>
                    <ii-card title='我的操作'>
                        <IiIcon type='menu' slot='icon' />
                        {this.operations.length > 0 ? <IiArrayTree tree={this.operations} /> : null}
                    </ii-card>
                </splitpane>
            </splitpanes>
        )
    }
}
</script>

<style lang="stylus" scoped>
@import '../../../../../styles/imports';
</style>