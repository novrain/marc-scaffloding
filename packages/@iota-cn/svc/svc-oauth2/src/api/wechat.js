import crypto from 'crypto';
import util from 'util';
import client from 'superagent'
import Mmw from '@iota-cn/svc-mmw';
import OAuth2Plat from '../model/oauth2plat';
//@Todo see iota-auth/mw/auth; Refactor: DRY
const userAttr = ['id', 'username', 'email', 'mobile', 'gravatar', 'actEmail', 'type', 'password'];

function signin(opts) {
    /*
     wechat:{
     tokenApi : see wx doc;
     appid: 申请的id
     secret: 申请的secret
     userApi: see wx doc;
     }
     */
    let wxOpts = opts;
    /*
     redirect page define.
     */
    let oauth2Opts = opts.oauth2;
    let global = opts.global || { domain: 'http://localhost', prefix: '' };
    let tokenObj = undefined;
    let wxUser = undefined;

    //sub mw
    async function getWxToken(ctx, next) {
        let code = ctx.query.code;
        let wxTokenApi = util.format(wxOpts.tokenApi, wxOpts.appid, wxOpts.secret, code);
        let wxTokenRes = undefined;
        try {
            wxTokenRes = await client.get(wxTokenApi);
            tokenObj = JSON.parse(wxTokenRes.text);
            if (tokenObj.errcode) {
                ctx.iota.logger.log('error', '[IOTA-OAUTH2-WECHAT]', `Invalid call to the WeChat API, ${JSON.stringify(tokenObj)}`);
                ctx.redirect(`${global.domain}${oauth2Opts.redirect.wxerror}`);
            } else {
                await next();
            }
        } catch (err) {
            //ctx.state = 500
            ctx.iota.logger.log('error', '[IOTA-OAUTH2-WECHAT]', `Failed to call the WeChat API, ${err}`);
            ctx.redirect(`${global.domain}${oauth2Opts.redirect.wxerror}`);
        }
    }

    async function normalSingIn(ctx, next) {
        let token = tokenObj.access_token;
        //if user already in system, let it signin.
        try {
            let userOAuth2 = await ctx.iota.dc.models.UserOAuth2.findOne({
                where: {
                    platform: OAuth2Plat.WeChat,
                    openId: tokenObj.unionid
                }
            });
            if (!userOAuth2) {
                await next();
                return;
            }
            let user = await ctx.iota.dc.models.User.findOne({
                where: {
                    id: userOAuth2.userId
                },
                attributes: userAttr
            });

            if (!user) {
                await next();
                return;
            }
            //normal signin sequence.
            //trick
            let plainUser = user.get({ plain: true });
            ctx.request.body = {
                username: plainUser.username,
                email: plainUser.email,
                mobile: plainUser.mobile,
                password: plainUser.password,
                hashed: true
            };

            await ctx.iota.authentication.signIn(ctx, function () {
            });
            if (ctx.status === 200) {
                //redirect to index page;
                //ctx.redirect(oauth2Opts.redirect.index);
                plainUser.password = undefined;
                ctx.cookies.set('wxaui', new Buffer(JSON.stringify(plainUser)).toString('base64'), {
                    httpOnly: false,
                    maxAge: 600000,
                    secure: false
                });
                ctx.redirect(`${global.domain}${oauth2Opts.redirect.wxauto}`);
            } else {
                ctx.redirect(`${global.domain}${oauth2Opts.redirect.wxerror}`);
            }
            return;
        } catch (err) {
            ctx.iota.logger.log('error', 'Error when call normal signin.', err);
            ctx.iota.logger.log('debug', '[IOTA-OAUTH2-WECHAT]', `A new user from wechat. ${tokenObj.unionid}`);
            //ctx.redirect(oauth2Opts.redirect.wxerror);
        }
        await next();
    }

    async function getWxUser(ctx, next) {
        let wxUserApi = util.format(wxOpts.userApi, tokenObj.access_token, tokenObj.openid);
        let wxUserRes = undefined;
        try {
            wxUserRes = await client.get(wxUserApi);
            wxUser = JSON.parse(wxUserRes.text);
            if (wxUser.errcode) {
                ctx.iota.logger.log('error', '[IOTA-OAUTH2-WECHAT]', `Invalid call to the WeChat API, ${JSON.stringify(wxUser)}`);
                ctx.redirect(`${global.domain}${oauth2Opts.redirect.wxerror}`);
            } else {
                await next();
            }
        } catch (err) {
            ctx.iota.logger.log('error', '[IOTA-OAUTH2-WECHAT]', `Failed to call the WeChat API, ${err}`);
            ctx.redirect(`${global.domain}${oauth2Opts.redirect.wxerror}`);
        }
    }

    async function newWxUser(ctx, next) {
        let key = crypto.randomBytes(40).toString('hex');
        ctx.cookies.set('wxk', key);
        ctx.cookies.set('wxa', wxUser.headimgurl, { httpOnly: false, maxAge: 600000, secure: false });
        ctx.cookies.set('wxu', wxUser.nickname, { httpOnly: false, maxAge: 600000, secure: false });
        tokenObj.time = Date.now();
        wxUser.token = tokenObj;
        ctx.iota.dc.cache.extra(key, JSON.stringify(wxUser), 'PX', 600000);
        // @ cookie or by query paramter?  cross domain?
        ctx.redirect(`${global.domain}${oauth2Opts.redirect.wxnew}`);
        //ctx.redirect(`${oauth2Opts.redirect.wxnew}?avatar=${wxUser.headimgurl}`);
    }

    return async function (ctx, next) {
        ctx.iota.logger.log('debug', '[IOTA-OAUTH2-WECHAT]', `User confirmed. ${JSON.stringify(ctx.query)}`);
        let mmw = new Mmw();
        mmw.use(getWxToken);
        mmw.use(normalSingIn);
        mmw.use(getWxUser);
        mmw.use(newWxUser);
        await mmw.callMw(ctx);
    }
}

