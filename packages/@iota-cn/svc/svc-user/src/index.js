import {
    user,
    encrypt,
    sub_user,
    user_extention
} from './model';
import api, {
    create,
    update,
    changePassword,
    findUserExtention,
    updateOrCreateUserExtention
} from './api';
import Mmw from '@iota-cn/svc-mmw';

export function models(dc) {
    user(dc);
    sub_user(dc);
    user_extention(dc);
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
        findUserExtention,
        updateOrCreateUserExtention,
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