import {
    user,
    encrypt,
    subuser
} from './model';
import api, {
    create,
    update,
    changePassword
} from './api';
import Mmw from '@iota-cn/svc-mmw';

export function models(dc) {
    user(dc);
    subuser(dc);
}

export function entry(app, router, opts) {
    app.iota.logger.log('info', '[IOTA-USER]', 'Inject user mw into router.');
    app.iota = app.iota || {};
    //提供 通用方法 && 回调注入
    app.iota.user = app.iota.user || {
            encrypt,
            create,
            update,
            changePassword,
            hooks: {
                afterCreate: new Mmw(),
                afterUpdate: new Mmw()
            }
        };

    router = api(app, router, opts);
    return async function (ctx, next) {
        ctx.iota = ctx.iota || {};
        ctx.iota.user = app.iota.user;
        await next();
    }
}