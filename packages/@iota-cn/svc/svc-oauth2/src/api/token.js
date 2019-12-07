import { Buffer } from 'buffer';
import crypto from 'crypto';

function sha256() {
    const buf = crypto.randomBytes(256);
    let sha1hash = crypto.createHash('sha256');
    return sha1hash.update(buf).digest('hex');
}

function createToken() {
    return sha256();
}

function checkRequest(fn, requiredGrantType, defaultStatus = 401, defaultBody = {
    name: 'authenticity_token_error',
    message: "Unable to verify your credentials"
}) {
    return async (ctx, next) => {
        let authorization,
            contentType,
            key,
            secret,
            req,
            body = defaultBody,
            status = defaultStatus,
            regex = /(Basic )(\w+$)/,
            splitRegex = /(\w+):(\w+$)/,
            request,
            grantType;
        req = ctx.req;
        request = ctx.request;
        grantType = req.body ?
            (req.body['grant_type'] ? req.body['grant_type'] : (request.body ? request.body['grant_type'] : undefined)) :
            (request.body ? request.body['grant_type'] : undefined);
        authorization = req.headers['authorization'];
        contentType = req.headers['content-type'];
        if (authorization &&
            regex.test(authorization) &&
            contentType === 'application/x-www-form-urlencoded;charset=UTF-8' &&
            grantType === requiredGrantType) {
            var match = regex.exec(authorization);
            authorization = Buffer.from(match[2], 'base64').toString();
            if (splitRegex.test(authorization)) {
                match = splitRegex.exec(authorization);
                key = match[1];
                secret = match[2];
                let user = await ctx.iota.dc.models.User.findOne({
                    where: {
                        key: key,
                        secret: secret
                    }
                });
                if (!user) {
                    let app = await ctx.iota.dc.models.UserApp.findOne({
                        where: {
                            key: key,
                            secret: secret
                        }
                    });
                    user = !!app ? await ctx.iota.dc.models.User.findOne({
                        where: {
                            id: app.userId
                        }
                    }) : undefined;
                }
                if (user) {
                    ctx.iota.oauth2 = { user: user };
                    await fn(ctx, next);
                } else {
                    ctx.status = status;
                    ctx.body = body;
                }
            }
        } else {
            ctx.status = status;
            ctx.body = body;
        }
    }
}

async function access(ctx, next) {
    const cache = ctx.iota.dc.cache;
    const models = ctx.iota.dc.models;
    let token,
        refresh;
    ctx.session.authed = true;
    ctx.session.user = ctx.iota.oauth2.user.get({ plain: true });
    //todo inner app and other app 区分？
    ctx.session.maxAge = 30 * 24 * 3600 * 1000; //30天
    ctx.status = 200;
    token = createToken();
    refresh = createToken();
    ctx.body = {
        "access_token": token,
        "token_type": "bearer",
        "expires_in": ctx.session.maxAge,
        "refresh_token": refresh
    };
    //special for iota session
    ctx.session.oauth2 = true;
    ctx.session.token = token;
    ctx.session.authorization = ctx.request.headers['authorization'];
    // @TRICK load account and service info for limiter
    try {
        if (models.Account && models.AccountServicePackage) {
            let account = await models.Account.findOne({ where: { userId: ctx.session.user.id } });
            ctx.session.service = await models.AccountServicePackage.findOne({
                where: {
                    accountId: account.id
                },
                attributes: ['endTime', 'specification']
            });
            if (ctx.session.service) {
                ctx.session.service = ctx.session.service.get({ plain: true });
            }
        }
    } catch (err) { }
    //cache refresh token
    await cache.extra(`refresh_token=${refresh}`, token, 'PX', ctx.session.maxAge + 24 * 36 * 1000); //one more day.
}

async function refresh(ctx, next) {
    const cache = ctx.iota.dc.cache;
    let refresh_token = ctx.request.body.refresh_token;
    refresh_token = `refresh_token=${refresh_token}`;
    const access_token = await cache.get(refresh_token);
    if (refresh_token && access_token) {
        await access(ctx, next);
        await cache.delete(refresh_token);
    } else {
        ctx.status = 400;
        ctx.body = {
            name: 'invalid request',
            message: 'invalid refresh token, maybe expired.'
        };
    }
}

async function invalidate(ctx, next) {
    const access_token = ctx.request.body.access_token;
    const authorization = ctx.request.headers['authorization'];
    const cache = ctx.iota.session.cache;
    const token = await cache.get(access_token);
    if (token.token === access_token && token.authorization === authorization) {
        ctx.status = 204;
        await cache.destroy(access_token);
    } else {
        ctx.status = 400;
        ctx.body = {
            name: 'invalid request',
            message: 'invalid access token'
        };
    }
};

let accessToken = checkRequest(access, 'client_credentials');
let refreshToken = checkRequest(refresh, 'refresh_token', 400, {
    name: 'invalid request',
    message: 'invalid grant_type or authorization'
});

let invalidateToken = checkRequest(invalidate, undefined, 400, {
    name: 'invalid request',
    message: 'invalid grant_type or authorization'
});

export {
    accessToken,
    refreshToken,
    invalidateToken
}