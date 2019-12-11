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

const onErr = (err, { message: m, doNotHint, handleErr }) => {
    // eslint-disable-next-line no-undef
    if (!doNotHint) {
        message.error(m || err.toString())
    }
    if (handleErr) {
        throw err
    }
    return undefined
}

const noop = () => { }

const commonGet = (url, { success, error, fatal, doNotHint, handleErr }) => {
    return instance.get(url).then((res) => onRes(res, { success, error, doNotHint }), (err) => onErr(err, { message: fatal || error, doNotHint, handleErr }))
}

const silentGet = (url, handleErr) => {
    return commonGet(url, { doNotHint: true, handleErr: handleErr })
}

const commonPost = (url, payload, { success, error, fatal, doNotHint, handleErr }) => {
    return instance.post(url, payload).then((res) => onRes(res, { success, error, doNotHint }), (err) => onErr(err, { message: fatal || error, doNotHint, handleErr }))
}

const silentPost = (url, payload, handleErr) => {
    return commonPost(url, payload, { doNotHint: true, handleErr: handleErr })
}

const commonPut = (url, payload, { success, error, fatal, doNotHint, handleErr }) => {
    return instance.put(url, payload).then((res) => onRes(res, { success, error, doNotHint }), (err) => onErr(err, { message: fatal || error, doNotHint, handleErr }))
}

const silentPut = (url, payload, handleErr) => {
    return commonPut(url, payload, { doNotHint: true, handleErr: handleErr })
}

const commonDelete = (url, { success, error, fatal, doNotHint, handleErr }) => {
    return instance.delete(url).then((res) => onRes(res, { success, error, doNotHint }), (err) => onErr(err, { message: fatal || error, doNotHint, handleErr }))
}

const silentDelete = (url, handleErr) => {
    return commonDelete(url, { doNotHint: true, handleErr: handleErr })
}

const baseURL = () => {
    return instance.defaults.baseURL
}

const install = (Vue) => {
    Vue.prototype.$axios = instance
    Object.assign(Vue.prototype.$axios, {
        commonGet,
        commonPut,
        commonPost,
        commonDelete,
        silentGet,
        silentPost,
        silentPut,
        silentDelete,
        noop,
        onRes,
        onErr,
        baseURL
    })
}

export default {
    install
}

export {
    commonGet,
    commonPut,
    commonPost,
    commonDelete,
    silentGet,
    silentPost,
    silentPut,
    silentDelete,
    noop,
    onRes,
    onErr,
    baseURL,
    init as initAxios,
    instance as axios
}