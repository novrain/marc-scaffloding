const Overview = () => import("./view/Overview")

export default (opts) => {
    const { id, containerId } = opts
    return {
        iota: {
            [containerId || 'container']: {
                redirect: '/console/overview', // 覆盖 console 的 默认 路由
                overview: {
                    path: '/console/overview',
                    component: Overview,
                    props: {
                        id: id || 'app-overview',
                        containerId: containerId,
                        widgets: opts.widgets,
                    }
                }
            }
        }
    }
}
