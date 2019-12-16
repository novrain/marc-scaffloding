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
    user_role,
    event_record
} from './model';

import api from './api'
import * as User from './api/user'
import * as Utils from './api/utils'

import uid from 'uuid';


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
    event_record(dc)
}

/**
 * 判断终端以及浏览器
 * userAgent string User-Agent信息
 */
function judgeTerminalBrowser(userAgent) {
    let data = {
        terminal: undefined,
        browser: undefined
    };
    let regs = {};
    let terminal = {
        'windows nt 10': 'Windows 10',
        'windows nt 6.3': 'Windows 8.1',
        'windows nt 6.2': 'Windows 8',
        'windows nt 6.1': 'Windows 7',
        'windows nt 6.0': 'Windows Vista',
        'windows nt 5.2': 'Windows Server 2003XP x64',
        'windows nt 5.1': 'Windows XP',
        'windows xp': 'Windows XP',
        'windows nt 5.0': 'Windows 2000',
        'windows me': 'Windows ME',
        'win98': 'Windows 98',
        'win95': 'Windows 95',
        'win16': 'Windows 3.11',
        'macintosh|mac os x': 'Mac OS X',
        'mac_powerpc': 'Mac OS 9',
        'linux': 'Linux',
        'ubuntu': 'Ubuntu',
        'phone': 'iPhone',
        'pod': 'iPod',
        'pad': 'iPad',
        'android': 'Android',
        'blackberry': 'BlackBerry',
        'webos': 'Mobile',
        'freebsd': 'FreeBSD',
        'sunos': 'Solaris'
    };

    for (let key in terminal) {
        if (new RegExp(key).test(userAgent.toLowerCase())) {
            data.terminal = terminal[key];
            break;
        }
    }

    if (regs = userAgent.match(/MSIE\s(\d+)\..*/)) {
        // ie 除11
        data.browser = 'ie ' + regs['1'];
    } else if (regs = userAgent.match(/FireFox\/(\d+)\..*/)) {
        data.browser = 'firefox ' + regs['1'];
    } else if (regs = userAgent.match(/Opera[\s|\/](\d+)\..*/)) {
        data.browser = 'opera ' + regs['1'];
    } else if (regs = userAgent.match(/Chrome\/(\d+)\..*/)) {
        data.browser = 'chrome ' + regs['1'];
    } else if (regs = userAgent.match(/Safari\/(\d+)\..*$/)) {
        // chrome浏览器都声明了safari
        data.browser = 'safari ' + regs['1'];
    } else if (regs = userAgent.match(/rv:(\d+)\..*/)) {
        // ie 11
        data.browser = 'ie ' + regs['1'];
    }
    return data;
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
        // await next();
        let rbac = app.iota.rbac
        let operations = rbac.operations
        const path = ctx.path

        let startTime = Date.now()
        let _method = ctx.request.method
        let operation = operations.findOperation(path, _method);
        console.log('operation info', operation)

        // let getClientIp = function (req) {
        //     return req.header['x-forwarded-for'] ||
        //         req.connection.remoteAddress ||
        //         req.socket.remoteAddress ||
        //         req.connection.socket.remoteAddress || 'undefined';
        // };
        // let ip = getClientIp(ctx.request).match(/\d+.\d+.\d+.\d+/)

        //response info
        var _status = null
        var _description = null
        var _exception_detail = null
        //用户日志 系统日志
        var _log_type = 0

        var _username = null
        var _userId = null

        try {
            await next()
        } catch (err) {
            ctx.iota.logger.log("error", "[iOTA-USER-RECORD]", err);
            ctx.status = 500;
            ctx.body = {
                name: 'Internal Server Error',
                message: 'Internal Server Error'
            };

            //系统日志
            _log_type = 1
            _exception_detail = err
        } finally {
            /**  
             * @TODO 
             * 1. 请求类型过滤 targetMethods, 包含则处理，不包含则不记录
             * 2. 从operation取出接口description
             * 3. 系统级日志的err可能为空？
             * 4. 插入数据库
             */

            if (operation && operation.verify) {
                if (ctx.session.user) {
                    //user info
                    let user = ctx.session.user
                    _username = user.userExt.fullname || user.username || 'undefined'
                    _userId = user.id
                }

                _status = ctx.response.status
                if (operation) {
                    _description = operation.name || 'undefined'
                } else {
                    _description = 'undefined'
                }
                if (_log_type !== 1) {
                    _exception_detail = ctx.response.message
                }

                var _host = ctx.request.headers.origin
                if (_host.includes('http://')) {
                    _host = _host.substring(7)
                } else if (_host.includes('https://')) {
                    _host = _host.substring(8)
                }

                //endTime
                let now = Date.now()
                let _time = now - startTime

                let eventRecordLog = {
                    _id: uid.v4(),
                    username: _username || 'undefined',
                    userId: _userId || 'undefined',
                    method: _method,
                    host: _host,
                    url: ctx.request.url,
                    status: _status,
                    description: _description,
                    exception_detail: _exception_detail || 'undefined',
                    log_type: _log_type,
                    request_ip: 'undefined',
                    time: _time,
                    browser: judgeTerminalBrowser(ctx.request.headers['user-agent']),
                    _v: operations.prefix
                }
                //插入数据库
                const dc = ctx.iota.dc;
                await dc.models.EventRecord.create({
                    _id: eventRecordLog._id,
                    username: eventRecordLog.username || 'undefined',
                    userId: eventRecordLog.userId || 'undefined',
                    method: eventRecordLog.method,
                    host: eventRecordLog.host,
                    url: eventRecordLog.url,
                    status: eventRecordLog.status,
                    description: eventRecordLog.description,
                    exception_detail: eventRecordLog.exception_detail,
                    log_type: eventRecordLog.log_type,
                    request_ip: eventRecordLog.request_ip,
                    time: eventRecordLog.time,
                    create_time: startTime,
                    browser: JSON.stringify(eventRecordLog.browser),
                    _v: eventRecordLog._v
                })
            }
        }
    }
}