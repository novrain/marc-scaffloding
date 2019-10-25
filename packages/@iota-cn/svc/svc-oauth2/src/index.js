/**
 * Created by rain on 2016/7/28.
 */
import {oauth2Model, userAppModel} from './model';
import api from './api';

export function models(dc) {
    oauth2Model(dc);
    userAppModel(dc);
}

export function entry(app, router, opts) {
    app.iota.logger.log('info', '[IOTA-OAUTH2]', 'Inject OAuth2 mw into router.');
    api(app, router, opts);
}
