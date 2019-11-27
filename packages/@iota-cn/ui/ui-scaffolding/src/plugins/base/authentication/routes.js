import Signin from './view/Signin'
import RequireRestPassword from './view/RequireResetPassword'
import RequireRestPasswordError from './view/RequireResetPasswordError'
import RequireRestPasswordSuccess from './view/RequireResetPasswordSuccess'
import RestPassword from './view/ResetPassword'
import RestPasswordError from './view/ResetPasswordError'
import RestPasswordSuccess from './view/ResetPasswordSuccess'
import EmailActivateSuccess from './view/EmailActivateSuccess'
import EmailActivateError from './view/EmailActivateError'
// import UserProfile from './view/UserProfile'
import { TrySigninInterceptor } from '../../../framework/mixins'

export default (opts) => {
    const signin = opts.signin || {}
    // const containerId = opts.containerId
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
                },
                requireRestPwd: {
                    path: 'reset/send/email',
                    component: {
                        mixins: [RequireRestPassword]
                    }
                },
                requireRestPwdError: {
                    path: 'reset/send/email/error',
                    component: {
                        mixins: [RequireRestPasswordError]
                    }
                },
                requireRestPwdSuccess: {
                    path: 'reset/send/email/success',
                    component: {
                        mixins: [RequireRestPasswordSuccess]
                    }
                },
                restPwd: {
                    path: 'reset/password',
                    component: {
                        mixins: [RestPassword]
                    }
                },
                restPwdError: {
                    path: 'reset/password/error',
                    component: {
                        mixins: [RestPasswordError]
                    }
                },
                restPwdSuccess: {
                    path: 'reset/password/success',
                    component: {
                        mixins: [RestPasswordSuccess]
                    }
                },
                emailActivateSuccess: {
                    path: 'email/activation/success',
                    component: {
                        mixins: [EmailActivateSuccess]
                    }
                },
                emailActivateError: {
                    path: 'email/activation/error',
                    component: {
                        mixins: [EmailActivateError]
                    }
                },
                // [containerId || 'container']: {
                //     authentication: {
                //         profile: {
                //             path: '/console/account/profile',
                //             component: {
                //                 mixins: [UserProfile]
                //             }
                //         }
                //     }
                // }
            }
        }
    }
}
