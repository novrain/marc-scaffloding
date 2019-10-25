import Sequelize from '@iota-fork/sequelize';
import rest from '@iota-fork/epilogue';

/**
 * create a function to normalize response.
 * @param key
 * @param showTotal
 * @returns {Function (koaCtx) }
 * koaCtx :{
 *     total:?
 *     key:[]
 * }
 * ==>  按ID查询，还是分页查询的不同结果情形。
 */
let createNormalizer = function (key, showTotal = true, idKey = 'id') {
    return (koaCtx) => {
        if (typeof koaCtx.params[idKey] !== 'undefined') {
            let rs = koaCtx.body[key];
            if (Array.isArray(rs) && rs.length > 0) {
                koaCtx.body = rs[0];
            } else {
                koaCtx.status = 404;
                koaCtx.body = {
                    name: 'not found',
                    message: `the resource of ${koaCtx.params[idKey]} not found.`
                }
            }
        } else {
            if (showTotal) {
                koaCtx.body = {
                    total: koaCtx.body.count,
                    [key]: koaCtx.body[key]
                }
            } else {
                koaCtx.body = {
                    [key]: koaCtx.body[key]
                }
            }
        }
    }
};

/**
 * 为restful 接口提供的 规范化函数
 * @param key
 * @returns {Function}
 */
let createNormalizerAfter = function (key) {
    return (koaCtx, restfulCtx) => {
        //restful 返回的是数组，转为 { key: [] }, 没有total, 通常这种接口只是为静态配置数据提供，极少。
        koaCtx.body = {
            [key]: koaCtx.body
        };
        createNormalizer(key)(koaCtx);
        return restfulCtx.continue;
    };
};

export default function entry(app, router, opts) {
    app.iota = app.iota || {};
    let logger = app.iota.logger || console;
    logger.log('info', '[IOTA-RESTFUL]', 'Inject restful framework into app.');

    rest.initialize({
        app: router,
        sequelize: app.iota.dc.orm
    });
    app.iota.restful = rest;
    app.iota.restful.createNormalizer = createNormalizer;
    app.iota.restful.createNormalizerAfter = createNormalizerAfter;
    return async function (ctx, next) {
        ctx.iota.restful = app.iota.restful;
        await next();
    }

}


