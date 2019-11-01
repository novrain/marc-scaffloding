import Cookie from './Cookie'
import Icon from './Icon'

const components = [
    Icon
]

export {
    Icon
}

const install = function (Vue) {
    Vue.use(Cookie)
    components.forEach(c => {
        Vue.component(c.name, c)
    })
}

export default {
    install
}