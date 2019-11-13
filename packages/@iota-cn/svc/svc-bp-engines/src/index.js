
import {
    process_def
} from './model'

import api from './api'

export function models(dc) {
    process_def(dc)
}

export function entry(app, router, opts) {
    app.iota.logger.log('info', '[IOTA-dictionaries]', 'Inject dictionaries mw into router.');
    api(app, router, opts);
}