/**
 * @Todo pull the image from wechat
 * @param ctx
 * @param next
 */
async function binding(ctx, next) {
    try {
        let key = ctx.cookies.get('wxk');
        let reqBody = ctx.request.body;
        let wxUser = await ctx.iota.dc.cache.get(key);
        //过期
        if (!wxUser) {
            ctx.status = 400;
            ctx.body = {
                name: 'invalid request',
                message: 'Request Timeout.',
                details: ''
            };
            return;
        }
        wxUser = JSON.parse(wxUser);
        if (!reqBody || (!reqBody.username && !reqBody.email && !reqBody.mobile) || !reqBody.password) {
            ctx.status = 400;
            ctx.body = {
                name: 'invalid_user',
                message: 'User info not complete.',
                details: ''
            };
            return;
        }
        let everything = reqBody.username || reqBody.email || reqBody.phone;
        let user = await ctx.iota.dc.models.User.findOne({
            where: {
                $or: [
                    { username: everything },
                    { email: everything },
                    { mobile: everything }
                ],
                password: ctx.iota.user.encrypt(reqBody.password)
            }
        });
        if (!user) {
            //user does not exist
            ctx.iota.logger.log('error', '[IOTA-OAUTH2-WECHAT]', 'Failed to binding user, user does not exist.');
            ctx.status = 404;
            ctx.body = {
                name: 'user_not_found',
                message: 'User does not exist.',
                details: ''
            };
            return;
        }
        let recOpenId = await ctx.iota.dc.models.UserOAuth2.findOne({
            where: {
                openId: wxUser.unionid,
                platform: OAuth2Plat.WeChat
            }
        });
        let recUserId = await ctx.iota.dc.models.UserOAuth2.findOne({
            where: {
                userId: user.id,
                platform: OAuth2Plat.WeChat
            }
        });
        // 已经绑定
        if (recOpenId) {
            if (recOpenId.userId !== user.id) {
                //该微信绑定的是其他人
                ctx.status = 409;
                ctx.body = {
                    name: 'wx_binding_other',
                    message: 'This WeChat account has been binding to an other user.'
                };
                return;
            }
        } else if (recUserId) {
            //该用户绑定了其他Wx账号
            ctx.status = 409;
            ctx.body = {
                name: 'user_binding_other',
                message: 'This WeChat account has been binding to an other user.'
            };
            return;
        } else {
            // create relation.
            await ctx.iota.dc.models.UserOAuth2.create({
                userId: user.id,
                platform: OAuth2Plat.WeChat,
                openId: wxUser.unionid
            });
        }
        //ctx.body = {
        //    username: user.name,
        //    email: user.email,
        //    mobile: user.moblie,
        //    password: user.password
        //};
        //await auth.signin(opts)(ctx, next);
        //success binding , return result; signin by client.
        ctx.status = 204;
        ctx.body = {};
    } catch (err) {
        ctx.iota.logger.log('error', err);
        ctx.status = 500;
        ctx.body = {
            name: 'wx_binding_failed',
            message: err.message
        }
    }
}

