import { RBAC, reset } from '../constants'

const createPermission = (opts) => {
    const containerId = opts.containerId
    const id = opts.id
    return function (Vue) {
        // 提供全局获取RBAC相关数据的接口
        // 退出登录时最好重置
        // Vue 的上下文，只能使用单层函数方式，使用对象，对象函数无法访问到Vue 上下文
        // Vue.prototype.$rbac = RBAC
        // hasRight
        Vue.prototype.$fetchUsers = async function () {
            return RBAC.hasRight.users ||
                this.$axios.silentGet('/v1/api/authorizations/users', true).then((res) => {
                    RBAC.hasRight.users = res.data.uesrs
                    return RBAC.hasRight.users
                }).catch(() => {
                    return []
                })
        }
        Vue.prototype.$fetchRoles = async function () {
            return RBAC.hasRight.roles ||
                this.$axios.silentGet('/v1/api/authorizations/roles', true).then((res) => {
                    RBAC.hasRight.roles = res.data.roles
                    return RBAC.hasRight.roles
                }).catch(() => {
                    return []
                })
        }
        Vue.prototype.$fetchOrganizations = async function () {
            return RBAC.hasRight.organizations ||
                this.$axios.silentGet('/v1/api/authorizations/organizations', true).then((res) => {
                    RBAC.hasRight.organizations = res.data.organizations
                    return RBAC.hasRight.organizations
                }).catch(() => {
                    return []
                })
        }
        Vue.prototype.$fetchPositions = async function () {
            return RBAC.hasRight.positions ||
                this.$axios.silentGet('/v1/api/authorizations/positions', true).then((res) => {
                    RBAC.hasRight.positions = res.data.positions
                    return RBAC.hasRight.positions
                }).catch(() => {
                    return []
                })
        }
        // assgined
        Vue.prototype.$fetchAssignedRoles = async function () {
            return RBAC.assigned.roles ||
                this.$axios.silentGet('/v1/api/authorizations/assigned_roles', true).then((res) => {
                    RBAC.assigned.roles = res.data.roles
                    return RBAC.assigned.roles
                }).catch(() => {
                    return []
                })
        }
        Vue.prototype.$fetchAssignedOrganizations = async function () {
            return RBAC.assigned.organizations ||
                this.$axios.silentGet('/v1/api/authorizations/assigned_organizations', true).then((res) => {
                    RBAC.assigned.organizations = res.data.organizations
                    return RBAC.assigned.organizations
                }).catch(() => {
                    return []
                })
        }
        Vue.prototype.$fetchAssignedPositions = async function () {
            return RBAC.assigned.positions ||
                this.$axios.silentGet('/v1/api/authorizations/assigned_positions', true).then((res) => {
                    RBAC.assigned.positions = res.data.positions
                    return RBAC.assigned.positions
                }).catch(() => {
                    return []
                })
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
        Vue.prototype.$clearRBACInfo = function () {
            reset()
        }
    }
}

export default createPermission