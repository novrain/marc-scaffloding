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
  services
    back        // 整合服务侧相关包输出的独立应用服务端
    front       // 整合客户端相关包输出的独立应用客户端

```

#### 例子

前置条件待补充。

客户端
```
目录(不需要切换)
packages/services/front/front-example

lerna run --scope @iota-cn/front-example serve
```

服务端
```
目录(不需要切换)：
packages/services/back/back-example

启动：
lerna run compile
lerna run --scope @iota-cn/back-example serve
```