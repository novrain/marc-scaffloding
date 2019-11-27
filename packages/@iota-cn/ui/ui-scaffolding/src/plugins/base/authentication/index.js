import Vue from 'vue'
import store from './store'
import messages from './view/locale'
import routes from './routes'

import ResetPasswordForm from './components/ResetPasswordForm'

Vue.component('ii-reset-password-form', ResetPasswordForm)

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