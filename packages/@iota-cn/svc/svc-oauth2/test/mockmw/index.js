export function entry(app, router, opts) {
    app.iota.logger.log('info', '[IOTA-MOCK-MW]', 'Inject a mock middleware into router.');
    return async function (ctx, next) {
        ctx.iota.auth = {
            signin: async function (ctx) {
                ctx.status = 200;
            },
            signup: async function (ctx) {
                ctx.status = 200;
            }
        }
    }
}