import config, { COMPLEX_CONTAINER_ID, layoutContainerPlugin, rootContainerPlugin } from '@iota-cn/ui-scaffolding/src/config'

// 在脚手架基础上叠加配置，或修改配置，也可以完全重新配置，配置规格需要完整输出
// config.plugins.push({...})

rootContainerPlugin.opts.redirect = '/console'

// 此应用直接跳转到 signin 或者在 routes 中直接覆盖
layoutContainerPlugin.opts.simple.redirect = '/console'

const overviewPlugin = {
    plugin: require('./plugins/overview'), opts: {
        containerId: COMPLEX_CONTAINER_ID,
        widages: [
            {
                component: 'ii-flowable-widage',
                props: {
                    flowId: 'project_of_year',
                    flowHelper: require('./plugins/flowable/helpers/project_of_year').default,
                    redirect: '/console/applications/project_of_year'
                }
            }
        ]
    }
}

const projectOfYearProcessPlugin = {
    plugin: require('@iota-cn/ui-scaffolding/src/plugins/apps/flowable'), opts: {
        id: 'project_of_year', // 实例id
        containerId: COMPLEX_CONTAINER_ID,
        flows: [
            {
                key: 'project_of_year',
                path: '/console/applications/project_of_year',
                flowId: 'project_of_year',
                flowHelper: require('./plugins/flowable/helpers/project_of_year').default
            }
        ]
    }
}

const communistPartyProcessPlugin = {
    plugin: require('./plugins/communist-party-process'), opts: {
        containerId: COMPLEX_CONTAINER_ID,
        flow: {
            flowId: 'cppf',
            flowHelper: require('./plugins/flowable/helpers/cppf').default
        }
    }
}

config.plugins.push(overviewPlugin)
config.plugins.push(projectOfYearProcessPlugin)
config.plugins.push(communistPartyProcessPlugin)

export default config