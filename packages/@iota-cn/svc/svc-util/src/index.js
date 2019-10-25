/**
 * Created by rain.
 */

/**
 *
 * @param fn
 * @returns {Function}
 */
let createMiddleware = (fn) => {
    return async (ctx, next) => {
        if (!(ctx.session && ctx.session.user && ctx.session.user.id)) {
            ctx.status = 401;
            ctx.body = {
                name: 'unauthorized',
                message: `user or client unauthorized.`
            };
            return false;
        }

        try {
            await fn(ctx, next);
        } catch (e) {
            ctx.status = 500;
            ctx.body = {
                name: 'Server error',
                message: 'An unexpected condition was encountered in the server and no more specific message is suitable.'
            };
            ctx.iota.logger.error(`path: ${ctx.path}, error: ${e}`, e ? e.stack : '');
        }
    }
};

/**
 *
 * @param arr
 * @param key string or array
 * @returns {Array}
 */
let uniqueArray = (arr, key) => {
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
};

/**
 *
 * @param app
 * @param mw
 * @param hook
 * @param fn
 */
let registerHook = (app, mw, hook, fn) => {
    if (app.iota[mw]
        && app.iota[mw].hooks
        && app.iota[mw].hooks[hook]
        && typeof app.iota[mw].hooks[hook].callMw === 'function'
        && typeof fn === 'function') {
        app.iota[mw].hooks[hook].use(fn)
    }
};

let valBetween = (v, min = 20, max = 80, defaultVal) => {
    let limit = parseInt(v);
    let val = limit;
    if (isNaN(limit)) {
        val = min;
    } else {
        val = Math.min(max, Math.max(val, min));
    }
    if (val === limit) {
        return val;
    } else if (defaultVal !== undefined) {
        return valBetween(defaultVal, min, max);
    } else {
        return val;
    }
};


let isPlainObject = (obj) => {
    return Object.prototype.toString.call(obj) === '[object Object]'
};

export {
    createMiddleware,
    uniqueArray,
    registerHook,
    valBetween,
    isPlainObject
}