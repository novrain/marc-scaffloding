/**
 * Created by rain on 2016/6/22.
 * 抽取Koa中间的实现并通用化
 */

export default class Mmw {
    constructor() {
        this.middleware = [];
    }

    use(fn) {
        if (typeof fn !== 'function') throw new TypeError('middleware must be a function!');
        //debug('use %s', fn._name || fn.name || '-');
        this.middleware.push(fn);
        return this;
    }

    async callMw(next) {
        await this.compose(this.middleware.concat(typeof next === 'function' ? [next] : [])).apply(this, arguments);
    }

    compose(mws) {
        if (!Array.isArray(mws)) throw new TypeError('Middleware stack must be an array!')
        for (const fn of mws) {
            if (typeof fn !== 'function') throw new TypeError('Middleware must be composed of functions!')
        }

        /**
         * @param arguments 本模块不关心具体函数入参，其他由应用自行约定
         * @return {Promise}
         */
        return function () {
            let index = -1;
            let n = arguments.length;
            const args = [];
            while (n--) args[n] = arguments[n];
            return dispatch(0);
            function dispatch(i) {
                if (i <= index) return Promise.reject(new Error('no more middleware to execute.'));
                index = i;
                const fn = mws[i];
                if (!fn) return Promise.resolve();
                try {
                    return Promise.resolve(fn.apply(this,
                        args.concat([function next() {
                            return dispatch(i + 1)
                        }])));
                } catch (err) {
                    return Promise.reject(err);
                }
            }
        }
    }
}