
// 全局变量必须使用这种方式，考虑是否修改为vuex方式
let RBAC = {
    hasRight: {},
    assigned: {},
    assignedAndChildren: {}
}

const reset = () => {
    RBAC = {
        hasRight: {},
        assigned: {},
        assignedAndChildren: {}
    }
}

export {
    RBAC,
    reset
}