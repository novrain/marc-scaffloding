import {
    Validator
} from '@iota-cn/util-validation';
import {
    encrypt
} from '../model/user';
import UserTypes from '../model/user_types'

let callMiddleWare = async function (ctx, middleWare) {
    if (typeof middleWare === 'string' &&
        ctx.iota.user &&
        ctx.iota.user.hooks &&
        ctx.iota.user.hooks[middleWare] &&
        typeof ctx.iota.user.hooks[middleWare].callMw === 'function') {
        await ctx.iota.user.hooks[middleWare].callMw(ctx);
    }
};

/**
 * 从 ctx.body 中获取用户信息，并判断信息是否可以用
 * 包括新建用户判重和修改时判重
 * @param ctx
 * @param isCreate 创建用户 或 修改用户
 */
let checkUser = async function (ctx, isCreate = true) {
    let models = ctx.iota.dc.models;
    let user = ctx.request.body;
    //protect for int value
    let valid = false;
    if (isCreate) {
        valid = user &&
            (user.username && Validator.isUserName(user.username)) &&
            ((user.mobile && Validator.isPhone(user.mobile)) || (user.email && Validator.isEmail(user.email))) &&
            (user.password && Validator.isPassword(user.password));
    } else {
        valid = user && !(!user.username && !user.mobile && !user.email && !user.password && !user.gravatar) &&
            (user.username ? Validator.isUserName(user.username) : true) &&
            (user.mobile ? Validator.isPhone(user.mobile) : true) &&
            (user.email ? Validator.isEmail(user.email) : true) &&
            (user.password ? Validator.isPassword(user.password) : true)
    }
    if (valid) {
        user.username = user.username ? user.username + '' : user.username;
        user.password = user.password ? user.password + '' : user.password;
        user.mobile = user.mobile ? user.mobile + '' : user.mobile;
        user.email = user.email ? user.email + '' : user.email;
        let or = [{
            username: user.username
        }];
        if (user.email) {
            or.push({
                email: user.email
            })
        }
        if (user.mobile) {
            or.push({
                mobile: user.mobile
            })
        }
        //if user.id 检查用户是否存在 判重去掉自己
        let queryConflict = {
            where: {
                $or: or
            }
        };
        if (user.id && !isCreate) {
            let exitUser = await models.User.findOne({
                where: {
                    id: user.id
                }
            });
            if (!exitUser) {
                ctx.status = 404;
                ctx.body = {
                    name: 'user not found',
                    message: 'the user does not exist.',
                    detail: 'id of user is invalid.'
                };
                return;
            }
            queryConflict.where.$not = {
                id: user.id
            };
        }
        let conflictUser = await models.User.findOne(queryConflict);
        if (conflictUser) {
            ctx.status = 409;
            ctx.body = {
                name: 'validation error',
                message: 'invalid request message framing, malformed request syntax,or deceptive request routing.',
                detail: 'username, email or mobile has been occupied'
            };
        } else {
            ctx.status = 200;
        }
    } else {
        ctx.status = 400;
        ctx.body = {
            name: 'validation error',
            message: 'invalid request message framing, malformed request syntax,or deceptive request routing.',
            detail: 'username, email or mobile is invalid or has been occupied'
        };
    }
};

let create = async function (ctx, next) {
    let user = ctx.request.body;
    let models = ctx.iota.dc.models;
    let t = ctx.iota.session ? ctx.iota.session.transaction : undefined;
    //是否内部事务？
    let isLocalTransaction = !t;
    try {
        await checkUser(ctx);
        if (ctx.status != 200) {
            return;
        }
        let params = {
            password: user.password,
            username: user.username,
            email: user.email,
            mobile: user.mobile,
            type: user.type,
            id: process.env.NODE_ENV === 'test' ? user.id : undefined,
            isAdmin: user.isAdmin
        };
        //传入T
        t = isLocalTransaction ? await ctx.iota.dc.orm.transaction() : t;
        ctx.iota.session = ctx.iota.session || {};
        ctx.iota.session.transaction = t;
        let newUser = await models.User.create(params, {
            transaction: t
        });

        //result for other middle ware as parameter / append some other info.
        ctx.status = 200;
        ctx.body = Object.assign({ subExt: user.subExt }, newUser.get({
            plain: true
        }));
        delete ctx.body.password;
        delete ctx.body.key;
        delete ctx.body.secret;

        // middle ware.
        try {
            await callMiddleWare(ctx, 'afterCreate');
        } catch (err) {
            ctx.status = err.status ? err.status : 500;
            ctx.body = {
                name: err.name,
                message: err.message
            };
            return;
        }

        // finished
        if (isLocalTransaction) {
            await t.commit();
        }
    } catch (e) {
        if (isLocalTransaction && t) {
            await t.rollback();
        }
        ctx.status = 500;
        ctx.body = {
            name: 'server error',
            message: 'an unexpected condition was encountered in the server and no more specific message is suitable.'
        };
        ctx.iota.logger.error(`path: ${ctx.path}, body: ${JSON.stringify(user)}, error: ${e}`);
    }
};

