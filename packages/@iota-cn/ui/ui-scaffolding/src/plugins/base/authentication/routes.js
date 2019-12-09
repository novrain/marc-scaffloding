const RequireRestPassword = () => import('./view/RequireResetPassword')
const RequireRestPasswordError = () => import('./view/RequireResetPasswordError')
const RequireRestPasswordSuccess = () => import('./view/RequireResetPasswordSuccess')
const RestPassword = () => import('./view/ResetPassword')
const RestPasswordError = () => import('./view/ResetPasswordError')
const RestPasswordSuccess = () => import('./view/ResetPasswordSuccess')
const EmailActivateSuccess = () => import('./view/EmailActivateSuccess')
const EmailActivateError = () => import('./view/EmailActivateError')
const TrySignin = () => import('./view/TrySignin')

export default (opts) => {
    const signin = opts.signin || {}
    // const containerId = opts.containerId
    return {
        iota: {
            app: {
                signin: {
                    path: 'signin',
                    component: TrySignin,
                    props: {
                        redirect: signin.redirect
                    }
                },
                requireRestPwd: {
                    path: 'reset/send/email',
                    component: RequireRestPassword
                },
                requireRestPwdError: {
                    path: 'reset/send/email/error',
                    component: RequireRestPasswordError
                },
                requireRestPwdSuccess: {
                    path: 'reset/send/email/success',
                    component: RequireRestPasswordSuccess
                },
                restPwd: {
                    path: 'reset/password',
                    component: RestPassword
                },
                restPwdError: {
                    path: 'reset/password/error',
                    component: RestPasswordError
                },
                restPwdSuccess: {
                    path: 'reset/password/success',
                    component: RestPasswordSuccess
                },
                emailActivateSuccess: {
                    path: 'email/activation/success',
                    component: EmailActivateSuccess
                },
                emailActivateError: {
                    path: 'email/activation/error',
                    component: EmailActivateError
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
