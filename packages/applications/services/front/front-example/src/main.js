import run from '@iota-cn/ui-scaffolding/src/runner'

// 应用提供 App（可以不提供，使用脚手架默认的） 与 config
import App from './App.vue'
import config from './config'

// 可以在启动前，做一些初始化工作，例如Vue.use定义一些全局组件等

// 启动
run({ config, App })