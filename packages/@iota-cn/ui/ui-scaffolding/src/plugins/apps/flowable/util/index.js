/**
 * 用户ID，保存用户ID/用户名/用户显示名至flowable，暂不考虑名称变化的一致性
 * @param {*} user 
 */
export const idOfUser = (user) => {
    return `u:${user.id}:${user.username}:${user.fullname || ''}`
}

/**
 * 用于查询，利用flowable的 assigneeLike 功能
 * @param {*} user 
 */
export const idOfQueryUser = (user) => {
    return `u:${user.id}:`
}

/**
 * 反解析 assginee 到 User
 * @param {*} assignee 
 */
export const parseAssignee = (assignee) => {
    if (assignee) {
        const splited = assignee.split(':')
        return {
            id: splited[1],
            username: splited[2],
            fullname: splited[3]
        }
    } else {
        return {}
    }
}
const parser = (comboId) => {
    if (comboId) {
        const splited = comboId.split(':')
        return {
            id: splited[1],
            name: splited[2]
        }
    } else {
        return {}
    }
}

/**
 * Role/Organization/Position
 * @param {*} comboId 
 */
export const parseGroup = (group) => {
    return parser(group)
}

export const idOfRole = (role) => {
    return `r:${role.id}:${role.name}`
}

export const idOfOrganization = (organization) => {
    return `o:${organization.id}:${organization.name}`
}

export const idOfPosition = (position) => {
    return `o:${position.id}:${position.name}`
}

export const idOfQueryRole = (role) => {
    return `r:${role.id}:`
}

export const idOfQueryOrganization = (organization) => {
    return `o:${organization.id}:`
}

export const idOfQueryPosition = (position) => {
    return `p:${position.id}:`
}

export const isCandidate = ({ task, user, assignedOrganizations, assignedPositions, assignedRoles }) => {
    if (user.isAdmin) {
        return true
    }
    const candidateUsers = task.identityLinks.filter(link => {
        return link.type === 'candidate' && link.user
    })
    const candidateGroups = task.identityLinks.filter(link => {
        return link.type === 'candidate' && link.group
    })
    const uid = idOfQueryUser(user)
    return (candidateUsers.length > 0 && candidateUsers.find(c => {
        return c.user.indexOf(uid) === 0
    })) || (candidateGroups.length > 0 && candidateGroups.find(c => {
        return [...assignedOrganizations, ...assignedPositions, ...assignedRoles].find(a => {
            return c.group.indexOf(idOfQueryOrganization(a)) === 0
                || c.group.indexOf(idOfQueryPosition(a)) === 0
                || c.group.indexOf(idOfQueryRole(a)) === 0
        })
    }))
}

export const isTaskClaimable = ({ task, user, assignedOrganizations, assignedPositions, assignedRoles }) => {
    if (task.assignee && task.assignee.id) {
        return false
    }
    return isCandidate({ task, user, assignedOrganizations, assignedPositions, assignedRoles })
}

// export const isTaskAssigneeable = ({ task, user }) => {
export const isTaskAssigneeable = () => {
    return true
}