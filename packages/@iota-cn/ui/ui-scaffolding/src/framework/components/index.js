import axios from '../../axios'
import Cookie from './Cookie'
import Icon from './Icon'
import CountDownButton from './CountDownButton'
import messages from './locale'
import TableLayout from './TableLayout'
import Modal from './Modal'
import MultiAdd from './MultiAdd'
import NameValidatorItem from './formitems/NameValidatorItem'
import DescValidatorItem from './formitems/DescValidatorItem'
import SimpleEditor from './SimpleEditor'
import Empty from './Empty'
import ArrayTree from './ArrayTree'

const components = [
    Icon,
    CountDownButton,
    TableLayout,
    Modal,
    MultiAdd,
    NameValidatorItem,
    DescValidatorItem,
    SimpleEditor,
    Empty,
    ArrayTree
]

export {
    Icon,
    CountDownButton,
    TableLayout,
    Modal,
    MultiAdd,
    NameValidatorItem,
    DescValidatorItem,
    SimpleEditor,
    Empty,
    ArrayTree
}

const install = function (Vue) {
    Vue.use(Cookie)
    Vue.use(axios)
    components.forEach(c => {
        Vue.component(c.name, c)
    })
}

export default {
    install,
    messages
}