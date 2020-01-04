import { registerHook } from '@iota-cn/svc-util'
import { pathToRegexp } from 'path-to-regexp';

import { createMiddleware } from '@iota-cn/svc-util'

import {
    menu,
    menu_pre_depends,
    operation,
    operation_pre_depends,
    role,
    role_menu,
    role_operation,
    organization,
    organization_role,
    position,
    position_role,
    user_organization,
    user_position,
    user_role
} from './model';

import api from './api'
import * as User from './api/user'
import * as Utils from './api/utils'


class Operations {
    constructor(dc, logger, prefix) {
        this.logger = logger;
        this.dc = dc;
        this.models = dc.models;
        this.operations = [];
        this.prefix = prefix;
        this.loaded = false;
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

    async load() {
        const keys = [];
        let operations = await this.models.Operation.findAll({ raw: true });
        operations.forEach(operation => {
            let eachPath = this.prefix ? `${this.prefix}${operation.key}` : operation.key;
            operation.path = (!eachPath || eachPath === '(.*)' || (Object.prototype.toString.call(eachPath) == '[object RegExp]') ? eachPath : this.sanitizePath(eachPath));
            operation.regexp = pathToRegexp(operation.path, keys);
            this.operations.push(operation)
        })
        this.loaded = true;
    }

    findOperation(path, method) {
        return this.operations.find(o => {
            return o.regexp.test(path)
                && (o.method === '*' || o.method.indexOf(method) !== -1);
        })
    }
}

export function models(dc) {
    menu(dc);
    menu_pre_depends(dc);
    operation(dc);
    operation_pre_depends(dc);
    role(dc);
    role_menu(dc);
    role_operation(dc);
    organization(dc);
    organization_role(dc);
    position(dc);
    position_role(dc);
    user_organization(dc);
    user_position(dc);
    user_role(dc);
}

export function entry(app, router, opts) {
    app.iota.logger.log('info', '[IOTA-RBAC]', 'Inject RBAC mw into router.');
    app.iota = app.iota || {};
    //提供 通用方法 && 回调注入
    let operations = new Operations(app.iota.dc, app.iota.logger, opts.global.prefix);
    app.iota.rbac = app.iota.rbac || { operations: operations };
    registerHook(app, 'user', 'afterCreate', User.createHook);
    registerHook(app, 'user', 'afterUpdate', User.updateHook);
    router.use(createMiddleware(async function (ctx, next) {
        ctx.iota = ctx.iota || {};
        ctx.iota.rbac = app.iota.rbac;
        const user = ctx.session.user;
        if (!operations.loaded) {
            await operations.load();
        }
        if (user.isAdmin) {
            await next();
        }
        else {
            const path = ctx.path;
            const method = ctx.method;
            let rbac = ctx.session.rbac
            if (!rbac || !rbac.operations) {
                const userId = ctx.session.user.id;
                const dc = ctx.iota.dc;
                const models = ctx.iota.dc.models;

                let condition = Utils.buildRoleFilterQuery(dc, userId, models.RoleOperation, 'roleId');
                let userOperations = await models.Operation.findAll(condition);
                //parents
                userOperations = userOperations.map(o => {
                    let to = o.get({ plain: true })
                    return to;
                })
                userOperations = await Utils.fillAllParents(userOperations, models.Operation);
                rbac = ctx.session.rbac = {
                    operations: userOperations
                }
            }
            let operation = operations.findOperation(path, method);
            if (!operation || !operation.verify) {
                await next()
            } else {
                let auth = rbac.operations.some(o => {
                    return o.id === operation.id
                })
                if (auth) {
                    await next();
                } else {
                    ctx.status = 403;
                    ctx.body = {
                        name: 'Forbidden error',
                        message: 'The request was a valid request, but the server is refusing to respond to it.',
                        detail: 'not authorized.'
                    };
                }
            }
        }
    }))
    api(app, router, opts);
    return async function (ctx, next) {
        ctx.iota = ctx.iota || {};
        ctx.iota.rbac = app.iota.rbac;
        await next();
    }
}