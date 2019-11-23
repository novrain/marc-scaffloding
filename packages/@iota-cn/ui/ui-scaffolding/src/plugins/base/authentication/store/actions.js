import * as T from './mutation-types'
import { axios, commonPost, noop, silentGet } from '../../../../axios'
import cookie, { createi18n, isCookieValid, isUserValid } from '../../../../framework/util'

const $i = createi18n('iota.global.authentication.')

export default {
    async signin({ dispatch }, { require, that, redirect }) {
        commonPost('/v1/api/signin', require, {
            success: that.$t($i('signinsuccess')),
            error: that.$t($i('signinerror'))
        }).then(res => {
            if (require.remember) {
                // 存储 localStorage
                localStorage.setItem('ii:user', JSON.stringify(res.data))
            }
            res.data.loggedIn = true // 标记登录成功
            dispatch('updateUser', res.data).then(() => {
                if (redirect) {
                    that.$router.push({ path: redirect })
                }
            })
        }, noop)
    },
    trySignin({ dispatch }) {
        // 判断 Cookie 和 localStorage 里的数据情况
        if (isCookieValid() && isUserValid()) {
            // 更新登录状态
            let user = JSON.parse(localStorage.getItem('ii:user'));
            user.loggedIn = true
            dispatch('updateUser', user)
            dispatch('refetchUser', user)
        }
    },
    async refetchUser({ dispatch }) {
        silentGet('/v1/api/accounts/profile').
            then(res => {
                if (res) dispatch('updateUser', res.data.user)
            })
    },
    updateUser({ commit }, user) {
        commit(T.GLOBAL_AUTHENTICATION_SIGNIN, user)
    },
    async signout({ commit }) {
        axios.post('/v1/api/signout').finally(() => {
            // 清理 localStorage
            localStorage.removeItem('ii:user')
            cookie.iotaRemove('iota')
            cookie.iotaRemove('iota.sig')
            commit(T.GLOBAL_AUTHENTICATION_SIGNOUT)
            // 更新、判断登录状态
            window.location.reload()
        })
    }
}