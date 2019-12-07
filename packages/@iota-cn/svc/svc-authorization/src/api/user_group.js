import { Validator } from '@iota-cn/util-validation';
import uuid from 'uuid';
import nodemailer from 'nodemailer';
import { uniqueArray, valBetween } from '@iota-cn/svc-util';

function createInvitedEmail(emailAddress, code, userGroupId, invitee, gravatar, inviter, domain, prefix) {
    return {
        from: 'iOTA以太数据 <service@theiota.cn>', // sender address
        to: emailAddress, // list of receivers
        subject: 'iOTA-用户组邀请', // 主题
        text: 'iOTA-用户组邀请', // 这个没什么用
        html: `<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <style>
       * {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
            "Helvetica Neue", Helvetica, "PingFang SC", "Hiragino Sans GB", "Microsoft YaHei",
            SimSun, sans-serif;
            margin: 0;
            padding: 0;
        }

        .iota-content a {
            -moz-transition: all 218ms;
            -o-transition: all 218ms;
            -webkit-transition: all 218ms;
            color: #13c2f2 !important;
            text-decoration: underline;
            transition: all 218ms;
        }

        body {
            background: #F2F2F2;
            font-size: 14px;
            font-weight: normal;
            padding: 36px 0 36px 0;
        }

        .iota-content {
            background: #292d38;
            border: 1px solid #292933;
            box-sizing: border-box;
            margin: 0 auto;
            max-width: 710px;
            overflow: hidden;
            color: white;
            border-radius: 4px;
        }

        .iota-content .user {
            background-color: #191a1e;
            height: 40px;
            margin: 0;
            padding-left: 20px;
            color: white;
            font-size: 16px;
            line-height: 40px;
            font-weight: normal;
            word-break: normal;
        }

        .iota-content .main {
            padding: 32px 20px 32px 20px;
            text-align: center;
            color: white;
        }

        .iota-content .message {
            display: inline;
            font-size: 14px;
            font-weight: normal;
            word-break: normal;
            color: white;
        }

        .iota-content .btn {
            -moz-transition: all 218ms;
            -o-transition: all 218ms;
            -webkit-transition: all 218ms;
            background: #4570fd;
            color: white !important;
            display: block;
            font-size: 16px;
            height: 32px;
            line-height: 32px;
            margin: 24px auto;
            text-decoration: none;
            transition: all 218ms;
            width: 128px;
            border: 0 !important;
            text-align: center;
            border-radius: 4px;
        }

        .iota-content .hint {
            display: block;
            font-weight: normal;
            line-height: 24px;
            word-break: normal;
            color: white;
        }

        .iota-content .advice {
            background-image: url('${domain}/dist/assets/img/email-background.png');
            margin-top: 32px;
            height: 374px;
            color: white;
        }

        .iota-content .advice p {
            margin: 0;
            color: white;
        }

        .iota-content .slogan {
            font-size: 20px;
            color: white;
        }

        .iota-content .split {
            height: 1px;
            margin: 2px auto;
            background-color: #827876;
            width: 256px
        }

        .iota-content .logo {
            height: 28px;
            margin: 16px auto;
            display: block;
            color: white;
        }

        .iota-content .company-name {
            margin: 8px auto;
            height: 28px;
            display: block;
            color: white;
        }

        .iota-content .slogan-sub {
            font-size: 16px;
            color: #827876 !important;
        }

        .iota-content .advice-content {
            top: 120px;
            position: relative;
            color: white;
        }

        .iota-content .service {
            text-align: center;
            word-break: normal;
            margin-bottom: 32px;
            color: white;
        }
    </style>
</head>
<article class="iota-content">
    <header>
        <h1 class="user">${invitee}，您好！</h1>
    </header>
    <div class="main">
        <h2 class="message"> ${inviter} 邀请您加入其创建的用户组，请您点击以下按钮，接受邀请，或忽略此邮件。</h2>
        <a class="btn"
           href="${domain}${prefix}/user_groups/${userGroupId}/invite_users/accept?code=${code}"
           target="_blank">接受邀请</a>
        <p class="hint">
            如果按钮无法点击，请直接访问以下链接：
            <br><a
                href="${domain}${prefix}/user_groups/${userGroupId}/invite_users/accept?code=${code}"
                   target="_blank">${domain}${prefix}/user_groups/${userGroupId}/invite_users/accept?code=${code}</a><br></p>
        <section class="advice">
            <article class="advice-content">
                <img class="logo"
                     alt="iOTA"
                     src="${domain}/dist/assets/img/logo.png"/>
                <img class="company-name"
                     alt="以太数据"
                     src="${domain}/dist/assets/img/company-name.png"/>
                <p class="slogan">包罗万物的开放IoT生态系统 </p>
                <div class="split"></div>
                <p class="slogan-sub">开放、合作、成长</p>
            </article>
        </section>
    </div>
    <footer>
        <p class="service">
            邮件来自iOTA，无需回复。如果您在使用中有任何的疑问或者建议，
            <br/>欢迎反馈意见至：
            <a href="mailto:service@theiota.cn">service@theiota.cn</a>
        </p>
    </footer>
</article>
</html>`
    }
}

