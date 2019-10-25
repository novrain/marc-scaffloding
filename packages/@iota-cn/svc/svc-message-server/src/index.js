import message_center from './message_center';

export function entry(app, router, opts) {
    app.iota.logger.log('info', '[IOTA-NOTICE-SERVER]', 'Inject notice server');
    message_center(app, opts);
}