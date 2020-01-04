import config, { COMPLEX_CONTAINER_ID, layoutContainerPlugin, rootContainerPlugin } from '@iota-cn/ui-scaffolding/src/config'

// 在脚手架基础上叠加配置，或修改配置，也可以完全重新配置，配置规格需要完整输出
// config.plugins.push({...})

rootContainerPlugin.opts.redirect = '/console'

// 此应用直接跳转到 signin 或者在 routes 中直接覆盖
layoutContainerPlugin.opts.simple.redirect = '/console'


const overviewId = 'app-overview'

const overviewPlugin = {
    plugin: require('./plugins/overview'), opts: {
        id: overviewId,
        containerId: COMPLEX_CONTAINER_ID,
        widgets: []  // 可以在代码中注入
    }
}

const flowableId = 'flowable'
const flowablePath = '/console/applications/flows'

const projectProcessPlugin = {
    plugin: require('@iota-cn/ui-scaffolding/src/plugins/apps/flowable'), opts: {
        id: flowableId, // 实例id
        containerId: COMPLEX_CONTAINER_ID,
        path: '/console/applications/flows'
    }
}

const communistPartyProcessPlugin = {
    plugin: require('./plugins/communist-party-process'), opts: {
        id: 'cpp_party',
        overviewId: overviewId,
        flowableId: flowableId,
        flowablePath: flowablePath,
        containerId: COMPLEX_CONTAINER_ID
    }
}

config.plugins.push(overviewPlugin)
config.plugins.push(projectProcessPlugin)
config.plugins.push(communistPartyProcessPlugin)

export default config