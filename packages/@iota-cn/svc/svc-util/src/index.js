/**
 * Created by rain.
 */import { pathToRegexp } from 'path-to-regexp';

class ExcludesUrls {
    constructor(opts, prefix) {
        this.allUrls = undefined;
        this.reload(opts, prefix);
    }

    sanitizePath(path, prefix) {
        if (!path) return '/';
        if (prefix) {
            path = prefix + path;
        }
        return '/' + path
            .replace(/^\/+/i, '')//去掉开头的/
            .replace(/\/+$/, '')//去掉结尾的/
            .replace(/\/{2,}/, '/');//两个及以上的/变成一个/
    }

    reload(opts, prefix) {
        //load all url
        if (!this.allUrls) {
            this.allUrls = opts;
            let that = this;
            this.allUrls.forEach(function (url, i, arr) {
                if (typeof url === "string") {
                    url = { p: url, o: '*' };
                    arr[i] = url;
                }
                const keys = [];
                let eachPath = url.p;
                url.p = (!eachPath || eachPath === '(.*)' || (Object.prototype.toString.call(eachPath) == '[object RegExp]') ? eachPath : that.sanitizePath(eachPath, prefix));
                url.pregexp = pathToRegexp(url.p, keys);

            });
        }
    }

    isExcluded(path, method) {
        return this.allUrls.some(function (url) {
            return !url.auth
                && url.pregexp.test(path)
                && (url.o === '*' || url.o.indexOf(method) !== -1);
        });
    }
}

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
    isPlainObject,
    ExcludesUrls
}