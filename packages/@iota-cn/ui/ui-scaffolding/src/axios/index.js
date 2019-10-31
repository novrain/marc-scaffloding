import axios from 'axios'
import { message } from 'ant-design-vue/es'

let instance = axios.create({ withCredentials: true })
const init = (opts) => {
    let baseURL = `http://localhost:${opts.port || 9091}`
    if (window) {
        let location = window.location
        baseURL = `${location.protocol}//${location.hostname}:${opts.port || 9091}`
    }
    instance.defaults.baseURL = baseURL
}

const onRes = (res, { success, error, doNotHint }) => {
    // eslint-disable-next-line no-undef
    if (!doNotHint) {
        res.status < 400 ? message.success(success || `Code: ${res.status}`)
            // eslint-disable-next-line no-undef
            : message.error(error || `Code: ${res.status}`)
    }
    return res
}

const onErr = (err, { message, doNotHint }) => {
    // eslint-disable-next-line no-undef
    if (!doNotHint) {
        message.error(message || err.toString())
    }
    //throw err
}

const noop = () => { }

const commonGet = (url, { success, error, fatal, doNotHint }) => {
    return instance.get(url).then((res) => onRes(res, { success, error, doNotHint }), (err) => onErr(err, { message: fatal || error, doNotHint }))
}

const commonPost = (url, payload, { success, error, fatal, doNotHint }) => {
    return instance.post(url, payload).then((res) => onRes(res, { success, error, doNotHint }), (err) => onErr(err, { message: fatal || error, doNotHint }))
}

const commonDelete = (url, { success, error, fatal, doNotHint }) => {
    return instance.delete(url).then((res) => onRes(res, { success, error, doNotHint }), (err) => onErr(err, { message: fatal || error, doNotHint }))
}

export default instance

export {
    commonGet,
    commonPost,
    commonDelete,
    noop,
    onRes,
    onErr,
    init as initAxios
}