/**
 * @Todo pull the image from wechat.
 * @param ctx
 * @param next
 */
async function signUp(ctx, next) {
    let key = ctx.cookies.get('wxk');
    let wxUser = await ctx.iota.dc.cache.get(key);
    //过期
    if (!wxUser) {
        ctx.status = 400;
        ctx.body = {
            name: 'invalid request',
            message: 'Request Timeout.',
            details: ''
        };
        return;
    }
    wxUser = JSON.parse(wxUser);
    try {
        let recOpenId = await ctx.iota.dc.models.UserOAuth2.findOne({
            where: {
                openId: wxUser.unionid,
                platform: OAuth2Plat.WeChat
            }
        });
        // 已经绑定
        if (recOpenId) {
            //该微信绑定的是其他人
            ctx.status = 409;
            ctx.body = {
                name: 'wx_binding_other',
                message: 'This WeChat account has been binding to an other user.'
            };
            return;
        }
        await ctx.iota.authentication.signUp(ctx, next);
        if (ctx.status != 200) {
            ctx.iota.logger.log('info', '[IOTA-OAUTH2]', `Call signup of auth failed, error name:${ctx.body ? ctx.body.name : 'none'}`);
            return;
        }
        else {
            // create relation.
            await ctx.iota.dc.models.UserOAuth2.create({
                userId: ctx.body.id,
                platform: OAuth2Plat.WeChat,
                openId: wxUser.unionid
            });
        }
        //ctx.body = {
        //    username: user.name,
        //    email: user.email,
        //    mobile: user.moblie,
        //    password: user.password
        //};
        //await auth.signin(opts)(ctx, next);

        // register and binding success.signin by client it self.
    }

    catch (err) {
        ctx.status = 500;
        ctx.iota.logger.log('error', err);
        ctx.body = {
            name: 'wx_binding_failed',
            message: err.message
        }
    }
}

