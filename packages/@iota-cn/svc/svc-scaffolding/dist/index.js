'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _koa = _interopRequireDefault(require("koa"));

var _koaConvert = _interopRequireDefault(require("koa-convert"));

var _koaLogger = _interopRequireDefault(require("koa-logger"));

var _koaBodyparser = _interopRequireDefault(require("koa-bodyparser"));

var _koaCsrf = _interopRequireDefault(require("koa-csrf"));

var _koaCompress = _interopRequireDefault(require("koa-compress"));

var _koaCors = _interopRequireDefault(require("koa-cors"));

var _koaStatic = _interopRequireDefault(require("koa-static"));

var _koaRouter = _interopRequireDefault(require("koa-router"));

var _svcDc = _interopRequireDefault(require("@iota-cn/svc-dc"));

var _svcRestful = _interopRequireDefault(require("@iota-cn/svc-restful"));

var _svcLogger = _interopRequireDefault(require("@iota-cn/svc-logger"));

var _svcSession = _interopRequireDefault(require("@iota-cn/svc-session"));

var _http = _interopRequireDefault(require("http"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

//from private npm
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

  const app = new _koa.default();

  const server = _http.default.createServer(app.callback());

  app.server = server; //init logger and inject it into app(app.iota.logger) and runtime ctx(ctx.iota.logger)

  app.use((0, _svcLogger.default)(app, config.logger));
  app.use(errorHandler());
  config.global = config.global || {};
  const router = config.global.prefix ? new _koaRouter.default({
    prefix: config.global.prefix
  }) : new _koaRouter.default();
  config = config || defaultConfig;
  app.keys = ["it is a secret"];
  config.cookie = config.cookie ? config.cookie : {};

  if (config.compress) {
    app.use((0, _koaCompress.default)(config.compress || {}));
  }

  app.use(rewriteCookie(config.cookie.prefix));
  app.use((0, _koaConvert.default)((0, _koaCors.default)(config.cors || {})));

  if (config.staticDirs && Array.isArray(config.staticDirs)) {
    config.staticDirs.forEach(s => {
      app.use((0, _koaStatic.default)(s));
    });
  }

  if (config.koaLogger) {
    app.use((0, _koaLogger.default)(config.koaLogger));
  }

  app.use((0, _svcSession.default)(config.session)); //@Todo add csrf protect. Require the client side login or ...
  //app.use(convert(csrf()));

  app.use((0, _koaBodyparser.default)({
    jsonLimit: '80mb',
    formLimit: '80mb'
  })); //init dc and inject it into app(app.iota.dc) and runtime ctx(app.iota.dc)
  //@Todo DC use router?

  app.use((0, _svcDc.default)(app, config.dc)); //init restful base on dc model.

  app.use((0, _svcRestful.default)(app, router, config.restful));
  config.mws.forEach(function (mv) {
    if (typeof mv.entry === 'function') {
      try {
        let opts = mv.opts || {}; // add global opts

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
  server.listen(port, config.host); //for test

  app.router = router;
  return app;
}

var _default = scaffold;
exports.default = _default;