## 关于

一个轻量管理系统快速开发脚手架，前后端采用Javascript，容易上手；同时前后端都采用了模块化的组织方式（后端采用npm包划分模块，前端目前还使用合一方式，理论上一样可拆分），可通过简单的配置和启动器，将模块整合为一个多功能的管理系统，从而是的功能模块可以灵活组合，也可以灵活扩展和替换，这样可以解决多个项目共享和管理的问题。

工程采用monorepo管理方式，避免了拆分多个包的管理复杂性。

已实现功能：

- 用户认证
	- 基本的认证功能
	- 密码找回
	- 邮箱激活
- 权限管理
	- 全功能的RABC模型；用户/角色/职位/组织
	- 菜单与操作权限细分
	- 封装前端的操作权限校验
- 系统管理
  - 系统设置
  - 字典管理
- 工作流整合
	- 基于[flowable](https://flowable.org/ "flowable")，结合权限管理，基本实现了通用的工作流（这部分对flowable有一定fork修改，暂未实现流程定义和表单定义，需要独立运行flowable服务，采用HTTP接口交互）
- 系统通知（消息中心服务）

主要的基础依赖：

- 前端
	- [Vue](https://vuejs.org/ "Vue")/[Vuex](https://vuex.vuejs.org/ "Vuex")/[Vue-Router](https://router.vuejs.org/ "Vue-router")
	- [Ant Design of Vue](https://www.antdv.com/docs/vue/introduce/ "Ant Design of Vue") （之前使用了较多的React版本，上手比较快，部分功能也能从原来的代码中迁移过来，所以选择了它）
	- [Vue i18n](https://kazupon.github.io/vue-i18n/ "Vue i18n")
	- [axios](https://github.com/axios/axios "axios")
	- [ncform](https://github.com/ncform/ncform "ncform") (通用表单，主要是计划在工作流中深入使用，[UFrom](https://uformjs.org/ "Ufrom") 快要发布v1，也是个选择，但目前还没有vue版本)
	- [element-ui](https://element.eleme.cn/#/zh-CN "element-ui") (ncform 有 elemenmt-ui 的实现)
- 后端
	- [koa](https://koajs.com/ "koajs")
	- koa基础中间件
		- koa-bodyparser
		- koa-compress
		- koa-convert
		- koa-cors
		- koa-csrf
		- koa-logger
		- koa-router
		- koa-static
	- [sequelize](https://sequelize.org/ "sequelize")
	- [PostgreSQL](https://www.postgresql.org/ "postgresql")
	- [nyc-istanbul](https://istanbul.js.org/ "istanbul")/[mocha](https://mochajs.org/ "mochajs")

### 模块组织方式

#### 后端

后端基本上借鉴了koa的中间件方式，因此非常简单，易于理解。模块需要实现两个入口：

- 路由中间件注入入口：通过倒置的方式，将本模块实现的功能（全局或会话）、路由接口添加到脚手架传递过来的app（koa实例）和router（koa-router实例）中去，最后脚手架负责整合
- 模型注入入口：将本模块的表模型定义好后，注入到传递过来的dc（sequlize实现）中去
- 启动器通过一个配置入口，调用多个模块提供的入口，将模块整合启动

模块入口

```

...

/**
* 模型定义
*/
export function models(dc) {
    user(dc);
    sub_user(dc);
}

/**
* 路由和中间件
*/
export function entry(app, router, opts) {
    app.iota.logger.log('info', '[IOTA-USER]', 'Inject user mw into router.');
    app.iota = app.iota || {};
    //提供 通用方法 && 回调注入
    app.iota.user = app.iota.user || {
        encrypt,
        create,
        update,
        changePassword,
        hooks: {
            afterCreate: new Mmw(),
            afterUpdate: new Mmw()
        }
    };

	// 注册路由
    router = api(app, router, opts);
    // 返回一个中间件，在ctx上下文里提供本模块暴露的功能接口
    return async function (ctx, next) {
        ctx.iota = ctx.iota || {};
        ctx.iota.user = app.iota.user;
        await next();
    }
}

```

配置入口

```
...

    const userEntry = require('@iota-cn/svc-user').entry
    const userModel = require('@iota-cn/svc-user').models
    const user = { entry: userEntry, opts: {} }
    config.mws.push(user)
    config.dc.models.push(userModel)
...

```


启动器


```
...
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
            } catch (err) {
                //be sure that the logger middleware is injected.
                app.iota.logger.log('error', '[iOTA-app]', err)
            }
        }
    });

...

```

#### 前端

前端则依赖Vuex、Vue-router实现模块的拆分与整合，也易于理解，没有做过多的二次封装，启动只是负责调用模块的入口，并将模块提供的store、route、locale等按照对象层次结构转换为Vuex、Vue-router所需要的数据接口，从而实现模块整合。模块入口实现：

- 提供Vuex的store（模块化或者全局的，按模块特性提供，并且是层次化的Object，类似Java的package，实现隔离和避免命名冲突，这其实就是Vuex本身的实现）
- 提供Route
- 入口也可以注入全局组件，Vue原型扩展

模块入口

```
import store from './store'
import routes from './routes'

const entry = (opts) => {
    opts.complex = opts.complex || {}
    const theStore = store(opts)
    return {
        store: theStore,
        routes: routes(opts)
    }
}

export {
    entry
}

其中store按照Vuex的方式组织即可；routes按照Vue-router方式组织；均需要按照层次化的方式来组织。
参考：
packages\@iota-cn\ui\ui-scaffolding\src\framework\layout-container\store\index.js
packages\@iota-cn\ui\ui-scaffolding\src\framework\layout-container\routes.js

```

配置入口

```

export const layoutContainerPlugin = {
    plugin: require('./framework/layout-container'), opts: {
        simple: { // 简单页面，用于包裹简单的登录、404等页面 
            logo: '/assets/imgs/logo.png',  // 放置在静态目录页面
            background: '/assets/imgs/bg.png',
            copyright: '@2015-2019',
            path: SIMPLE_CONTAINER_PATH
        },
        complex: {
            type: 'console',
            id: COMPLEX_CONTAINER_ID,
            path: COMPLEX_CONTAINER_PATH,
            redirectTo: '/app/signin',
            // 覆盖内部配置
            layout: {
                console: {
                    left: {
                        top: {
                            defaultLogo: '/assets/imgs/defaultLogo.png',
                            defaultLogoCollapsed: '/assets/imgs/defaultLogoCollapsed.png',
                        }
                    }
                }
            }
        },
        // messageCenter: {
        //     port: '18884',
        //     nsp: 'iota'
        // }
    }
}

其中 opts 是模块暴露的配置项，在配置入口中统一管理。

```

启动器

```
 // AppLoader.load
 load = () => {
    let store = {
        strict: debug,
        plugins: debug ? [createLogger()] : []
    }
    let routes = {}
    let messages = {}
    if (Array.isArray(this.config.plugins)) {
        this.config.plugins.forEach(p => {
            let { store: pluginStore, routes: pluginRoutes, messages: pluginMessages } = typeof p.plugin.entry === 'function' ? p.plugin.entry(p.opts) : p.plugin
            if (pluginStore) store = merge(store, pluginStore)
            if (pluginRoutes) routes = merge(routes, pluginRoutes)
            messages = merge(messages, pluginMessages || {})
        })
    }

    routes = AppLoader.convertToVueRoutes(routes)
    return { store, routes: Array.isArray(routes) ? routes : [routes], messages }
}

const appLoader = new AppLoader(config || defaultConfig)
    const { store, routes, messages } = appLoader.load()

    const i18n = new VueI18n({
        locale: Vue.config.locale || 'zh-cn',
        fallbackLocale: 'zh-cn',
        messages: messages ? merge(messages, FrameComponents.messages) : FrameComponents.messages
    })

    new Vue({
        router: new Router({ routes, mode: 'history' }),
        store: new Vuex.Store(store),
        render: h => h(App || defaultApp),
        i18n
    }).$mount('#app')
```

### 环境初始化

#### 安装包管理工具 yarn 和 lerna

```

npm i -g yarn  
npm i -g lerna

```

#### 下载代码，初始化

```
lerna bootstrap
lerna run compile
```

#### 目录结构

```
node_modules
packages
  @iota-cn
    svc         // 服务侧包，包含脚手架
    ui          // 客户端包，包含脚手架
    util        // 公共包
  @iota-fork    // 修改的第三方包
    epilogue    // 修改支持 koa 
    kafka-node  // 解决Windows的编译
    sequelize   // 升级到v5，修改保留对v3的部分兼容
  applications  // 应用目录
    services
        back    // 整合服务侧相关包输出的独立应用服务端
        front   // 整合客户端相关包输出的独立应用客户端，与某应用服务端对应

```

#### 例子

客户端
```
目录(不需要切换)
packages/applications/services/front/front-example

lerna run --stream --scope @iota-app/front-example serve
```

```
客户端也支持使用 vue-ui 方式管理
npm i -g @vue/cli
vue ui
添加项目，@iota-app/front-example所在目录，任务下执行serve启动项目即可。
```

服务端
```
数据库
目前支持PostgreSql，需要创建数据库，默认:
postgres://postgres:ROOT@localhost:5433/back-example

也可以通过启动命令指定：
lerna exec "node index.js --help" --scope=@iota-app/back-example --stream
@iota-app/back-example: Usage: index [options]
@iota-app/back-example: Options:
@iota-app/back-example:   -h, --host [value]             server host
@iota-app/back-example:   -p, --port [value]             server port
@iota-app/back-example:   -d, --domain [value]           api domain
@iota-app/back-example:   -u, --ui-domain [value]        ui domain
@iota-app/back-example:   -m, --message-center [value]   iota message center
@iota-app/back-example:   -g, --postgres [value]         postgres connection url
@iota-app/back-example:   -r, --redis-host [value]       redis server host
@iota-app/back-example:   -t, --redis-port [value]       redis server port
@iota-app/back-example:   -n, --attachment-in-cloud      store attachment in cloud
@iota-app/back-example:   -l, --attachment-in-cloud-dev  store attachment in cloud dev
@iota-app/back-example:   -v, --verbose                  show debug info of dc and others
@iota-app/back-example:   -h, --help                     output usage information

数据库初始化：
lerna run --stream --scope @iota-app/back-example testbreak
或
执行 packages\applications\services\back\back-example\db\create.sql 

目录(不需要切换)：
packages/applications/services/back/back-example

启动：
lerna run --stream --scope @iota-app/back-example serve

访问：
http://localhost:8080/app/signin
```
