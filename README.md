### 环境初始化

#### 安装包管理工具 yarn 和 lerna

```

npm i -g yarn  
npm i -g lerna

```

其中，yarn 可以用用[`安装包`](https://yarnpkg.com/zh-Hans/docs/install)安装。

#### 下载代码，初始化

```
git clone git@build.chuanyang100.com:iota/projects-repo.git

cd projects-repo
lerna bootstrap
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
  applications  // 应用目录
    services
        back    // 整合服务侧相关包输出的独立应用服务端
        front   // 整合客户端相关包输出的独立应用客户端，与某应用服务端对应

```

#### 例子

待补充（或直接基于某个具体项目描述）:
1. 前后端模块
2. 需要数据库的初始化
3. 前端与后端的实际接口调用

客户端
```
目录(不需要切换)
packages/applications/services/front/front-example

lerna run --stream --scope @iota-cn/front-example serve
```

```
客户端也支持使用 vue-ui 方式管理
npm i -g @vue/cli
vue ui
添加项目，@iota-cn/front-example所在目录，任务下执行serve启动项目即可。
```

服务端
```
目录(不需要切换)：
packages/applications/services/back/back-example

启动：
lerna run compile
lerna run --stream --scope @iota-cn/back-example serve

访问：
http://localhost:8080/app/signin
```