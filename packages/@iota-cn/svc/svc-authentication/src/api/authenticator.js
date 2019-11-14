import { ExcludesUrls } from '@iota-cn/svc-util'

export default function (opts) {
    let excludeAll = false;
    let excludes = undefined;
    if (opts.exclude && opts.exclude === "*") {
        excludeAll = true;
    }
    let excludeOpts = [];
    if (!excludeAll) {
        excludeOpts = opts.exclude || [];
        excludeOpts.push({ p: '/signin', o: 'POST' });
        excludeOpts.push({ p: '/signout', o: 'POST' });
        excludeOpts.push({ p: '/signup', o: 'POST' });
        excludeOpts.push({ p: '/validations/usernames/validate', o: 'GET' });
        excludeOpts.push({ p: '/validations/mobiles/validate', o: 'GET' });
        excludeOpts.push({ p: '/validations/emails/validate', o: 'GET' });
        excludeOpts.push({ p: '/validations/codes/validate', o: 'GET' });
        excludeOpts.push({ p: '/validations/smses/validate', o: 'GET' });
        excludeOpts.push({ p: '/accounts/password/forget', o: 'POST' });
        excludeOpts.push({ p: '/accounts/email/active', o: 'POST' });
        excludeOpts.push({ p: '/accounts/password/forget', o: 'GET' });
        excludeOpts.push({ p: '/accounts/email/active', o: 'GET' });
        excludeOpts.push({ p: '/accounts/password/change', o: 'POST' });
        excludeOpts.push({ p: '/accounts/password/reset', o: 'POST' });
        excludeOpts.push({ p: '/validations/codes', o: 'GET' });
        excludeOpts.push({ p: '/validations/smses', o: 'POST' });
        let prefix;
        if (opts && opts.global && opts.global.prefix) {
            prefix = opts.global.prefix;
        }
        excludes = new ExcludesUrls(excludeOpts, prefix);
    }

    async function authenticator(ctx, next) {
        ctx.iota.logger.log('debug', '[IOTA-AUTH][AUTH]', ctx.path, ctx.method);
        if (ctx.session.authed
            || excludeAll
            || excludes.isExcluded(ctx.path, ctx.method)) {
            await next();
        } else {
            if (opts && opts.signinUrl) {
                ctx.redirect(opts.signinUrl);
            } else {
                ctx.status = 401;
                ctx.body = {
                    name: 'unauthorized error',
                    message: 'authentication is required but has failed or has not yet been provided.',
                    detail: 'you may need to log in'
                };
            }
        }
    }

    return authenticator;
}
