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