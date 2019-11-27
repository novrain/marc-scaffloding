
import {
    process_def
} from './model'

import api from './api'

export function models(dc) {
    process_def(dc)
}

export function entry(app, router, opts) {
    app.iota.logger.log('info', '[IOTA-bp-engines]', 'Inject bpmn processs engines mw into router.');
    return api(app, router, opts);
}
