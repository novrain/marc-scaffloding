import axios from '../../axios'
import Cookie from './Cookie'
import Icon from './Icon'
import CountDownButton from './CountDownButton'

const components = [
    Icon,
    CountDownButton
]

export {
    Icon,
    CountDownButton
}

const install = function (Vue) {
    Vue.use(Cookie)
    Vue.use(axios)
    components.forEach(c => {
        Vue.component(c.name, c)
    })
}

export default {
    install
}