function createInvitedNotice(opts, code, userGroupId, invitee, inviter) {
    let domain = opts.global.domain || 'http://localhost';
    let prefix = opts.global.prefix || '';
    return `<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <style>
        .iota-content a {
            -moz-transition: all 218ms;
            -o-transition: all 218ms;
            -webkit-transition: all 218ms;
            color: #13c2f2 !important;
            text-decoration: underline;
            transition: all 218ms;
        }

        .iota-content {
            box-sizing: border-box;
            margin: 0 42px;
            overflow: hidden;
        }

        .iota-content .user {
            height: 40px;
            margin: 10px 0;
            padding-left: 20px;
            font-size: 14px;
            line-height: 40px;
            font-weight: normal;
            word-break: normal;
        }

        .iota-content .main {
            padding: 0px 20px 0px 20px;
        }

        .iota-content .message {
            color: #666666;
            display: inline;
            font-size: 14px;
            font-weight: normal;
            word-break: normal;
	    display: block;
        }

        .iota-content .btn {
            -moz-transition: all 218ms;
            -o-transition: all 218ms;
            -webkit-transition: all 218ms;
            background: #4570fd;
            color: white !important;
            display: block;
            font-size: 16px;
            height: 32px;
            line-height: 32px;
            margin: 24px 0;
            text-decoration: none;
            transition: all 218ms;
            width: 110px;
            border: 0 !important;
            text-align: center;
            border-radius: 4px;
        }
    </style>
</head>
<article class="iota-content">
    <header>
        <h1 class="user"><strong>${invitee}，您好！</strong></h1>
    </header>
    <div class="main">
        <h2 class="message"> ${inviter} 邀请您加入其创建的用户组，请您点击以下按钮，接受邀请，或忽略此通知。</h2>
        <a class="btn"
           href="${domain}${prefix}/user_groups/${userGroupId}/invite_users/accept?code=${code}"
           target="_blank">接受邀请</a>
    </div>
</article>
</html>`
}

/**
 *
 * @param ctx
 * @param emailAddress
 * @param code
 * @param userGroupId
 * @param invitee
 * @param gravatar
 * @param inviter
 * @param opts
 */
let sendInvitedEmail = async (ctx, emailAddress, code, userGroupId, invitee, gravatar, inviter, opts) => {
    try {
        let domain = opts.global.domain || 'http://localhost';
        let prefix = opts.global.prefix || '';
        let smtpConfig = opts.global.smtp || {
            host: 'smtp.exmail.qq.com',
            port: 465,
            secure: true, // use SSL
            auth: {
                user: 'service@theiota.cn',
                pass: 'IotaSM123_'
            }
        };
        let transporter = nodemailer.createTransport(smtpConfig);
        let emailContent = createInvitedEmail(emailAddress, code, userGroupId, invitee, gravatar, inviter, domain, prefix);
        await transporter.sendMail(emailContent);
    } catch (err) {
        ctx.iota.logger.error(`path: ${ctx.path}, error: ${e}`, e.stack);
    }
};

/**
 * 
 * @param {上下文} ctx 
 * @param {邀请码} code 
 * @param {用户组} userGroupId 
 * @param {被邀请人} invitee 
 * @param {邀请人} inviter 
 * @param {opts} opts 
 */
