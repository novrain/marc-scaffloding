import axios from 'axios'
import { message } from 'ant-design-vue/es'

let baseURL = 'http://localhost:18885'
if (window) {
    let location = window.location
    baseURL = `${location.protocol}//${location.hostname}:18885`
}

const instance = axios.create({
    baseURL
    // baseURL: 'http://10.8.25.31:18885'
})

const onRes = (res, { success, error }) => {
    // eslint-disable-next-line no-undef
    res.status < 400 ? message.success(success || `Code: ${res.status}`)
        // eslint-disable-next-line no-undef
        : message.error(error || `Code: ${res.status}`)
    return res
}

const onErr = (err, m) => {
    // eslint-disable-next-line no-undef
    message.error(m || err.toString())
    throw err
}

const noop = () => { }

const commonGet = (url, { success, error, fatal }) => {
    return instance.get(url).then((res) => onRes(res, { success, error }), (err) => onErr(err, fatal))
}

const commonPost = (url, payload, { success, error, fatal }) => {
    return instance.post(url, payload).then((res) => onRes(res, { success, error }), (err) => onErr(err, fatal))
}

const commonDelete = (url, { success, error, fatal }) => {
    return instance.delete(url).then((res) => onRes(res, { success, error }), (err) => onErr(err, fatal))
}

export default instance

export {
    commonGet,
    commonPost,
    commonDelete,
    noop,
    onRes,
    onErr
}