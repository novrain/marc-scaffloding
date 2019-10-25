import api, {
    signUp,
    signIn
} from './api';

export function models(dc) {
    return;
}

export function entry(app, router, opts) {
    app.iota.logger.log('info', '[IOTA-AUTHENTICATION]', 'Inject authentication mw into router.');
    app.iota = app.iota || {};
    //提供 通用方法 && 回调注入
    app.iota.authentication = app.iota.authentication || {
            signUp,
            signIn : signIn(opts)
        };

    router = api(app, router, opts);
    return async function (ctx, next) {
        ctx.iota = ctx.iota || {};
        ctx.iota.authentication = app.iota.authentication;
        await next();
    }
}