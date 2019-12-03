import Overview from "./view/Overview";

export default (opts) => {
    const containerId = opts.containerId
    return {
        iota: {
            [containerId || 'container']: {
                redirect: '/console/overview', // 覆盖 console 的 默认 路由
                overview: {
                    path: '/console/overview',
                    component: {
                        mixins: [Overview]
                    },
                    props: { widages: opts.widages }
                }
            }
        }
    }
}