let sendInvitedNotice = async (ctx, code, userGroupId, invitee, inviter, opts) => {
    if (ctx.iota.message && ctx.iota.message.send) {
        let message = {};
        message.method = 'unicast';
        message.receiver = invitee.userId;
        message.sender = inviter.id;
        message.targetDomain = 'console';
        message.sourceDomain = 'console';
        message.payloadType = 'notice';
        message.payload = {
            type: 'Invitation',
            title: '用户组邀请',
            //通知内容
            content: createInvitedNotice(opts, code, userGroupId, invitee.username, inviter.username),
            //extend info 通知框架本身不处理
            payload: undefined
        };
        ctx.iota.message.send(message);
    }
}

let createCreateApi = (app, opts) => {
    return async function (ctx, next) {
        let createBy = ctx.session.user.id;
        const models = ctx.iota.dc.models;
        const userGroup = ctx.request.body ? ctx.request.body : {};
        let users = userGroup.users ? userGroup.users : [];
        let count = await models.UserGroup.count({
            where: {
                createBy: createBy
            }
        });
        if (count >= 20) {
            ctx.status = 403;
            ctx.body = {
                name: 'forbidden',
                message: 'no enough quota'
            };
            return;
        }
        if (Validator.isCommonName(userGroup.name) && Validator.isCommonDesc(userGroup.desc) && Array.isArray(users)) {
            users = uniqueArray(users, 'key');
            let invalidUser = false;
            for (let user of users) {
                if (user.type && user.key) {
                    switch (user.type) {
                        case 'Sub':
                            //判断子用户是否存在
                            let id = user.key;
                            let subUser = await models.User.findOne({
                                where: {
                                    id: id,
                                    type: models.User.UserTypes.Sub
                                },
                                attributes: ['id', 'username', 'email'],
                                include: [
                                    {
                                        model: models.SubUser,
                                        as: 'subExt',
                                        where: {
                                            userId: id,
                                            parentId: createBy
                                        }
                                    }
                                ]
                            });
                            if (!subUser) {
                                invalidUser = true;
                            } else {
                                user.userId = subUser.id;
                                user.username = subUser.username;
                                user.email = subUser.email;
                            }
                            break;
                        case 'Invited':
                            //判断受邀用户是否存在且不是子用户
                            let email = user.key;
                            let invitedUser = await models.User.findOne({
                                where: {
                                    email: email,
                                    id: { $not: createBy },
                                    type: models.User.UserTypes.Master
                                },
                                attributes: ['id', 'username', 'email', 'gravatar']
                            });
                            if (!invitedUser) {
                                invalidUser = true;
                            } else {
                                user.userId = invitedUser.id;
                                user.username = invitedUser.username;
                                user.email = invitedUser.email;
                                user.gravatar = invitedUser.gravatar;
                            }
                            break;
                        default:
                            invalidUser = true;
                            break;
                    }
                    if (invalidUser) {
                        break;
                    }
                } else {
                    invalidUser = true;
                }
            }
            if (invalidUser) {
                ctx.status = 400;
                ctx.body = {
                    name: 'invalid user',
                    message: `invalid user. user is not a subuser of parent or invited user dose not exist or invited user does not `
                };
            } else {
                let t = await ctx.iota.dc.orm.transaction();
                try {
                    let newUserGroup = await models.UserGroup.create({
                        name: userGroup.name,
                        desc: userGroup.desc,
                        createBy: createBy
                    }, { transaction: t });
                    for (let user of users) {
                        let invitedCode = user.type === 'Invited' ? uuid.v4() : '';
                        let userGroupUser = await models.UserGroupUser.create({
                            type: user.type,
                            invitedCode: invitedCode,
                            userGroupId: newUserGroup.id,
                            userId: user.userId
                        }, { transaction: t });
                        user.id = userGroupUser.id;
                        user.enable = true;
                        user.createdAt = userGroupUser.createdAt;
                        if (user.type === 'Invited') {
                            user.accept = false;
                            // 不等待
                            if (!opts.disableEmail) {
                                sendInvitedEmail(ctx, user.email, invitedCode, newUserGroup.id, user.username, user.gravatar, ctx.session.user.username, opts);
                            }
                            sendInvitedNotice(ctx, invitedCode, newUserGroup.id, user, ctx.session.user, opts);
                        }
                    }
                    await t.commit();
                    ctx.status = 200;
                    userGroup.id = newUserGroup.id;
                    userGroup.users = users;
                    ctx.body = userGroup;
                } catch (e) {
                    await t.rollback();
                    throw e;
                }
            }
        } else {
            ctx.status = 400;
            ctx.body = {
                name: 'invalid request',
                message: 'invalid name or desc'
            };
        }
    }
};