function bindingCurrentUser(opts) {

    let wxOpts = opts;

    let oauth2Opts = opts.oauth2;
    let global = opts.global || { domain: 'http://localhost' };
    let tokenObj = undefined;
    let wxUser = undefined;

    //sub mw
    async function getWxToken(ctx, next) {
        let code = ctx.query.code;
        let wxTokenApi = util.format(wxOpts.tokenApi, wxOpts.appid, wxOpts.secret, code);
        let wxTokenRes = undefined;
        try {
            wxTokenRes = await client.get(wxTokenApi);
            tokenObj = JSON.parse(wxTokenRes.text);
            if (tokenObj.errcode) {
                ctx.iota.logger.log('error', '[IOTA-OAUTH2-WECHAT]', `Invalid call to the WeChat API, ${JSON.stringify(tokenObj)}`);
                ctx.redirect(`${global.domain}${oauth2Opts.redirect.binding}&wechat=${tokenObj.errcode}`);
            } else {
                await next();
            }
        } catch (err) {
            //ctx.state = 500
            ctx.iota.logger.log('error', '[IOTA-OAUTH2-WECHAT]', `Failed to call the WeChat API, ${err}`);
            ctx.redirect(`${global.domain}${oauth2Opts.redirect.binding}&wechat=${500}`);
        }
    }

    async function getWxUser(ctx, next) {
        let wxUserApi = util.format(wxOpts.userApi, tokenObj.access_token, tokenObj.openid);
        let wxUserRes = undefined;
        try {
            wxUserRes = await client.get(wxUserApi);
            wxUser = JSON.parse(wxUserRes.text);
            if (wxUser.errcode) {
                ctx.iota.logger.log('error', '[IOTA-OAUTH2-WECHAT]', `Invalid call to the WeChat API, ${JSON.stringify(wxUser)}`);
                ctx.redirect(`${global.domain}${oauth2Opts.redirect.binding}&wechat=${wxUser.errcode}`);
            } else {
                await next();
            }
        } catch (err) {
            ctx.iota.logger.log('error', '[IOTA-OAUTH2-WECHAT]', `Failed to call the WeChat API, ${err}`);
            ctx.redirect(`${global.domain}${oauth2Opts.redirect.binding}&wechat=${500}`);
        }
    }

    async function binding(ctx, next) {
        try {
            let user = ctx.session.user;
            if (!user) {
                //user does not signin
                ctx.iota.logger.log('error', '[IOTA-OAUTH2-WECHAT]', 'Failed to binding user, user does not exist.');
                ctx.status = 404;
                ctx.redirect(`${global.domain}${oauth2Opts.redirect.binding}&wechat=${404}`);
                return;
            }
            let recOpenId = await ctx.iota.dc.models.UserOAuth2.findOne({
                where: {
                    openId: wxUser.unionid,
                    platform: OAuth2Plat.WeChat
                }
            });
            let recUserId = await ctx.iota.dc.models.UserOAuth2.findOne({
                where: {
                    userId: user.id,
                    platform: OAuth2Plat.WeChat
                }
            });
            // 已经绑定
            if (recOpenId) {
                if (recOpenId.userId !== user.id) {
                    //该微信绑定的是其他人
                    ctx.status = 409;
                    ctx.redirect(`${global.domain}${oauth2Opts.redirect.binding}&wechat=${409}`);
                    return;
                }
            } else if (recUserId) {
                //该用户绑定了其他Wx账号
                ctx.status = 409;
                ctx.redirect(`${global.domain}${oauth2Opts.redirect.binding}&wechat=${409}`);
                return;
            } else {
                // create relation.
                await ctx.iota.dc.models.UserOAuth2.create({
                    userId: user.id,
                    platform: OAuth2Plat.WeChat,
                    openId: wxUser.unionid
                });
            }
            ctx.status = 204;
            ctx.redirect(`${global.domain}${oauth2Opts.redirect.binding}&wechat=${204}`);
        } catch (err) {
            ctx.iota.logger.log('error', err);
            ctx.status = 500;
            ctx.redirect(`${global.domain}${oauth2Opts.redirect.binding}&wechat=${500}`);
        }
    }

    return async function (ctx, next) {
        ctx.iota.logger.log('debug', '[IOTA-OAUTH2-WECHAT]', `User confirmed. ${JSON.stringify(ctx.query)}`);
        let mmw = new Mmw();
        mmw.use(getWxToken);
        mmw.use(getWxUser);
        mmw.use(binding);
        await mmw.callMw(ctx);
    }
}

async function queryBindingStatus(ctx, next) {
    let user = ctx.session.user;
    if (!user) {
        ctx.status = 404;
        ctx.body = { binding: undefined };
        return;
    }
    let recUserId = await ctx.iota.dc.models.UserOAuth2.findOne({
        where: {
            userId: user.id,
            platform: OAuth2Plat.WeChat
        }
    });
    if (recUserId) {
        ctx.body = { binding: true };
    } else {
        ctx.body = { binding: false };
    }
    ctx.status = 200;
}

async function unbindCurrentUser(ctx, next) {
    let user = ctx.session.user;
    if (!user) {
        ctx.status = 404;
        ctx.body = {};
        return;
    }
    let recUserId = await ctx.iota.dc.models.UserOAuth2.destroy({
        where: {
            userId: user.id,
            platform: OAuth2Plat.WeChat
        }
    });
    if (recUserId) {
        ctx.body = {};
    } else {
        ctx.body = {};
    }
    ctx.status = 200;
}

export {
    signin,
    binding,
    signUp,
    bindingCurrentUser,
    queryBindingStatus,
    unbindCurrentUser
}
