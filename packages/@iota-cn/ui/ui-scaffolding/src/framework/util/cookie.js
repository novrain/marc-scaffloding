import cookie from 'js-cookie'

// 插入iotaGet / iotaRemove 方法
function init(prefix) {
    let p = prefix ? prefix : ''
    let oldGet = cookie.get
    let oldSet = cookie.set
    let oldGetJSON = cookie.getJSON
    let oldRemove = cookie.remove
    cookie.iotaGet = (name) => {
        let _name = `${p}${name}`
        return oldGet(_name)
    }
    cookie.iotaRemove = (name, opt) => {
        let _name = `${p}${name}`
        return oldRemove(_name, opt)
    }
    cookie.iotaGetJSON = (name) => {
        let _name = `${p}${name}`
        return oldGetJSON(_name)
    }
    cookie.iotaSet = (name, value, opt) => {
        let _name = `${p}${name}`
        return oldSet(_name, value, opt)
    }
}

export default cookie

export {
    init as initCookie
}