let find = async function (ctx, next) {
    let createBy = ctx.session.user.id;
    const id = ctx.params.id;
    const limit = valBetween(ctx.query.limit, 1, 200, 20);
    const offset = parseInt(ctx.query.offset) || 0;
    const orderBy = ctx.query.orderBy || 'createdAt';
    const orderDirection = ctx.query.orderDirection || 'DESC';
    let models = ctx.iota.dc.models;
    let condition = {
        where: {
            createBy: createBy
        },
        attributes: ['id', 'name', 'desc', 'createdAt'],
        limit: limit,
        offset: offset,
        order: [[orderBy, orderDirection]]
    };
    if (id) {
        condition.where.id = id;
    }
    let userGroups = await models.UserGroup.findAndCountAll(condition);
    ctx.status = 200;
    ctx.body = {
        count: userGroups.count,
        userGroups: userGroups.rows
    };
    //规范化返回
    if (ctx.iota.restful && typeof ctx.iota.restful.createNormalizer === 'function') {
        ctx.iota.restful.createNormalizer('userGroups')(ctx);
    }
};

let findUserInGroup = async function (ctx, next) {
    const userGroupId = ctx.params.userGroupId;
    const createBy = ctx.session.user.id;
    const id = ctx.params.id;
    const limit = valBetween(ctx.query.limit, 1, 200, 20);
    const offset = parseInt(ctx.query.offset) || 0;
    const orderBy = ctx.query.orderBy || 'createdAt';
    const orderDirection = ctx.query.orderDirection || 'DESC';
    let models = ctx.iota.dc.models;
    let condition = {
        where: {
            userGroupId: userGroupId
        },
        include: [
            {
                model: models.User,
                as: 'user',
                attributes: ['id', 'username', 'email', 'type'],
                include: {
                    model: models.SubUser,
                    as: 'subExt',
                    attributes: ['id', 'enable', 'dependent']
                }
            },
            {
                model: models.UserGroup,
                as: 'userGroup',
                where: {
                    createBy: createBy
                }
            }
        ],
        limit: limit,
        offset: offset,
        distinct: true,
        order: [[orderBy, orderDirection]]
    };
    if (id) {
        condition.where.id = id;
    }
    let groupUsers = await models.UserGroupUser.findAndCountAll(condition);
    ctx.status = 200;
    let users = [];
    for (let groupUser of groupUsers.rows) {
        users.push({
            id: groupUser.id,
            userId: groupUser.userId,
            userGroupId: groupUser.userGroupId,
            email: groupUser.user.email,
            username: groupUser.type === 'Sub' || groupUser.accept ? groupUser.user.username : '',
            accept: groupUser.accept,
            enable: groupUser.enable,
            type: groupUser.type,
            createdAt: groupUser.createdAt
            //selfEnable: user.user.subExt.enable,
            //dependent: user.subExt.dependent
        });
    }
    ctx.status = 200;
    ctx.body = {
        count: groupUsers.count,
        users: users
    };
    //规范化返回
    if (ctx.iota.restful && typeof ctx.iota.restful.createNormalizer === 'function') {
        ctx.iota.restful.createNormalizer('users')(ctx);
    }
};

let update = async function (ctx, next) {
    let id = ctx.params.id;
    let models = ctx.iota.dc.models;
    let userGroup = ctx.request.body;
    if (userGroup
        && (userGroup.name ? Validator.isCommonName(userGroup.name) : true)
        && (userGroup.desc ? Validator.isCommonDesc(userGroup.desc) : true)) {
        let record = {
            name: userGroup.name,
            desc: userGroup.desc
        };
        let result = await models.UserGroup.update(
            record,
            { where: { id: id } }
        );
        let count = result[0];
        if (count === 1) {
            ctx.status = 204;
            ctx.body = {};
        } else {
            ctx.status = 404;
            ctx.body = {
                name: 'invalid user group',
                message: `invalid user group ${id}`
            };
        }
    } else {
        ctx.status = 400;
        ctx.body = {
            name: 'invalid user group',
            message: `invalid user grourp name or desc`
        };
    }
};

