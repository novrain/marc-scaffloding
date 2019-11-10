<script>
import { AuthTree } from '../../components'
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
            <div style={{ height: '100%', width: '100%', overflow: 'hidden' }}>
                <ARow gutter={16} type='flex' justify='center' style={{ height: '100%' }}>
                    <ACol span={12} style={{ height: '100%' }}>
                        <a-card title="我的菜单"
                            bodyStyle={{ padding: "2px" }}
                            style={{ height: '100%', width: '100%', overflow: 'hidden', backgroundColor: 'white' }}>
                            {this.menus.length > 0 ? <AuthTree tree={this.menus} /> : null}
                        </a-card>
                    </ACol>
                    <ACol span={12} style={{ height: '100%' }}>
                        <a-card title="我的操作"
                            bodyStyle={{ padding: "2px" }}
                            style={{ height: '100%', width: '100%', overflow: 'hidden', backgroundColor: 'white' }}>
                            {this.operations.length > 0 ? <AuthTree tree={this.operations} /> : null}
                        </a-card>
                    </ACol>
                </ARow>
            </div>
        )
    }
}
</script>

<style>
</style>