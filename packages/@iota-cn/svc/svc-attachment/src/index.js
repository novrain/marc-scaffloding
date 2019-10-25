import api from './api';

export function models(dc) {

}

export function entry(app, router, opts) {
    app.iota.logger.log('info', '[IOTA-ATTACHMENT]', 'Inject attachment mw into router.');
    api(app, router, opts);
}