let _delete = async function (ctx, next) {
    const id = ctx.params.id;
    let ids = ctx.query.ids ? ctx.query.ids.split(',') : [];
    let createBy = ctx.session.user.id;
    let invalidGroups = false;
    let models = ctx.iota.dc.models;
    if (id) {
        ids.push(id);
    }
    ids = uniqueArray(ids);
    if (ids.length > 0) {
        let count = await models.UserGroup.count({
            where: {
                id: {
                    $in: ids
                },
                createBy: createBy
            }
        });
        if (count < ids.length) {
            invalidGroups = true;
        }
    } else {
        invalidGroups = true;
    }
    if (invalidGroups) {
        ctx.status = 404;
        ctx.body = {
            name: 'invalid user group',
            message: `the user group ${ids} dose not exist.`
        };
        return;
    }
    let t = await ctx.iota.dc.orm.transaction();
    try {
        await models.UserGroupUser.destroy({
            where: {
                userGroupId: { $in: ids }
            },
            transaction: t
        });
        await models.UserGroup.destroy({
            where: {
                id: { $in: ids }
            },
            transaction: t
        });
        await t.commit();
        ctx.status = 204;
    } catch (e) {
        await t.rollback();
        throw e;
    }
};

let findSubUserNotInGroup = async (ctx, next) => {
    const userGroupId = ctx.params.userGroupId;
    const createBy = ctx.session.user.id;
    const dc = ctx.iota.dc;
    const models = ctx.iota.dc.models;
    const limit = valBetween(ctx.query.limit, 1, 200, 20);
    const offset = parseInt(ctx.query.offset) || 0;
    const orderBy = ctx.query.orderBy || 'createdAt';
    const orderDirection = ctx.query.orderDirection || 'DESC';
    let filterCondition = {
        distinct: true,
        where: {
            type: 'Sub'
        },
        attributes: ['userId'],
        include: [
            {
                model: models.UserGroup,
                attributes: [],
                as: 'userGroup',
                where: {
                    id: userGroupId,
                    createBy: createBy
                }
            }
        ]
    };
    //trick 这是一个非常非常特殊的做法，不想使用多次查询
    const Model = require('@iota-fork/sequelize/lib/model')
    Model._validateIncludedElements.bind(models.UserGroupUser)(filterCondition);
    let filterQuery = models.UserGroupUser.QueryGenerator.selectQuery('UserGroupUser', filterCondition, models.UserGroupUser).slice(0, -1);
    let condition = {
        where: { id: { $notIn: dc.orm.literal(`(${filterQuery})`) } },
        include: [
            {
                model: models.SubUser,
                as: "subExt",
                where: { parentId: createBy }
            }
        ],
        attributes: ['id', 'username', 'email', 'mobile'],
        limit: limit,
        offset: offset,
        distinct: true,
        order: [[orderBy, orderDirection]]
    };
    let users = await models.User.findAndCountAll(condition);
    ctx.status = 200;
    ctx.body = {
        count: users.count,
        users: users.rows
    };
    //规范化返回
    if (ctx.iota.restful && typeof ctx.iota.restful.createNormalizer === 'function') {
        ctx.iota.restful.createNormalizer('users')(ctx);
    }
};

