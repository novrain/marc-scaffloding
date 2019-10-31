import merge from 'deepmerge'
import * as T from './mutation-types'
import * as U from '../util'

export default () => {
    return {
        [T.GLOBAL_AUTHENTICATION_SIGNIN](state, user) {
            state.user = merge(state.user, user)
        },
        [T.GLOBAL_AUTHENTICATION_SIGNOUT](state) {
            state.user = U.createEmptyUser()
        }
    }
}