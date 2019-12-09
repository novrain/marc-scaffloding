const Dictionaries = () => import("./view/Dictionaries")

export default (opts) => {
    const containerId = opts.containerId
    return {
        iota: {
            [containerId || 'container']: {
                dictionary: { // dictionary
                    path: '/console/system/dictionaries',
                    component: Dictionaries
                }
            }
        }
    }
}
