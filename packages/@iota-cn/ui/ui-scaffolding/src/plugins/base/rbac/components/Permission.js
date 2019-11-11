const createPermission = (opts) => {
    const containerId = opts.containerId
    const id = opts.id
    return function (Vue) {
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