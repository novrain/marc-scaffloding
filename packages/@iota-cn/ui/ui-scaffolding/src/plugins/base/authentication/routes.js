import Signin from './view/Signin'
import { TrySigninInterceptor } from '../../../framework/mixins'

export default (opts) => {
    const signin = opts.signin || {}
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
            }
        }
    }
}
