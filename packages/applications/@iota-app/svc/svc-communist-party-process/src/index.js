
import {
    communist_party_process_category
} from './model'

import api from './api'

export function models(dc) {
    communist_party_process_category(dc)
}

export function entry(app, router, opts) {
    app.iota.logger.log('info', '[IOTA-CPP]', 'Inject communist_party_process_category mw into router.');
    api(app, router, opts);
}
