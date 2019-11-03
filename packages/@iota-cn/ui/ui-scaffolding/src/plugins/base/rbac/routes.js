import UserProfile from './view/profile/UserProfile'
import Overview from './view/rbac/Overview'
import User from './view/rbac/User'
import Role from './view/rbac/Role'
import Position from './view/rbac/Position'
import Organization from './view/rbac/Organization'

export default (opts) => {
    const containerId = opts.containerId
    return {
        iota: {
            [containerId || 'container']: {
                authentication: {
                    profile: {
                        path: '/console/account/profile',
                        component: {
                            mixins: [UserProfile]
                        }
                    }
                },
                authorizations: { // rbac
                    overview: {
                        path: '/console/authorizations/overview',
                        component: {
                            mixins: [Overview]
                        }
                    },
                    users: {
                        path: '/console/authorizations/users',
                        component: {
                            mixins: [User]
                        }
                    },
                    roles: {
                        path: '/console/authorizations/roles',
                        component: {
                            mixins: [Role]
                        }
                    },
                    positions: {
                        path: '/console/authorizations/positions',
                        component: {
                            mixins: [Position]
                        }
                    },
                    organizations: {
                        path: '/console/authorizations/organizations',
                        component: {
                            mixins: [Organization]
                        }
                    }
                }
            }
        }
    }
}
