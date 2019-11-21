import config, { COMPLEX_CONTAINER_ID } from '@iota-cn/ui-scaffolding/src/config'

// 在脚手架基础上叠加配置，或修改配置，也可以完全重新配置，配置规格需要完整输出
// config.plugins.push({...})
config.plugins.push(
    {
        plugin: require('@iota-cn/ui-scaffolding/src/plugins/apps/flowable'), opts: {
            id: 'flowable', // 实例id
            containerId: COMPLEX_CONTAINER_ID,
            flows: [
                {
                    key: 'example',
                    path: '/console/flowable/example',
                    flowId: 'example',
                    flowFuncs: require('./flowable/funcs/example').default
                }
            ]
        }
    }
)

export default config