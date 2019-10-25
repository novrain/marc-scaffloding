import io from 'socket.io-client';

export function entry(app, router, opts) {
    app.iota.logger.log('info', '[IOTA-NOTICE-CLIENT]', 'Inject notice client');
    let socketClient;
    socketClient = io.connect(opts.url || 'http://localhost:5001');
    let send = (message) => {
        try {
            // socketClient.emit('message', message);
            switch (message.method) {
                case 'broadcast':
                    socketClient.emit('broadcast', message);
                    break;
                case 'unicast':
                    let receiver = message.receiver;
                    //兼容单个和数组形式
                    if (!Array.isArray(receiver)) {
                        receiver = [receiver];
                    }
                    for (let i = 0; i < receiver.length; i++) {
                        let m = Object.assign({}, message);
                        m.receiver = receiver[i];
                        socketClient.emit('unicast', m);
                    }
                    break;
                default:
                    app.iota.logger.log('error', '[IOTA-MESSAGE-CLIENT]', 'unknown message send method type.');
            }
        } catch (e) {
            app.iota.logger.log('error', '[IOTA-MESSAGE-CLIENT]', e.stack);
        }
    };
    app.iota.message = app.iota.message || {};
    app.iota.message.send = send;
    return async function (ctx, next) {
        ctx.iota.message = ctx.iota.message || {};
        ctx.iota.message.send = send;
        await next();
    }
}