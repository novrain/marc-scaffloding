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
            },
            {
                component: 'ii-flowable-widage',
                props: {
                    flowId: 'minor_repair',
                    flowHelper: require('./plugins/flowable/helpers/cppf').default,
                    redirect: '/console/applications/minor_repair'
                }
            },
            {
                component: 'ii-flowable-widage',
                props: {
                    flowId: 'monthly_routine_task',
                    flowHelper: require('./plugins/flowable/helpers/cppf').default,
                    redirect: '/console/applications/monthly_routine_task'
                }
            },
            {
                component: 'ii-flowable-widage',
                props: {
                    flowId: 'temporary_task',
                    flowHelper: require('./plugins/flowable/helpers/cppf').default,
                    redirect: '/console/applications/temporary_task'
                }
            },
            {
                component: 'ii-flowable-widage',
                props: {
                    flowId: 'cpp_party_construction',
                    flowHelper: require('./plugins/flowable/helpers/cppf').default,
                    redirect: '/console/applications/cpp_party_construction'
                }
            },
            {
                component: 'ii-flowable-widage',
                props: {
                    flowId: 'cpp_temporary_task',
                    flowHelper: require('./plugins/flowable/helpers/cppf').default,
                    redirect: '/console/applications/cpp_temporary_task'
                }
            }
        ]
    }
}

const projectProcessPlugin = {
    plugin: require('@iota-cn/ui-scaffolding/src/plugins/apps/flowable'), opts: {
        id: 'project_of_year', // 实例id
        containerId: COMPLEX_CONTAINER_ID,
        flows: [
            {
                path: '/console/applications/project_of_year',
                flowId: 'project_of_year',
                flowHelper: require('./plugins/flowable/helpers/project_of_year').default
            },
            {
                path: '/console/applications/minor_repair',
                flowId: 'minor_repair',
                flowHelper: require('./plugins/flowable/helpers/cppf').default
            },
            {
                path: '/console/applications/monthly_routine_task',
                flowId: 'monthly_routine_task',
                flowHelper: require('./plugins/flowable/helpers/cppf').default
            },
            {
                path: '/console/applications/temporary_task',
                flowId: 'temporary_task',
                flowHelper: require('./plugins/flowable/helpers/cppf').default
            }
        ]
    }
}


const communistPartyProcessPlugin = {
    plugin: require('./plugins/communist-party-process'), opts: {
        id: 'cpp_party_construction',
        containerId: COMPLEX_CONTAINER_ID,
        flows: [
            {
                path: '/console/applications/cpp_party_construction',
                flowId: 'cpp_party_construction',
                flowHelper: require('./plugins/flowable/helpers/cppf').default
            },
            {
                path: '/console/applications/cpp_temporary_task',
                flowId: 'cpp_temporary_task',
                flowHelper: require('./plugins/flowable/helpers/cppf').default
            }
        ]
    }
}

config.plugins.push(overviewPlugin)
config.plugins.push(projectProcessPlugin)
config.plugins.push(communistPartyProcessPlugin)

export default config