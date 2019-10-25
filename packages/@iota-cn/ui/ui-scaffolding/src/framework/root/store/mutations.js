import * as T from './mutation-types'

const mutations = {
    [T.ROOT_CHANGE_THEME]: (state, value) => {
        state.theme = value
        localStorage.setItem('ii:theme', value)
        const el = document.getElementsByTagName('html')[0]
        if (value !== 'default') {
            el.classList.add('ii-dark-mode')
        } else {
            el.classList.remove('ii-dark-mode')
        }
    },

    // [T.ROOT_CHANGE_LANG]: (state, value) => {
    //     state.lang = value
    // }
}

export default mutations