let createAddUserApi = function (app, opts) {
    return async (ctx, next) => {
        let createBy = ctx.session.user.id;
        let userGroupId = ctx.params.userGroupId;
        let models = ctx.iota.dc.models;
        let users = ctx.request.body.users;
        users = users ? users : [];
        users = uniqueArray(users, 'key');
        let userGroup = await models.UserGroup.findOne({
            where: { id: userGroupId }
        });
        if (userGroup) {
            let invalidUser = false;
            for (let user of users) {
                if (user.type && user.key) {
                    switch (user.type) {
                        case 'Sub':
                            //@TODO资源限制
                            //是否存在
                            let id = user.key;
                            let subUser = await models.User.findOne({
                                where: {
                                    id: id,
                                    type: models.User.UserTypes.Sub
                                },
                                attributes: ['id', 'username', 'email'],
                                include: [
                                    {
                                        model: models.SubUser,
                                        as: 'subExt',
                                        where: {
                                            userId: id,
                                            parentId: createBy
                                        }
                                    }
                                ]
                            });
                            if (!subUser) {
                                invalidUser = true;
                            } else {
                                //是否已经绑定该组
                                let inGroup = await models.UserGroupUser.findOne({
                                    where: {
                                        userId: id,
                                        userGroupId: userGroupId
                                    }
                                });
                                if (inGroup) {
                                    invalidUser = true;
                                } else {
                                    user.userId = subUser.id;
                                    user.username = subUser.username;
                                    user.email = subUser.email;
                                }
                            }
                            break;
                        case 'Invited':
                            //判断受邀用户是否存在且不是子用户
                            let email = user.key;
                            let invitedUser = await models.User.findOne({
                                where: {
                                    email: email,
                                    id: { $not: createBy },
                                    type: models.User.UserTypes.Master
                                },
                                attributes: ['id', 'username', 'email', 'gravatar']
                            });
                            if (!invitedUser) {
                                invalidUser = true;
                            } else {
                                //@TODO资源限制
                                //是否已经绑定该组
                                let inGroup = await models.UserGroupUser.findOne({
                                    where: {
                                        userId: invitedUser.id,
                                        userGroupId: userGroupId
                                    }
                                });
                                if (inGroup) {
                                    invalidUser = true;
                                } else {
                                    user.userId = invitedUser.id;
                                    user.username = invitedUser.username;
                                    user.email = invitedUser.email;
                                    user.garavatar = invitedUser.gravatar;
                                }
                            }
                            break;
                        default:
                            invalidUser = true;
                            break;
                    }
                }
            }
            if (invalidUser) {
                ctx.status = 400;
                ctx.body = {
                    name: 'invalid user',
                    message: `invalid user. user is not a subuser of parent or invited user dose not exist or invited user does not `
                };
            } else {
                let t = await ctx.iota.dc.orm.transaction();
                try {
                    for (let user of users) {
                        let invitedCode = user.type === 'Invited' ? uuid.v4() : '';
                        let userGroupUser = await models.UserGroupUser.create({
                            type: user.type,
                            invitedCode: invitedCode,
                            userGroupId: userGroupId,
                            userId: user.userId
                        }, { transaction: t });
                        user.enable = true;
                        user.id = userGroupUser.id;
                        user.createdAt = userGroupUser.createdAt;
                        if (user.type === 'Invited') {
                            user.accept = false;
                            sendInvitedNotice(ctx, invitedCode, userGroupId, user, ctx.session.user, opts);
                            let username = user.username;
                            user.username = '';
                            // 不等待
                            if (!opts.disableEmail) {
                                sendInvitedEmail(ctx, user.email, invitedCode, userGroupId, username, user.gravatar, ctx.session.user.username, opts);
                            }
                        }
                    }
                    await t.commit();
                    ctx.status = 200;
                    ctx.body = users;
                } catch (e) {
                    await t.rollback();
                    throw e;
                }
            }
        } else {
            ctx.status = 404;
            ctx.body = {
                name: 'invalid user group',
                message: `invalid user group ${userGroupId}`
            };
        }
    };
};

let removeUser = async (ctx, next) => {
    const id = ctx.params.id;
    let ids = ctx.query.ids ? ctx.query.ids.split(',') : [];
    let userGroupId = ctx.params.userGroupId;
    let models = ctx.iota.dc.models;
    let invalid = false;
    if (id) {
        ids.push(id);
    }
    ids = uniqueArray(ids);
    if (ids.length > 0) {
        let result = await models.UserGroupUser.findAll({
            where: { id: { $in: ids }, userGroupId: userGroupId }
        });
        if (result.length < ids.length) {
            invalid = true;
        }
    } else {
        invalid = true;
    }
    if (invalid) {
        ctx.status = 404;
        ctx.body = {
            name: 'invalid users',
            message: `the users ${ids} of user group ${userGroupId} dose not exist.`
        };
        return;
    }
    try {
        await models.UserGroupUser.destroy({
            where: { id: { $in: ids }, userGroupId: userGroupId }
        });
        ctx.status = 204;
    } catch (e) {
        throw e;
    }
};

