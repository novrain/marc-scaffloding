function createConfig(args) {
    args = args || {}
    const config = require('@iota-cn/svc-scaffolding/dist/config').default
    config.host = args.host || process.env.IOTA_SERVER_HOST || '0.0.0.0'
    config.port = args.port || process.env.IOTA_SERVER_PORT || 9091

    //redis seperate db.
    const redisConfig = {
        host: args.redisHost || process.env.IOTA_REDIS_SERVER_HOST || "localhost",
        port: args.redisPort || process.env.IOTA_REDIS_SERVER_PORT || "6379"
    }

    const sessionRedis = Object.assign({ db: 0 }, redisConfig)
    const consoleRedis = Object.assign({ db: 2 }, redisConfig)

    const verbose = typeof args.verbose !== 'undefined' ? !!args.verbose :
        (typeof process.env.IOTA_VERBOSE !== 'undefined' ? !!process.env.IOTA_VERBOSE : false)

    const runInPod = typeof args.runInPod !== 'undefined' ? !!args.runInPod :
        (typeof process.env.IOTA_ORCHESTRATOR_RUN_IN_POD !== 'undefined' ? !!process.env.IOTA_ORCHESTRATOR_RUN_IN_POD : false)

    config.dc.orm.opts = { logging: verbose }
    config.dc.orm.url = args.postgres || process.env.IOTA_POSTGRES || "postgres://postgres:ROOT@localhost:5433/back-example"
    //config.dc.mqtt = {broker: 'mqtt://127.0.0.1:1883', reconnectPeriod: 10000}
    config.dc.cache = consoleRedis
    config.session.db = sessionRedis
    config.cookie = { prefix: 'ii-' }
    config.cors.origin = true  // 最终合理配置
    config.global = { console: {} }
    config.global.prefix = '/v1/api'
    config.global.console.domain = args.domainConsole || process.env.IOTA_DOMAIN || 'http://localhost:9070'
    config.staticDirs = ['./static']

    const userEntry = require('@iota-cn/svc-user').entry
    const userModel = require('@iota-cn/svc-user').models
    const authenticationEntry = require('@iota-cn/svc-authentication').entry
    const authorizationEntry = require('@iota-cn/svc-authorization').entry
    const authorizationModel = require('@iota-cn/svc-authorization').models
    const rbacEntry = require('@iota-cn/svc-rbac').entry
    const rbacModel = require('@iota-cn/svc-rbac').models
    const attachmentEntry = require('@iota-cn/svc-attachment').entry
    const oauth2Entry = require('@iota-cn/svc-oauth2').entry
    const oauth2Model = require('@iota-cn/svc-oauth2').models

    const noticeEntry = require('@iota-cn/svc-notice').entry
    const noticeModel = require('@iota-cn/svc-notice').models
    const messageClientEntry = require('@iota-cn/svc-message-client').entry

    const dictionariesEntry = require('@iota-cn/svc-dictionaries').entry
    const dictionariesModel = require('@iota-cn/svc-dictionaries').models

    const bpEnginesEntry = require('@iota-cn/svc-bp-engines').entry
    const bpEnginesModel = require('@iota-cn/svc-bp-engines').models

    const user = { entry: userEntry, opts: {} }
    const authentication = {
        entry: authenticationEntry,
        opts: {
            notAllowRegistry: true,
            dev: false,
            exclude: [
                { p: '/signin/wechat', o: 'GET' },
                { p: '/signin/wechat/binding', o: 'POST' },
                { p: '/signin/wechat/signup', o: 'POST' },
                { p: '/oauth2/token', o: 'POST' },
                { p: '/oauth2/third_parties/wechat', o: 'GET' },
                { p: '/oauth2/third_parties/wechat/signin', o: 'POST' },
                { p: '/oauth2/third_parties/wechat/signup', o: 'POST' },
            ],
            remMaxAge: 30,
            redirect: {
                activeEmailError: '/email/activation/error',
                activeEmailSuccess: '/email/activation/success',
                resetPwdInvalid: '/signin/reset/password/error',
                resetPwd: '/signin/reset/password',
                resetPwdError: '/signin/reset/password/error',
                signinUrl: '/signin'
                //resetPwdSuccess: '/signin/reset/password/success'
            }
        }
    }
    const authorization = { entry: authorizationEntry, opts: {} }
    const rbac = { entry: rbacEntry, opts: {} }
    const oauth2 = {
        entry: oauth2Entry,
        opts: {
            notAllowRegistry: true,
            tokenApi: 'https://api.weixin.qq.com/sns/oauth2/access_token?appid=%s&secret=%s&code=%s&grant_type=authorization_code',
            appid: 'wx5849e7b79af8f5de',
            secret: '378fb28f504099e1c0b27e26fe8557a3',
            userApi: 'https://api.weixin.qq.com/sns/userinfo?access_token=%s&openid=%s',
            oauth2: {
                redirect: {
                    wxerror: '/oauth2/third_parties/wechat/error',
                    wxnew: '/oauth2/third_parties/wechat/signup',
                    index: '/console',
                    binding: '/console/user/profile?key=4',
                    wxauto: '/oauth2/third_parties/wechat/auto',
                }
            }
        }
    }
    const notice = { entry: noticeEntry, opts: {} }
    const attachment = { entry: attachmentEntry, opts: {} }

    const messageClient = {
        entry: messageClientEntry,
        opts: {
            url: `${args.messageCenter || process.env.IOTA_MESSAGE_CENTER || 'http://localhost:5001'}/back-example`
        }
    }

    const dictionaries = {
        entry: dictionariesEntry,
        opts: {}
    }

    const bpEngines = {
        entry: bpEnginesEntry,
        opts: {
            routes: ['/fl/process/*', '/fl/content/*'],
            target: 'http://localhost:8888'
        }
    }

    //entry
    config.mws.push(user)
    config.mws.push(authentication)
    config.mws.push(rbac)
    config.mws.push(oauth2)
    config.mws.push(notice)
    config.mws.push(attachment)
    config.mws.push(messageClient)
    config.mws.push(dictionaries)
    config.bodyParser.disable = [
        { p: /^\/fl\/process\/.*(?:\/)?$/, o: '*' },
        { p: /^\/fl\/content\/.*(?:\/)?$/, o: '*' },
    ]
    config.mws.push(bpEngines)

    //models
    config.dc.models.push(userModel)
    config.dc.models.push(rbacModel)
    config.dc.models.push(oauth2Model)
    config.dc.models.push(noticeModel)
    config.dc.models.push(dictionariesModel)
    config.dc.models.push(bpEnginesModel)

    return config
}

exports = module.exports = createConfig