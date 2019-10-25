import Store from "./redisStore.js";

export default function (opts = {}) {
    opts.key = opts.key || "iota";
    opts.db = opts.db || { host: "127.0.0.1", port: '6379' };
    opts.store = opts.store || new Store(opts);

    return async function (ctx, next) {
        // inject
        ctx.iota = ctx.iota || {};
        ctx.iota.session = ctx.iota.session || {};
        ctx.iota.session.cache = opts.store;
        let id = ctx.cookies.get(opts.key, opts);
        if (!id) {
            let regex = /(Bearer )(\w+$)/;
            let auth = ctx.headers['authorization'];
            if (auth && regex.test(auth)) {
                let match = regex.exec(auth);
                id = match[2];
            }
        }

        if (!id) {
            ctx.session = {};
        } else {
            ctx.session = await opts.store.get(id);
            // check session should be a no-null object
            if (typeof ctx.session !== "object" || ctx.session == null) {
                ctx.session = {};
            }
        }

        let old = JSON.stringify(ctx.session);

        await next();

        // if not changed
        if (old == JSON.stringify(ctx.session)) return;


        // clear old session if exists
        if (id) {
            await opts.store.destroy(id);
            id = null;
        }

        // proxy model, use id from proxy target.
        if (ctx.session.proxy && ctx.session.id) {
            id = ctx.session.id;
        }

        //if oauth2 id === token
        if (ctx.session.oauth2) {
            id = ctx.session.token;
        }

        // set new session
        if (ctx.session && Object.keys(ctx.session).length) {
            let maxAge = opts.maxAge || 43200000; //3600*1000*12  12 hours
            let sid = await opts.store.set(Object.assign({ maxAge: maxAge }, ctx.session), Object.assign({}, opts, { sid: id }));
            //trick
            if (!ctx.session.oauth2 && !(ctx.session.proxy && ctx.session.id)) {
                ctx.cookies.set(opts.key, sid, Object.assign({ httpOnly: false, maxAge: maxAge - 60 * 5 * 1000 }, opts));
            }
        }
    }
}