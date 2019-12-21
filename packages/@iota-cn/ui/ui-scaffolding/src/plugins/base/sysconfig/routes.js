const Sysconfig = () => import('./view/Sysconfig')

export default (opts) => {
    const containerId = opts.containerId
    return {
        iota: {
            [containerId || 'container']: {
                sysconfig: { // sysconfig
                    path: '/console/system/sysconfig',
                    component: Sysconfig
                }
            }
        }
    }
}
