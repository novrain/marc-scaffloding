'use strict';

Object.defineProperty(exports, "__esModule", {
    value: true
});

var _koa = require('koa');

var _koa2 = _interopRequireDefault(_koa);

var _koaConvert = require('koa-convert');

var _koaConvert2 = _interopRequireDefault(_koaConvert);

var _koaLogger = require('koa-logger');

var _koaLogger2 = _interopRequireDefault(_koaLogger);

var _koaBodyparser = require('koa-bodyparser');

var _koaBodyparser2 = _interopRequireDefault(_koaBodyparser);

var _koaCsrf = require('koa-csrf');

var _koaCsrf2 = _interopRequireDefault(_koaCsrf);

var _koaCompress = require('koa-compress');

var _koaCompress2 = _interopRequireDefault(_koaCompress);

var _koaCors = require('koa-cors');

var _koaCors2 = _interopRequireDefault(_koaCors);

var _koaStatic = require('koa-static');

var _koaStatic2 = _interopRequireDefault(_koaStatic);

var _koaRouter = require('koa-router');

var _koaRouter2 = _interopRequireDefault(_koaRouter);

var _svcDc = require('@iota-cn/svc-dc');

var _svcDc2 = _interopRequireDefault(_svcDc);

var _svcRestful = require('@iota-cn/svc-restful');

var _svcRestful2 = _interopRequireDefault(_svcRestful);

var _svcLogger = require('@iota-cn/svc-logger');

var _svcLogger2 = _interopRequireDefault(_svcLogger);

var _svcSession = require('@iota-cn/svc-session');

var _svcSession2 = _interopRequireDefault(_svcSession);

var _http = require('http');

var _http2 = _interopRequireDefault(_http);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

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

//from private npm


function rewriteCookie(prefix) {
    return async (ctx, next) => {
        try {
            let p = prefix ? prefix : '';
            ctx.cookies.setCookie = ctx.cookies.set;
            ctx.cookies.getCookie = ctx.cookies.get;
            ctx.cookies.set = async function (name, value, options) {
                let _name = `${p}${name}`;
                return await ctx.cookies.setCookie(_name, value, options);
            };
            ctx.cookies.get = function (name, options) {
                let _name = `${p}${name}`;
                if (name.indexOf('.sig') > -1) {
                    _name = name;
                }
                return ctx.cookies.getCookie(_name, options);
            };
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
    `);
    const defaultConfig = require('./config.js');
    const app = new _koa2.default();
    const server = _http2.default.createServer(app.callback());
    app.server = server;
    //init logger and inject it into app(app.iota.logger) and runtime ctx(ctx.iota.logger)
    app.use((0, _svcLogger2.default)(app, config.logger));
    app.use(errorHandler());
    config.global = config.global || {};
    const router = config.global.prefix ? new _koaRouter2.default({
        prefix: config.global.prefix
    }) : new _koaRouter2.default();
    config = config || defaultConfig;
    app.keys = ["it is a secret"];
    config.cookie = config.cookie ? config.cookie : {};
    if (config.compress) {
        app.use((0, _koaCompress2.default)(config.compress || {}));
    }
    app.use(rewriteCookie(config.cookie.prefix));
    app.use((0, _koaConvert2.default)((0, _koaCors2.default)(config.cors || {})));
    if (config.staticDirs && Array.isArray(config.staticDirs)) {
        config.staticDirs.forEach(s => {
            app.use((0, _koaStatic2.default)(s));
        });
    }
    if (config.koaLogger) {
        app.use((0, _koaLogger2.default)(config.koaLogger));
    }
    app.use((0, _svcSession2.default)(config.session));
    //@Todo add csrf protect. Require the client side login or ...
    //app.use(convert(csrf()));
    app.use((0, _koaBodyparser2.default)({ jsonLimit: '80mb', formLimit: '80mb' }));
    //init dc and inject it into app(app.iota.dc) and runtime ctx(app.iota.dc)
    //@Todo DC use router?
    app.use((0, _svcDc2.default)(app, config.dc));
    //init restful base on dc model.
    app.use((0, _svcRestful2.default)(app, router, config.restful));

    config.mws.forEach(function (mv) {
        if (typeof mv.entry === 'function') {
            try {
                let opts = mv.opts;
                // add global opts
                opts.global = config.global;
                let fn = mv.entry(app, router, opts);
                if (fn) {
                    app.use(fn);
                }
            } catch (err) {
                //be sure that the logger middleware is injected.
                app.iota.logger.log('error', '[iOTA-app]', err);
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

exports.default = scaffold;