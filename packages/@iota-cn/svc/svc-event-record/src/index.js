import {
    pathToRegexp
} from 'path-to-regexp';

import {
    event_record
} from './model';

import uid from 'uuid';

export function models(dc) {
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

export function entry(app) {
    return async function (ctx, next) {
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