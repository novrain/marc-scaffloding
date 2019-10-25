import { registerHook } from '@iota-cn/svc-util';

import api, {
    createHook,
    updateHook
} from './api';

import {
    resource_type,
    resource_operation_type,
    resource_group,
    resource,
    role,
    permission,
    user_group,
    user_group_user,
    authorization
} from './model';

export function models(dc) {
    resource_type(dc);
    resource_operation_type(dc);
    resource_group(dc);
    resource(dc);
    role(dc);
    permission(dc);
    user_group(dc);
    user_group_user(dc);
    authorization(dc);
}

export function entry(app, router, opts) {
    app.iota.logger.log('info', '[IOTA-AUTHORIZATION]', 'Inject authorization mw into router.');
    app.iota = app.iota || {};
    //提供 通用方法 && 回调注入
    app.iota.authorization = app.iota.authorization || {};
    registerHook(app, 'user', 'afterCreate', createHook);
    registerHook(app, 'user', 'afterUpdate', updateHook);
    router = api(app, router, opts);
    return async function (ctx, next) {
        ctx.iota = ctx.iota || {};
        ctx.iota.authorization = app.iota.authorization;
        await next();
    }
}