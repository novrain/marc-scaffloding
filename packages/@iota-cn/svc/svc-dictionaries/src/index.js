
import {
    dictionary,
    dictionary_item
} from './model'

import api from './api'

export function models(dc) {
    dictionary(dc)
    dictionary_item(dc)
}

export function entry(app, router, opts) {
    app.iota.logger.log('info', '[IOTA-dictionaries]', 'Inject dictionaries mw into router.');
    api(app, router, opts);
}