let update = async function (ctx, next) {
    let user = ctx.request.body;
    let models = ctx.iota.dc.models;
    let t = ctx.iota.session ? ctx.iota.session.transaction : undefined;
    //是否内部事务？
    let isLocalTransaction = !t;
    try {
        if (!user.id) {
            ctx.status = 404;
            ctx.body = {
                name: 'user not found',
                message: 'the user does not exist.',
                detail: 'id of user is invalid.'
            };
            return;
        }
        await checkUser(ctx, false);
        if (ctx.status != 200) {
            return;
        }
        let params = {};
        for (let k in user) {
            if (k != 'id' && user[k] !== undefined) {
                params[k] = user[k];
            }
        }
        //传入T
        t = isLocalTransaction ? await ctx.iota.dc.orm.transaction() : t;
        ctx.iota.session = ctx.iota.session || {};
        ctx.iota.session.transaction = t;
        let count = await models.User.update(params, {
            where: {
                id: user.id
            },
            transaction: t
        });

        //result for other middle ware as parameter / append some other info.
        ctx.status = 204;
        ctx.body = {};

        // middle ware.
        try {
            await callMiddleWare(ctx, 'afterUpdate');
        } catch (err) {
            ctx.status = err.status ? err.status : 500;
            ctx.body = {
                name: err.name,
                message: err.message
            };
            return;
        }

        // finished
        if (isLocalTransaction) {
            await t.commit();
        }
    } catch (e) {
        if (isLocalTransaction && t) {
            await t.rollback();
        }
        ctx.status = 500;
        ctx.body = {
            name: 'server error',
            message: 'an unexpected condition was encountered in the server and no more specific message is suitable.'
        };
        ctx.iota.logger.error(`path: ${ctx.path}, body: ${JSON.stringify(user)}, error: ${e}`);
    }
};

let existUsername = async function (ctx, next) {
    let username = ctx.query.username;
    let exist = false;
    let models = ctx.iota.dc.models;
    if (username && Validator.isUserName(username)) {
        try {
            let user = await models.User.findOne({
                where: {
                    username: username
                }
            });
            if (user) {
                exist = true;
            }
        } catch (e) {
            ctx.status = 500;
            ctx.body = {
                name: 'server error',
                message: 'an unexpected condition was encountered in the server and no more specific message is suitable.'
            };
            ctx.iota.logger.error(`path: ${ctx.path},error: ${e}`);
            return;
        }
    } else {
        exist = true;
    }
    if (exist) {
        ctx.status = 400;
        ctx.body = {
            name: 'validation error',
            message: 'invalid request message framing, malformed request syntax,or deceptive request routing.',
            detail: 'username was occupied or invalid'
        }
    } else {
        ctx.status = 204;
    }
};

let existMobile = async function (ctx, next) {
    let mobile = ctx.query.mobile;
    let exist = false;
    let models = ctx.iota.dc.models;
    if (mobile && Validator.isPhone(mobile)) {
        try {
            let user = await models.User.findOne({
                where: {
                    mobile: mobile
                }
            });
            if (user) {
                exist = true;
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
        exist = true;
    }
    if (exist) {
        ctx.status = 400;
        ctx.body = {
            name: 'validation error',
            message: 'invalid request message framing, malformed request syntax,or deceptive request routing.',
            detail: 'mobile was occupied or invalid'
        }
    } else {
        ctx.status = 204;
    }
};

let existEmail = async function (ctx, next) {
    let email = ctx.query.email;
    let exist = false;
    let models = ctx.iota.dc.models;
    if (email && Validator.isEmail(email)) {
        try {
            let user = await models.User.findOne({
                where: {
                    email: email
                }
            });
            if (user) {
                exist = true;
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
        exist = true;
    }
    if (exist) {
        ctx.status = 400;
        ctx.body = {
            name: 'validation error',
            message: 'invalid request message framing, malformed request syntax,or deceptive request routing.',
            detail: 'email was occupied or invalid'
        }
    } else {
        ctx.status = 204;
    }
};


let changePassword = async function (ctx, next) {
    let info = ctx.request.body;
    let models = ctx.iota.dc.models;
    let id, old, newOne;
    if (info && info.id && info.new && info.old) {
        id = info.id;
        try {
            let psw = await models.User.findOne({
                where: {
                    id: id
                },
                attributes: ['password']
            });
            let pass = psw.get({
                plain: true
            });
            old = encrypt(info.old);
            newOne = encrypt(info.new);
            if (old == pass.password) {
                if (old === newOne) {
                    ctx.status = 409;
                    ctx.body = {
                        name: 'same password',
                        message: 'new password is same with the old one'
                    }
                    return;
                }
                await models.User.update({
                    password: info.new
                }, {
                        where: {
                            id: id
                        }
                    });
                ctx.status = 204;
            } else {
                ctx.status = 400;
                ctx.body = {
                    name: 'validation error',
                    message: 'invalid request message framing, malformed request syntax,or deceptive request routing.',
                    detail: 'invalid information'
                };
            }
        } catch (e) {
            ctx.status = 500;
            ctx.body = {
                name: 'server error',
                message: 'an unexpected condition was encountered in the server and no more specific message is suitable.'
            };
            ctx.iota.logger.error(`path: ${ctx.path}, error: ${e}`);
            return false;
        }
    }
};

export default {
    create,
    update,
    changePassword,
    existEmail,
    existMobile,
    existUsername,
    checkUser
}