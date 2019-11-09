/**
 * Created by rain on 2017/2/14.
 */
import { Validator } from '@iota-cn/util-validation';
import Mmw from '@iota-cn/svc-mmw';
const userAttr = ['id', 'username', 'email', 'mobile', 'gravatar', 'actEmail', 'type', 'isAdmin'];

let verifyVCode = async function (ctx, next) {
    let vcode = ctx.query.vcode + '';
    let error = true;
    if (vcode && vcode.length == 6) {
        vcode = vcode.toLowerCase();
        let cv = ctx.cookies.get('iota_r');

        if (cv) {
            try {
                let vv = await ctx.iota.dc.cache.get(`vcode=${cv}`);
                if (vv == vcode) {
                    error = false;
                }
            } catch (e) {
                ctx.status = 500;
                ctx.body = {
                    name: 'server error',
                    message: 'an unexpected condition was encountered in the server and no more specific message is suitable.'
                };
                ctx.iota.logger.error(`path: ${ctx.path},error: ${e}`);
                return false;
            }
        } else {
            ctx.status = 400;
            ctx.body = {
                name: 'invalid request',
                message: `vcode expired.`
            };
            return false;
        }
    }
    if (error) {
        ctx.status = 400;
        ctx.body = {
            name: 'validation error',
            message: 'invalid request message framing, malformed request syntax,or deceptive request routing.',
            detail: 'invalid captcha'
        }
    } else {
        ctx.status = 204;
    }
};

let verifyCaptchaSMS = async function (ctx, next) {
    let captcha = ctx.query.captcha;
    let mobile = ctx.query.mobile;
    if (captcha && mobile && (/^\d{6}$/.test(captcha)) && Validator.isPhone(mobile)) {
        try {
            let mv = await ctx.iota.dc.cache.get(`mobileRegister=${mobile}`);
            if (mv == captcha) {
                ctx.status = 204;
            } else {
                ctx.status = 400;
                ctx.body = {
                    name: 'validation error',
                    message: 'invalid request message framing, malformed request syntax,or deceptive request routing.',
                    detail: 'invalid mobile or captcha'
                };
            }
        } catch (e) {
            ctx.status = 500;
            ctx.body = {
                name: 'server error',
                message: 'an unexpected condition was encountered in the server and no more specific message is suitable.'
            };
            ctx.iota.logger.error(`path: ${ctx.path}, mobile: ${mobile}, error: ${e}`);
        }

    } else {
        ctx.status = 400;
        ctx.body = {
            name: 'validation error',
            message: 'invalid request message framing, malformed request syntax,or deceptive request routing.',
            detail: 'invalid mobile or captcha'
        };
    }
};

function passwordAuth(info) {
    return async function (ctx, next) {
        const models = ctx.iota.dc.models;
        if (!ctx.iota.authed) {
            if (info && info.username && info.psdEncrypt) {
                let user = await models.User.findOne({
                    where: {
                        username: info.username,
                        password: info.psdEncrypt
                    },
                    attributes: userAttr,
                    include: [
                        {
                            model: models.SubUser,
                            as: 'subExt'
                        }
                    ]
                });
                await auth(ctx, user, info, next);
            } else {
                await next(info);
            }
        }
    }
}

function emailAuth(info) {
    return async function (ctx, next) {
        const models = ctx.iota.dc.models;
        if (!ctx.iota.authed) {
            if (info && info.email && info.psdEncrypt) {
                let user = await models.User.findOne({
                    where: {
                        email: info.email,
                        password: info.psdEncrypt
                    },
                    attributes: userAttr,
                    include: [
                        {
                            model: models.SubUser,
                            as: 'subExt'
                        }
                    ]
                });
                await auth(ctx, user, info, next);
            } else {
                await next(info);
            }
        }
    }
}

function mobileAuth(info) {
    return async function (ctx, next) {
        const models = ctx.iota.dc.models;
        if (!ctx.iota.authed) {
            if (info && info.mobile && info.psdEncrypt) {
                let user = await models.User.findOne({
                    where: {
                        mobile: info.mobile,
                        password: info.psdEncrypt
                    },
                    attributes: userAttr,
                    include: [
                        {
                            model: models.SubUser,
                            as: 'subExt'
                        }
                    ]
                });
                await auth(ctx, user, info, next);
            } else {
                await next(info);
            }
        }
    }
}

let auth = async (ctx, user, info, next) => {
    if (user) {
        if (user.type !== 'Sub' || user.subExt.enable) {
            ctx.iota.authed = true;
            ctx.iota.user.signUser = user;
        }
    } else {
        await next(info);
    }
};

