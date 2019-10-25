import pathToRegexp from 'path-to-regexp';

class ExcludesUrls {
    constructor(opts, prefix) {
        this.allUrls = undefined;
        this.reload(opts, prefix);
    }

    sanitizePath(path, prefix) {
        if (!path) return '/';
        if (prefix) {
            path = prefix + path;
        }
        return '/' + path
                .replace(/^\/+/i, '')//去掉开头的/
                .replace(/\/+$/, '')//去掉结尾的/
                .replace(/\/{2,}/, '/');//两个及以上的/变成一个/
    }

    reload(opts, prefix) {
        //load all url
        if (!this.allUrls) {
            this.allUrls = opts;
            let that = this;
            this.allUrls.forEach(function (url, i, arr) {
                if (typeof url === "string") {
                    url = {p: url, o: '*'};
                    arr[i] = url;
                }
                const keys = [];
                let eachPath = url.p;
                url.p = (!eachPath || eachPath === '(.*)' || (Object.prototype.toString.call(eachPath) == '[object RegExp]') ? eachPath : that.sanitizePath(eachPath, prefix));
                url.pregexp = pathToRegexp(url.p, keys);

            });
        }
    }

    isExcluded(path, method) {
        return this.allUrls.some(function (url) {
            return !url.auth
                && url.pregexp.test(path)
                && (url.o === '*' || url.o.indexOf(method) !== -1);
        });
    }
}


export default function (opts) {
    let excludeAll = false;
    let excludes = undefined;
    if (opts.exclude && opts.exclude === "*") {
        excludeAll = true;
    }
    let excludeOpts = [];
    if (!excludeAll) {
        excludeOpts = opts.exclude || [];
        excludeOpts.push({p: '/signin', o: 'POST'});
        excludeOpts.push({p: '/signout', o: 'POST'});
        excludeOpts.push({p: '/signup', o: 'POST'});
        excludeOpts.push({p: '/validations/usernames/validate', o: 'GET'});
        excludeOpts.push({p: '/validations/mobiles/validate', o: 'GET'});
        excludeOpts.push({p: '/validations/emails/validate', o: 'GET'});
        excludeOpts.push({p: '/validations/codes/validate', o: 'GET'});
        excludeOpts.push({p: '/validations/smses/validate', o: 'GET'});
        excludeOpts.push({p: '/accounts/password/forget', o: 'POST'});
        excludeOpts.push({p: '/accounts/email/active', o: 'POST'});
        excludeOpts.push({p: '/accounts/password/forget', o: 'GET'});
        excludeOpts.push({p: '/accounts/email/active', o: 'GET'});
        excludeOpts.push({p: '/accounts/password/change', o: 'POST'});
        excludeOpts.push({p: '/accounts/password/reset', o: 'POST'});
        excludeOpts.push({p: '/validations/codes', o: 'GET'});
        excludeOpts.push({p: '/validations/smses', o: 'POST'});
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
