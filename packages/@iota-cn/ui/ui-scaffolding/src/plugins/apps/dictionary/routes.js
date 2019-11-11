import Dictionaries from "./view/Dictionaries";

export default (opts) => {
    const containerId = opts.containerId
    return {
        iota: {
            [containerId || 'container']: {
                dictionary: { // dictionary
                    overview: {
                        path: '/console/system/dictionaries',
                        component: {
                            mixins: [Dictionaries]
                        }
                    }
                }
            }
        }
    }
}
