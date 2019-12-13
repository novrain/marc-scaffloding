'use strict';

import Koa from 'koa';
import convert from 'koa-convert';
import koaLogger from 'koa-logger';
import bodyParser from 'koa-bodyparser';
import csrf from 'koa-csrf';
import compress from 'koa-compress'
import cors from 'koa-cors';
import statics from 'koa-static';
import Router from 'koa-router';

//from private npm
import iotaDC from '@iota-cn/svc-dc';
import iotaRestful from '@iota-cn/svc-restful';
import iotaLogger from '@iota-cn/svc-logger';
import iotaSession from '@iota-cn/svc-session';
import { ExcludesUrls } from '@iota-cn/svc-util'
import http from 'http';

import uid from 'uuid';

//the middleware out of all the others.
function errorHandler() {
    return async (ctx, next) => {
        try {
            await next();
        } catch (err) {
            //be sure that the logger middleware is injected.
            ctx.iota.logger.log("error", "[iOTA-ERRHD]", err);
            ctx.status = 500;
            ctx.body = {
                name: 'Internal Server Error',
                message: 'Internal Server Error'
            };
        }
    };
}

function rewriteCookie(prefix) {
    return async (ctx, next) => {
        try {
            let p = prefix ? prefix : '';
            ctx.cookies.setCookie = ctx.cookies.set;
            ctx.cookies.getCookie = ctx.cookies.get;
            ctx.cookies.set = async function (name, value, options) {
                let _name = `${p}${name}`;
                return await ctx.cookies.setCookie(_name, value, options);
            }
            ctx.cookies.get = function (name, options) {
                let _name = `${p}${name}`;
                if (name.indexOf('.sig') > -1) {
                    _name = name;
                }
                return ctx.cookies.getCookie(_name, options);
            }
            await next();
        } catch (err) {
            //be sure that the logger middleware is injected.
            ctx.iota.logger.log("error", "[iOTA-ERRHD]", err);
            ctx.status = 500;
            ctx.body = {
                name: 'Internal Server Error',
                message: 'Internal Server Error'
            };
        }
    };
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

/**
 * 记录事件日志
 */
function eventRecord(eventRecordLog) {
    return async (ctx, next) => {
        let startTime = Date.now()
        let _method = ctx.request.method

        // let getClientIp = function (req) {
        //     return req.header['x-forwarded-for'] ||
        //         req.connection.remoteAddress ||
        //         req.socket.remoteAddress ||
        //         req.connection.socket.remoteAddress || 'undefined';
        // };
        // let ip = getClientIp(ctx.request).match(/\d+.\d+.\d+.\d+/)

        //response info
        let _status = ctx.response.status
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

            if (_method !== 'GET' || _log_type === 1) {
                if (ctx.session.user) {
                    //user info
                    let user = ctx.session.user
                    _username = user.userExt.fullname || user.username
                    _userId = user.id
                }
                if (_status === 200) {
                    _description = ctx.response.message
                } else {
                    if (_log_type !== 1) {
                        _exception_detail = ctx.response.message
                    }
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

                eventRecordLog = {
                    _id: uid.v4(),
                    username: _username || 'undefined',
                    userId: _userId || 'undefined',
                    method: _method,
                    host: _host,
                    url: ctx.request.url,
                    status: _status,
                    description: _description,
                    exception_detail: _exception_detail,
                    log_type: _log_type,
                    request_ip: 'undefined',
                    time: _time,
                    browser: judgeTerminalBrowser(ctx.request.headers['user-agent']),
                    _v: '1.0.0'
                }

                ctx.iota.logger.log("info", "[iOTA-USER-RECORD]", eventRecordLog);
                //插入数据库
            }
        }
    }
}

function scaffold(config) {
    console.log(`
                    ____             ______                 ____                  _____
                   /\\   \\           /::\\   \\               /\\   \\               /::\\   \\
                  /::\\___\\         /::::\\   \\             /::\\   \\             /::::\\___\\
                 _\\::/   /        /::::::\\   \\            \\:::\\   \\           /::::::|   |
                /\\ \\/___/        /:::/\\:::\\   \\            \\:::\\   \\         /:::/|::|   |
               /::\\___\\         /:::/  \\:::\\   \\           /\\:::\\   \\       /:::/ |::|   |
              /:::/   /        /:::/   /\\:::|   |         /::\\:::\\   \\     /::::\\ |::|   |
             /:::/   /        /:::/   /  \\::|   |        /:::/\\::/   /    /::::::\\|::|   |
            /:::/   /        /:::/   /   /::/   /       /:::/  \\/___/    /:::/\\::::::|   |
           /:::/   /        /:::/   /   /::/   /       /:::/   /        /:::/  \\:::::|   |
          /:::/   /        /:::/   /   /::/   /       /:::/   /        /:::/   /\\::::|   |
         /:::/   /        |:::/   /   /::/   /       /:::/   /        /:::/   /  \\:::|   |
        /:::/   /         |:::\\   \\  /::/   /       /:::/   /         \\::/   /    |::|   |
       /:::/   /           \\:::\\   \\/::/   /       /:::/   /           \\/___/     |::|   |
      /:::/   /             \\:::\\  /::/   /       /:::/   /                       |::|   |
     /:::/   /               \\:::\\/::/   /       /:::/   /                        |::|   |
     \\::/   /                 \\:::::/   /        \\::/   /                          \\:|   |
      \\/___/                   \\___/___/          \\/___/                            \\|___|
    `)
    const defaultConfig = require('./config.js');
    const app = new Koa();
    const server = http.createServer(app.callback());
    app.server = server;
    //init logger and inject it into app(app.iota.logger) and runtime ctx(ctx.iota.logger)
    app.use(iotaLogger(app, config.logger));
    app.use(errorHandler());
    config.global = config.global || {};
    const router = config.global.prefix ? new Router({
        prefix: config.global.prefix
    }) : new Router();
    config = config || defaultConfig;
    app.keys = ["it is a secret"];
    config.cookie = config.cookie ? config.cookie : {};
    if (config.compress) {
        app.use(compress(config.compress || {}))
    }
    app.use(rewriteCookie(config.cookie.prefix));
    app.use(convert(cors(config.cors || {})));
    if (config.staticDirs && Array.isArray(config.staticDirs)) {
        config.staticDirs.forEach((s) => {
            app.use(statics(s));
        });
    }
    if (config.koaLogger) {
        app.use(koaLogger(config.koaLogger));
    }
    app.use(iotaSession(config.session));
    //@Todo add csrf protect. Require the client side login or ...
    //app.use(convert(csrf()));

    // skip bodyParser
    config.bodyParser = config.bodyParser || { jsonLimit: '80mb', formLimit: '80mb' }
    if (Array.isArray(config.bodyParser.disable) && config.bodyParser.disable.length > 0) {
        const excludesUrls = new ExcludesUrls(config.bodyParser.disable, '')
        app.use(async (ctx, next) => {
            if (excludesUrls.isExcluded(ctx.path)) {
                ctx.disableBodyParser = true
            } else {
                ctx.disableBodyParser = false
            }
            await next()
        })
    }
    app.use(bodyParser(config.bodyParser));
    //init dc and inject it into app(app.iota.dc) and runtime ctx(app.iota.dc)
    //@Todo DC use router?
    app.use(iotaDC(app, config.dc));
    //init restful base on dc model.
    app.use(iotaRestful(app, router, config.restful));
    app.use(eventRecord(config.eventRecordLog))
    config.mws.forEach(function (mv) {
        if (typeof mv.entry === 'function') {
            try {
                let opts = mv.opts || {};
                // add global opts
                opts.global = config.global;
                let rs = mv.entry(app, router, opts);
                if (typeof rs === 'function') {
                    app.use(rs);
                }
                else if (rs !== undefined) {
                    if (typeof rs.middlware === 'function') {
                        app.use(rs.middlware)
                    }
                    if (rs.subRouter) {
                        app.use(rs.subRouter.routes())
                    }
                }
            } catch (err) {
                //be sure that the logger middleware is injected.
                app.iota.logger.log('error', '[iOTA-app]', err)
            }
        }
    });

    app.use(router.routes());

    let port = process.env.PORT || config.port || 4000;
    console.log(`listen on ${config.host ? `${config.host}:` : ''}${port}`);

    server.listen(port, config.host);
    //for test
    app.router = router;
    return app;
}

export default scaffold;