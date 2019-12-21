
import {
    sysconfig
} from './model'

import api from './api'

export function models(dc) {
    sysconfig(dc)
}

export function entry(app, router, opts) {
    app.iota.logger.log('info', '[IOTA-sysconfig]', 'Inject sysconfig mw into router.');
    api(app, router, opts);
}
