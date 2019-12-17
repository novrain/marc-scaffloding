<script>
import * as U from '../../util'

export default {
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
                    <a-card title={<div class='ii-card-head'><IiIcon type='menu' /><span>我的菜单</span></div>}
                        bordered={false}
                        bodyStyle={{ padding: '2px', overflow: 'auto', height: '100%' }}
                        class='ii-card'>
                        {this.menus.length > 0 ? <IiArrayTree tree={this.menus} /> : null}
                    </a-card>
                </splitpane>
                <splitpane size='50' style={{ flex: 1 }}>
                    <a-card title={<div class='ii-card-head'><IiIcon type='menu' /><span>我的操作</span></div>}
                        bordered={false}
                        bodyStyle={{ padding: '2px', overflow: 'auto', height: '100%' }}
                        class='ii-card'>
                        {this.operations.length > 0 ? <IiArrayTree tree={this.operations} /> : null}
                    </a-card>
                </splitpane>
            </splitpanes>
        )
    }
}
</script>

<style lang="stylus" scoped>
@import '../../../../../styles/imports';

.ii-card {
    height: 100%;
    width: 100%;
    overflow: hidden;
    background-color: white;
    display: flex;
    flex-direction: column;
}
</style>