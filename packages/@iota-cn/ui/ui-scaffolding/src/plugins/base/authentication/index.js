import Vue from 'vue'
import store from './store'
import messages from './view/locale'
import routes from './routes'

import ResetPasswordForm from './components/ResetPasswordForm'
import UserInfoExtendsForm from './components/UserInfoExtendsForm'

Vue.component('ii-reset-password-form', ResetPasswordForm)
Vue.component('ii-user-extends-form', UserInfoExtendsForm)

const entry = (opts) => {
    return {
        store: store(opts),
        messages,
        routes: routes(opts)
    }
}

export {
    entry
}