import ratelimit from 'koa-ratelimit';
import Redis from 'ioredis';

const FREQUENCY_LIMIT = 'Frequency';
const TIMES_LIMIT = 'Times';

export function entry(app, router, opts = {}) {
    app.iota.logger.log('info', '[iOTA-LIMITER]', 'Inject Limiter mw into router.');
    opts = opts || {};
    opts.max = opts.max || {};
    opts.max.web = opts.max.web || {};
    opts.max.default = opts.max.default || {};
    opts.duration = opts.duration || {};
    opts.duration.web = opts.duration.web || {};
    opts.duration.times = opts.duration.times || (60 * 60 * 24 * 30 * 1000);
    opts.duration.frequency = opts.duration.frequency || (1 * 1000);
    opts.duration.web.frequency = opts.duration.web.frequency || (60 * 1 * 1000);
    let getLimit = (type) => {
        return async (ctx) => {
            const session = ctx.session || {};
            let user = session.user || {};
            let id = user.id,
                max, duration,
                expired = false;
            let models = ctx.iota.dc.models;
            user = await models.User.findOne({ where: { id: id } }); //检查session中用户是否有效
            let clientLoginType = undefined;
            let serviceStatus = 'Ignore';
            if (user) {
                //用户名密码登录？
                if (!session.oauth2) {
                    clientLoginType = 'Password'
                    switch (type) {
                        case TIMES_LIMIT:
                            max = opts.max.web.times || 100000;
                            duration = opts.duration.times;
                            break;
                        case FREQUENCY_LIMIT:
                            max = opts.max.web.frequency || 40;
                            duration = opts.duration.web.frequency;
                            break;
                    }
                } else {
                    // API登录
                    //1.已登录
                    clientLoginType = 'API';
                    let service = session.service;
                    if (!service) {
                        let account = await models.Account.findOne({ where: { userId: user.id } });
                        service = await models.AccountServicePackage.findOne({ where: { accountId: account.id } });
                    }
                    if (service && service.endTime && service.endTime < new Date()) {
                        expired = true;
                    }
                    if (expired) {
                        serviceStatus = 'Expired';
                        //1.1.服务过期
                        switch (type) {
                            case TIMES_LIMIT:
                                max = opts.max.default.times || 10000;
                                duration = opts.duration.times;
                                break; //read opts quota
                            case FREQUENCY_LIMIT:
                                max = opts.max.default.frequency || 5;
                                duration = opts.duration.frequency;
                                break;
                        }
                    } else {
                        serviceStatus = 'NotExpired';
                        //1.2服务未过期
                        let specification = JSON.parse(service.specification);
                        switch (type) {
                            case TIMES_LIMIT:
                                max = specification.server.times.quota || 10000;
                                duration = opts.duration.times;
                                break;
                            case FREQUENCY_LIMIT:
                                max = specification.server.frequency.quota || 5;
                                duration = opts.duration.frequency;
                                break;
                        }
                    }
                }
                id = `${id} ${type} ${clientLoginType} ${serviceStatus}`;
            } else {
                let ipAddr = ctx.header["x-real-ip"] || ctx.ip;
                id = `${ipAddr} ${type}`;
                switch (type) {
                    case TIMES_LIMIT:
                        max = opts.max.default.times || 10000;
                        duration = opts.duration.times;
                        break; //read opts quota
                    case FREQUENCY_LIMIT:
                        max = opts.max.default.frequency || 5;
                        duration = opts.duration.frequency;
                        break;
                }
            }
            return {
                id: id,
                max: max,
                duration: duration
            }
        }
    };

    opts.db = opts.db || { host: "127.0.0.1", port: "6379", db: 4 };
    router.use(ratelimit({
        db: new Redis(opts.db),
        limit: getLimit(TIMES_LIMIT),
        headers: {
            remaining: 'Rate-Limit-Remaining',
            reset: 'Rate-Limit-Reset',
            total: 'Rate-Limit-Total'
        },
        errorMessage: '您本月接口访问次数已达到上限制，暂时无法访问...'
    }))
        .use(ratelimit({
            db: new Redis(opts.db),
            limit: getLimit(FREQUENCY_LIMIT),
            headers: {
                remaining: 'Rate-Limit-Remaining',
                reset: 'Rate-Limit-Reset',
                total: 'Rate-Limit-Total'
            },
            errorMessage: '您放问的次数太过频繁，请稍后再试...'
        }));
}