import { registerHook } from '@iota-cn/svc-util';

import api, {
    createHook,
    createDefaultServiceHook,
    changeBalance
} from './api';

import {
    account,
    service_package,
    account_service_package,
    order,
    recharge,
    dashboard
} from './model';

export function models(dc) {
    account(dc);
    service_package(dc);
    account_service_package(dc);
    order(dc);
    recharge(dc);
    dashboard(dc);
}

export function entry(app, router, opts) {
    app.iota.logger.log('info', '[iOTA-ACCOUNT]', 'Inject account mw into router.');
    app.iota = app.iota || {};
    //提供 通用方法 && 回调注入
    app.iota.account = app.iota.account || {
        changeBalance
    };
    registerHook(app, 'user', 'afterCreate', createHook);
    registerHook(app, 'user', 'afterCreate', createDefaultServiceHook);
    router = api(app, router, opts);
    return async function (ctx, next) {
        ctx.iota = ctx.iota || {};
        ctx.iota.account = app.iota.account;
        await next();
    }
}