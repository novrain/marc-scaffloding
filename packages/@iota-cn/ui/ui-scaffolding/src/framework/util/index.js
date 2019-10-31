import cookie from './cookie'

export * from './cookie'
export { default } from './cookie'

/**
 * 少写点前缀
 * 
 * @param {*} prefix 
 */
export const createi18n = (prefix) => {
    return (key) => {
        return `${prefix}${key}`
    }
}

/**
 * 判断是否是普通对象
 * 
 * @param {*} obj 
 */
export const isPlainObject = (obj) => {
    return Object.prototype.toString.call(obj) === '[object Object]'
}

// 认证相关
export const isUserValid = (user) => {
    user = user || JSON.parse(localStorage.getItem('ii:user'))
    return user && (user.email || user.username || user.mobile) && user.type
}

export const isCookieValid = () => {
    try {
        const iota = cookie.iotaGet('iota')
        return iota && iota.length > 0
    }
    catch (err) {
        return false
    }
}

export const isUserStatusValid = (userInStore) => {
    try {
        return userInStore && userInStore.loggedIn
    }
    catch (err) {
        return false
    }
}

export const isUserLogged = (userInStore) => {
    return isCookieValid() && isUserValid() && isUserStatusValid(userInStore)
}
