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

const onErr = (err, { message, doNotHint, handlerErr }) => {
    // eslint-disable-next-line no-undef
    if (!doNotHint) {
        message.error(message || err.toString())
    }
    if (handlerErr) {
        throw err
    }
}

const noop = () => { }

const commonGet = (url, { success, error, fatal, doNotHint, handlerErr }) => {
    return instance.get(url).then((res) => onRes(res, { success, error, doNotHint }), (err) => onErr(err, { message: fatal || error, doNotHint, handlerErr }))
}

const commonPost = (url, payload, { success, error, fatal, doNotHint, handlerErr }) => {
    return instance.post(url, payload).then((res) => onRes(res, { success, error, doNotHint }), (err) => onErr(err, { message: fatal || error, doNotHint, handlerErr }))
}

const commonPut = (url, payload, { success, error, fatal, doNotHint, handlerErr }) => {
    return instance.put(url, payload).then((res) => onRes(res, { success, error, doNotHint }), (err) => onErr(err, { message: fatal || error, doNotHint, handlerErr }))
}

const commonDelete = (url, { success, error, fatal, doNotHint, handlerErr }) => {
    return instance.delete(url).then((res) => onRes(res, { success, error, doNotHint }), (err) => onErr(err, { message: fatal || error, doNotHint, handlerErr }))
}

const install = (Vue) => {
    Vue.prototype.$axios = instance
    Object.assign(Vue.prototype.$axios, {
        commonGet,
        commonPut,
        commonPost,
        commonDelete,
        noop,
        onRes,
        onErr,
    })
}

export default {
    install
}

export {
    commonGet,
    commonPost,
    commonDelete,
    noop,
    onRes,
    onErr,
    init as initAxios,
    instance as axios
}