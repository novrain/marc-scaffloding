import UserProfile from './view/UserProfile'

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
                }
            }
        }
    }
}