let updateAll = async function (ctx, ids, userGroupId, values, transaction) {
    const models = ctx.iota.dc.models;
    if (Array.isArray(ids)) {
        let condition = {
            where: { id: { $in: ids }, userGroupId: userGroupId }
        };
        if (transaction) {
            condition.transaction = transaction;
        }
        let result = await models.UserGroupUser.update(values, condition);
        return result[0];
    }
    else {
        return 0;
    }
};


let enable = async function (ctx, next) {
    const userGroupId = ctx.params.userGroupId;
    const ids = ctx.request.body.ids;
    let count = await updateAll(ctx, ids, userGroupId, { enable: true });
    if (count === 0) {
        ctx.status = 404;
    } else {
        ctx.status = 204;
    }
};

let disable = async function (ctx, next) {
    const userGroupId = ctx.params.userGroupId;
    const ids = ctx.request.body.ids;
    let count = await updateAll(ctx, ids, userGroupId, { enable: false });
    if (count === 0) {
        ctx.status = 404;
    } else {
        ctx.status = 204;
    }
};

let accept = function (opts) {
    return async (ctx, next) => {
        const userGroupId = ctx.params.userGroupId;
        const invitedCode = ctx.query.code;
        const models = ctx.iota.dc.models;
        let condition = {
            where: { invitedCode: invitedCode, accept: false, userGroupId: userGroupId }
        };
        let result = await models.UserGroupUser.update({ accept: true }, condition);
        if (result[0] === 0) {
            if (opts.redirect && opts.redirect.inviteError) {
                ctx.redirect(opts.redirect.inviteError);
            } else {
                ctx.status = 404;
                ctx.body = {
                    name: 'invalid invite',
                    message: 'invalid invite',
                    detail: ''
                }
            }
        } else {
            if (opts.redirect && opts.redirect.inviteSuccess) {
                ctx.redirect(opts.redirect.inviteSuccess);
            } else {
                ctx.status = 204;
            }
        }
    }
};

let emailVerify = async (ctx, next) => {
    const email = ctx.query.email;
    const createBy = ctx.session.user.id;
    const models = ctx.iota.dc.models;
    let invalid = false;
    if (Validator.isEmail(email)) {
        //存在的Master用户，且不是当前用户自己
        let user = await models.User.findOne({
            where: {
                id: { $not: createBy },
                email: email,
                type: models.User.UserTypes.Master
            },
            attributes: ['id', 'username', 'email'],
        });
        if (!user) {
            invalid = true;
        }
    } else {
        invalid = true;
    }
    if (invalid) {
        ctx.status = 400;
        ctx.body = {
            name: 'invalid email',
            message: 'email is invalid.'
        }
    } else {
        ctx.status = 204;
    }
};

let emailVerifyByGroup = async (ctx, next) => {
    const email = ctx.query.email;
    const createBy = ctx.session.user.id;
    const userGroupId = ctx.params.userGroupId;
    const models = ctx.iota.dc.models;
    let invalid = false;
    if (Validator.isEmail(email)) {
        //存在的用户且不是该组成员，且不是当前用户自己
        let user = await models.User.findOne({
            where: {
                id: { $not: createBy },
                email: email,
                type: models.User.UserTypes.Master
            },
            attributes: ['id', 'username', 'email'],
        });
        if (user) {
            let inGroup = await models.UserGroup.findOne({
                where: {
                    id: userGroupId,
                    createBy: createBy
                },
                include: [
                    {
                        model: models.UserGroupUser,
                        as: 'users',
                        where: {
                            userId: user.id,
                            userGroupId: userGroupId
                        }
                    }
                ]
            });
            if (inGroup) {
                invalid = true;
            }
        }
        else {
            invalid = true;
        }
    } else {
        invalid = true;
    }
    if (invalid) {
        ctx.status = 400;
        ctx.body = {
            name: 'invalid email',
            message: 'email is invalid or the use of this email has been invited.'
        }
    } else {
        ctx.status = 204;
    }
};

export default {
    createCreateApi,
    find,
    update,
    _delete,
    //user
    createAddUserApi,
    removeUser,
    enable,
    disable,
    accept,
    findSubUserNotInGroup,
    findUserInGroup,
    emailVerifyByGroup,
    emailVerify
}