let signIn = function (opts) {
    return async function (ctx, next) {
        let user = ctx.request.body;
        const userMw = ctx.iota.user;
        if (!userMw || !userMw.encrypt) {
            ctx.status = 500;
            ctx.body = {
                name: 'server error',
                message: 'Environment error, no suitable user module.'
            };
            ctx.iota.logger.error(`path: ${ctx.path}, body: ${JSON.stringify(ctx.request.body)}`);
            return;
        }
        try {
            const encrypt = userMw.encrypt;
            user.password = user.password + '';
            user.mobile = user.mobile + '';
            //trick for use db info to signin.
            user.psdEncrypt = user.hashed ? user.password : encrypt(user.password);
            let mmw = new Mmw();
            mmw.use(passwordAuth(user));
            mmw.use(emailAuth(user));
            mmw.use(mobileAuth(user));
            if (!ctx.iota) ctx.iota = {};
            await mmw.callMw(ctx);

            if (ctx.iota.authed) {
                if (ctx.session.authed) {
                    ctx.session = {};
                }
                ctx.session.authed = true;
                ctx.session.user = ctx.iota.user.signUser.get({ plain: true });

                if (user.remember) {
                    let days = opts && opts.remMaxAge && (typeof opts.remMaxAge == 'number') ?
                        opts.remMaxAge : 7;

                    ctx.session.maxAge = days * 24 * 3600 * 1000;
                }

                ctx.status = 200;
                ctx.body = ctx.session.user;
            }
            else {
                ctx.status = 400;
                ctx.body = {
                    name: 'validation error',
                    message: 'invalid request message framing, malformed request syntax,or deceptive request routing.',
                    detail: 'invalid account'
                };
            }
        }
        catch (e) {
            ctx.status = 500;
            ctx.body = {
                name: 'server error',
                message: 'an unexpected condition was encountered in the server and no more specific message is suitable.'
            };
            ctx.iota.logger.error(`path: ${ctx.path}, error: ${e}`);
        }
    }
};

let signOut = function (ctx, next) {
    ctx.session = {};
    ctx.status = 204;
};

let signUp = async function (ctx, next) {
    // 使用 @iota-cn/svc-user 提供的接口创建用户
    let info = ctx.request.body;
    let user = ctx.iota.user;
    let vcode = info.vcode + '';
    if (user && typeof user.create === 'function') {
        try {
            let cv = ctx.cookies.get('iota_r');
            if (cv) {
                let vv = await ctx.iota.dc.cache.get(`vcode=${cv}`);
                if (vv != vcode.toLowerCase()) {
                    ctx.status = 400;
                    ctx.body = {
                        name: 'validation error',
                        message: 'invalid request message framing, malformed request syntax,or deceptive request routing.',
                        detail: 'captcha is not correct'
                    };
                    return false;
                }
            } else {
                ctx.status = 400;
                ctx.body = {
                    name: 'invalid request',
                    message: `vcode expired.`
                };
                return false;
            }
            await user.create(ctx);
        }
        catch (err) {
            ctx.status = 500;
            ctx.body = {
                name: 'server error',
                message: 'an unexpected condition was encountered in the server and no more specific message is suitable.'
            };
            ctx.iota.logger.error(`path: ${ctx.path}, body: ${JSON.stringify(ctx.request.body)}, error: ${err}`);
        }
    } else {
        ctx.status = 500;
        ctx.body = {
            name: 'server error',
            message: 'Environment error, no suitable user module.'
        };
        ctx.iota.logger.error(`path: ${ctx.path}, body: ${JSON.stringify(ctx.request.body)}`);
    }
};

let changePassword = async function (ctx, next) {
    // 使用 @iota-cn/svc-user 提供的接口修改密码
    let user = ctx.iota.user;
    let id = ctx.session.user.id;
    ctx.request.body.id = id;
    await user.changePassword(ctx);
};

//@TODO 是否要放置在这里...
let current = async function (ctx, next) {
    ctx.body = ctx.session
};

let updateCurrent = async (ctx, next) => {
    let id = ctx.session.user.id;
    let user = ctx.request.body;
    let error = true;
    let models = ctx.iota.dc.models;
    if (user) {
        //@TODO
        delete user.type;
        delete user.actEmail;
        delete user.key;
        delete user.secret;
        delete user.createBy;
        delete user.id;
        delete user.isAdmin;
        //修改邮箱，必须重新激活
        if (ctx.session.user.email !== user.email) {
            user.actEmail = 0;
        }
        //修改手机时，必须提供captcha
        if (user.mobile) {
            let captcha = ctx.query.captcha;
            let mv = await ctx.iota.dc.cache.get(`mobileRegister=${user.mobile}`);
            if (!(captcha && /^\d{6}$/.test(captcha) && Validator.isPhone(user.mobile) && captcha === mv)) {
                ctx.status = 400;
                ctx.body = {
                    name: 'Validation error',
                    message: 'Invalid request message framing, malformed request syntax,or deceptive request routing.',
                    detail: 'invalid mobile or captcha'
                }
                return;
            }
        }
        let result = await models.User.update(user, { where: { id: id } });
        ctx.session.user = Object.assign({}, ctx.session.user, user);
        ctx.status = 204;
    } else {
        ctx.status = 400;
        ctx.body = {
            name: 'Validation error',
            message: 'Invalid request message framing, malformed request syntax,or deceptive request routing.',
            detail: 'invalid request'
        };
    }
}

export default {
    verifyVCode,
    verifyCaptchaSMS,
    signIn,
    signOut,
    signUp,
    changePassword,
    current,
    updateCurrent
}