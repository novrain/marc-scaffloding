
// 全局变量必须使用这种方式，考虑是否修改为vuex方式
const RBAC = {}

const createPermission = (opts) => {
    const containerId = opts.containerId
    const id = opts.id
    return function (Vue) {
        // 提供全局获取RBAC相关数据的接口
        // 退出登录时最好重置
        // Vue 的上下文，只能使用单层函数方式，使用对象，对象函数无法访问到Vue 上下文
        // Vue.prototype.$rbac = RBAC
        Vue.prototype.$fetchUsers = async function () {
            if (!RBAC.users) {
                return this.$axios.silentGet('/v1/api/authorizations/users', true).then((res) => {
                    RBAC.users = res.data.uesrs
                    return RBAC.users
                }).catch(() => {
                    return []
                })
            }
        }
        Vue.prototype.$fetchRoles = async function () {
            if (!RBAC.roles) {
                return this.$axios.silentGet('/v1/api/authorizations/roles', true).then((res) => {
                    RBAC.roles = res.data.roles
                    return RBAC.roles
                }).catch(() => {
                    return []
                })
            }
        }
        Vue.prototype.$fetchOrganizations = async function () {
            if (!RBAC.organizations) {
                return this.$axios.silentGet('/v1/api/authorizations/organizations', true).then((res) => {
                    RBAC.organizations = res.data.organizations
                    return RBAC.organizations
                }).catch(() => {
                    return []
                })
            }
        }
        Vue.prototype.$fetchPositions = async function () {
            if (!RBAC.positions) {
                return this.$axios.silentGet('/v1/api/authorizations/positions', true).then((res) => {
                    RBAC.positions = res.data.positions
                    return RBAC.positions
                }).catch(() => {
                    return []
                })
            }
        }

        Vue.prototype.$p = function (operations) {
            const state = this.$store.state.iota[containerId || 'container'][id || 'rbac']
            const haveOps = state.operations || []
            let neededOps = operations
            if (!Array.isArray(neededOps)) {
                neededOps = [neededOps]
            }
            // find op not in operations
            let noRight = neededOps.find(op => {
                return !haveOps.find(oh => {
                    return `${oh.key}:${oh.method || 'GET'}` === op
                })
            })
            return !noRight
        }
    }
}

export default createPermission