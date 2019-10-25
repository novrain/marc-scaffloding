import * as T from './mutation-types'
import axios, { commonPost, noop } from '../../../../axios'
import { createi18n } from '../../../../framework/util'

const $i = createi18n('iota.global.authentication.')

export default (opts) => {
    return {
        async signin({ commit }, { require, that }) {
            commonPost('/v1/api/signin', require, {
                success: that.$t($i('signinsuccess')),
                error: that.$t('signinerror')
            }).then(user => {
                if (require.remember) {
                    // 存储 localStorage
                    localStorage.setItem('ii:user', JSON.stringify(user))
                }
                commit(T.GLOBAL_AUTHENTICATION_SIGNIN, user)
                if (opts && opts.signin && opts.signin.redirect) {
                    that.$router.push(opts.signin.redirect)
                }
            }, noop)
        },
        async signout({ commit }) {
            axios.post('/v1/api/signout').finally(() => {
                // 清理 localStorage
                localStorage.removeItem('ii:user')
                commit(T.GLOBAL_AUTHENTICATION_SIGNOUT)
            })
        }
    }
}