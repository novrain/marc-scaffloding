const UserProfile = () => import('./view/profile/UserProfile')
const Overview = () => import('./view/rbac/Overview')
const User = () => import('./view/rbac/User')
const Role = () => import('./view/rbac/Role')
const Position = () => import('./view/rbac/Position')
const Organization = () => import('./view/rbac/Organization')

export default (opts) => {
    const containerId = opts.containerId
    return {
        iota: {
            [containerId || 'container']: {
                authentication: {
                    profile: {
                        path: '/console/account/profile',
                        component: UserProfile
                    }
                },
                authorizations: { // rbac
                    overview: {
                        path: '/console/authorizations/overview',
                        component: Overview
                    },
                    users: {
                        path: '/console/authorizations/users',
                        component: User
                    },
                    roles: {
                        path: '/console/authorizations/roles',
                        component: Role
                    },
                    positions: {
                        path: '/console/authorizations/positions',
                        component: Position
                    },
                    organizations: {
                        path: '/console/authorizations/organizations',
                        component: Organization
                    }
                }
            }
        }
    }
}
