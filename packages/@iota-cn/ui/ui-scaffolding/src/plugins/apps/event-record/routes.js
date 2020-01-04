const EventRecord = () => import('./view/EventRecord')

export default (opts) => {
    const containerId = opts.containerId
    return {
        iota: {
            [containerId || 'container']: {
                eventRecord: {
                    path: '/console/system/event_record',
                    component: EventRecord
                }
            }
        }
    }
}