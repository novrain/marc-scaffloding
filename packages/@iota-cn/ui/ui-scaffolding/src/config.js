// 定义控制台的ID和路径（layout-container是支持多个complex部分的，需增加plugin定义）
const COMPLEX_CONTAINER_ID = 'console'
const COMPLEX_CONTAINER_PATH = 'console'
const SIMPLE_CONTAINER_PATH = 'app' // vue-router 多层 / 时，优先使用了深层次的 路由，所以必须区分开

module.exports = {
    cookie: {
        prefix: 'ii-'
    },
    plugins: [
        {
            plugin: require('./framework/root'), opts: {}
        },
        {
            plugin: require('./framework/layout-container'), opts: {
                simple: { // 简单页面，用于包裹简单的登录、404等页面 
                    logo: '/assets/imgs/logo.png',  // 放置在静态目录页面
                    background: '/assets/imgs/bg.png',
                    copyright: '@2015-2017 以太数据 版权所有 苏ICP备:16022233号',
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
                messageCenter: {
                    port: '18884',
                    nsp: 'iota'
                }
            }
        },
        {
            plugin: require('./framework/general-pages'), opts: { // 404 等
                parents: [
                    { path: 'iota', props: { link: '/' } },  // root page
                    { path: `iota/${SIMPLE_CONTAINER_PATH}`, props: { link: `${SIMPLE_CONTAINER_PATH}` } },
                    { path: `iota/${COMPLEX_CONTAINER_PATH}`, props: { link: `/${COMPLEX_CONTAINER_PATH}` } },
                ]
            }
        },
        {
            plugin: require('./plugins/base/rbac'), opts: {
                id: 'rbac', // 实例id
                containerId: COMPLEX_CONTAINER_ID
            }
        },
        {
            plugin: require('./plugins/base/authentication'), opts: {
                signin: {
                    redirect: '/console'
                },
                containerId: COMPLEX_CONTAINER_ID
            }
        },
        {
            plugin: require('./plugins/apps/dictionary'), opts: {
                id: 'dictionary', // 实例id
                containerId: COMPLEX_CONTAINER_ID
            }
        }
    ]
}