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

/**
 *
 * @param arr
 * @param key string or array
 * @returns {Array}
 */
export const uniqueArray = (arr, key) => {
    var ret = [];
    var len = arr.length;
    var tmp = new Map();
    for (var i = 0; i < len; i++) {
        let v = arr[i];
        if (key && typeof key === 'string') {
            v = arr[i][key];
        }
        if (key && Array.isArray(key)) {
            v = '';
            key.forEach((k) => {
                v += arr[i][k];
            })
        }
        if (!tmp.get(v)) {
            tmp.set(v, 1);
            ret.push(arr[i]);
        }
    }
    return ret;
}

export const convertArrayToTree = (lists) => {
    let [map, roots, nodeMap] = [{}, [], {}];

    lists.map((item, i) => {
        let node = item;
        node.children = [];
        map[node.id] = i;
        nodeMap[node.id] = node;
    });

    for (let i = 0; i < lists.length; i += 1) {
        let node = lists[i];
        if (node.parentId !== null) {
            lists[map[node.parentId]].children.push(node);
        } else {
            roots.push(node);
        }
    }

    return {
        roots,
        idMap: nodeMap
    }
}
