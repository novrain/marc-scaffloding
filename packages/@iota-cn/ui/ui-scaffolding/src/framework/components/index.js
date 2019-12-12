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
import BpmnViewer from './BpmnViewer'
import LoadScript from './LoadScript'

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
    ArrayTree,
    BpmnViewer
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
    ArrayTree,
    BpmnViewer
}

const install = function (Vue) {
    Vue.use(Cookie)
    Vue.use(axios)
    Vue.use(LoadScript)
    components.forEach(c => {
        Vue.component(c.name, c)
    })
}

export default {
    install,
    messages
}