import Signin from './view/Signin'
import UserProfile from './view/UserProfile'
import { TrySigninInterceptor } from '../../../framework/mixins'

export default (opts) => {
    const signin = opts.signin || {}
    const containerId = opts.containerId
    return {
        iota: {
            app: {
                signin: {
                    path: 'signin',
                    component: {
                        mixins: [
                            TrySigninInterceptor,
                            Signin
                        ]
                    },
                    props: {
                        redirect: signin.redirect
                    }
                }
            },
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
