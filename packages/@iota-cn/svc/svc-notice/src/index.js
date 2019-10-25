import api from './api';
import * as model from './model';

export function models(dc) {
    model.NoticeType(dc);
    model.Notice(dc);
    model.UserNotice(dc);
    
}

export function entry(app, router, opts) {
    app.iota.logger.log('info', '[IOTA-NOTICE]', 'Inject notice mw into router.');
    api(app, router, opts);
}
