import nodemailer from 'nodemailer';
import uid from 'uuid';

function findPasswordByEmail(opts) {
    return async function (ctx, next) {
        let id = ctx.query.id;
        let error = true;
        let dc = ctx.iota.dc.cache;
        let models = ctx.iota.dc.models;
        if (id) {
            try {
                let email = await dc.get(`findPassword=${id}`);
                if (email) {
                    let isregistered = await models.User.findOne({
                        where: { email: email }
                    });
                    if (isregistered) {
                        error = false;
                    }
                }
            } catch (e) {
                ctx.iota.logger.error(`path: ${ctx.path}, error: ${e}`);
                if (opts.redirect && opts.redirect.resetPwdInvalid) {
                    ctx.redirect(opts.redirect.resetPwdInvalid);
                }
                else {
                    ctx.status = 500;
                    ctx.body = {
                        name: 'server error',
                        message: 'an unexpected condition was encountered in the server and no more specific message is suitable.'
                    };
                }
                return false;
            }
        }
        if (error) {
            if (opts.redirect && opts.redirect.resetPwdInvalid) {
                ctx.redirect(opts.redirect.resetPwdInvalid);
            }
            else {
                ctx.status = 400;
                ctx.body = {
                    name: 'validation error',
                    message: 'invalid request message framing, malformed request syntax,or deceptive request routing.',
                    detail: 'invalid information'
                };
            }
        } else {
            if (opts.redirect && opts.redirect.resetPwd) {
                ctx.redirect(`${opts.redirect.resetPwd}?id=${id}`);
            }
            else {
                ctx.status = 204;
            }
        }
    }
}

function activeEmail(opts) {
    return async function (ctx, next) {
        let id = ctx.query.id;
        let error = true;
        let dc = ctx.iota.dc.cache;
        let models = ctx.iota.dc.models;
        let email;
        if (id) {
            try {
                email = await dc.get(`activateEmail=${id}`);
                if (email) {
                    await models.User.update({ actEmail: '1' }, { where: { email: email } });
                    error = false;
                }
            } catch (e) {
                ctx.iota.logger.error(`path: ${ctx.path}, error: ${e}`);
                if (opts.redirect && opts.redirect.activeEmailError) {
                    ctx.redirect(opts.redirect.activeEmailError);
                }
                else {
                    ctx.status = 500;
                    ctx.body = {
                        name: 'server error',
                        message: 'an unexpected condition was encountered in the server and no more specific message is suitable.'
                    };
                }
                return false;
            }
        }
        if (error) {
            if (opts.redirect && opts.redirect.activeEmailError) {
                ctx.redirect(opts.redirect.activeEmailError);
            }
            else {
                ctx.status = 400;
                ctx.body = {
                    name: 'validation error',
                    message: 'invalid request message framing, malformed request syntax,or deceptive request routing.',
                    detail: 'invalid information'
                };
            }
        } else {
            if (opts.redirect && opts.redirect.activeEmailSuccess) {
                ctx.redirect(opts.redirect.activeEmailSuccess);
            }
            else {
                ctx.status = 204;
            }
        }
    }
}

function changePasswordByEmail(opts) {
    return async function (ctx, next) {
        let info = ctx.request.body;
        let error = true;
        let dc = ctx.iota.dc.cache;
        let models = ctx.iota.dc.models;
        if (info && info.password && info.id) {
            try {
                let email = await dc.get(`findPassword=${info.id}`);
                if (email) {
                    await models.User.update({ password: info.password }, { where: { email: email } });
                    error = false;
                }
            } catch (e) {
                ctx.iota.logger.error(`path: ${ctx.path}, error: ${e}`);
                if (opts.redirect && opts.redirect.resetPwdError) {
                    ctx.redirect(opts.redirect.resetPwdError);
                }
                else {
                    ctx.status = 500;
                    ctx.body = {
                        name: 'server error',
                        message: 'an unexpected condition was encountered in the server and no more specific message is suitable.'
                    };

                }
                return false;
            }
        }
        if (error) {
            if (opts.redirect && opts.redirect.resetPwdError) {
                ctx.redirect(opts.redirect.resetPwdError);
            }
            else {
                ctx.status = 400;
                ctx.body = {
                    name: 'validation error',
                    message: 'invalid request message framing, malformed request syntax,or deceptive request routing.',
                    detail: 'invalid information'
                };
            }
        } else {
            if (opts.redirect && opts.redirect.resetPwdSuccess) {
                ctx.redirect(opts.redirect.resetPwdSuccess);
            }
            else {
                ctx.status = 204;
            }
        }
    }
}

function sendVerificationEmail(config, type) {
    return async (ctx, next) => {
        let info = ctx.request.body;
        let error = true;
        let username, gravatar, emailContent;
        let dc = ctx.iota.dc.cache;
        let models = ctx.iota.dc.models;
        let rslt = {};
        if (info && info.email && type) {
            try {
                let isregistered = await models.User.findOne({
                    where: { email: info.email },
                    attributes: ['username', 'gravatar']
                });

                if (isregistered) {
                    let data = isregistered.get({ plain: true });
                    username = data.username;
                    gravatar = data.gravatar;
                } else {
                    ctx.status = 403;
                    ctx.body = {
                        name: 'forbidden error',
                        message: 'the request was a valid request, but the server is refusing to respond to it.',
                        detail: 'unregistered email'
                    };
                    return false;
                }
                let smtpConfig = config.global.smtp || {
                    host: 'smtp.exmail.qq.com',
                    port: 465,
                    secure: true, // use SSL
                    auth: {
                        user: 'service@theiota.cn',
                        pass: 'IotaSM123_'
                    }
                };
                let transporter = nodemailer.createTransport(smtpConfig);
                let uuid = uid.v4();
                let exp = 86400000;//24小时->3600000*24
                if (type == 'password') {
                    if (typeof smtpConfig.createFindPasswordEmail === 'function') {
                        emailContent = smtpConfig.createFindPasswordEmail({
                            email: info.email,
                            uuid: uuid,
                            username: username,
                            gravatar: gravatar,
                            domain: config.global.domain || 'http://localhost',
                            prefix: config.global.prefix || ''
                        })
                    } else {
                        emailContent = createFindPasswordEmail(info.email, uuid, username, gravatar
                            , config.global.domain || 'http://localhost', config.global.prefix || '', smtpConfig);
                    }
                    await dc.extra(`findPassword=${uuid}`, info.email, 'PX', exp);
                }
                if (type == 'activation') {
                    if (typeof smtpConfig.createActivateEmail === 'function') {
                        smtpConfig.createActivateEmail({
                            email: info.email,
                            uuid: uuid,
                            username: username,
                            gravatar: gravatar,
                            domain: config.global.domain || 'http://localhost',
                            prefix: config.global.prefix || ''
                        })
                    } else {
                        emailContent = createActivateEmail(info.email, uuid, username, gravatar,
                            config.global.domain || 'http://localhost', config.global.prefix || '', smtpConfig);
                    }
                    await dc.extra(`activateEmail=${uuid}`, info.email, 'PX', exp);
                }
                if (emailContent) {
                    rslt = await transporter.sendMail(emailContent);
                    error = false;
                }
            } catch (e) {
                ctx.status = 500;
                ctx.body = {
                    name: 'server error',
                    message: 'an unexpected condition was encountered in the server and no more specific message is suitable.'
                };
                ctx.iota.logger.error(`path: ${ctx.path},info: ${JSON.stringify(rslt)}, error: ${e}`);
                //ctx.iota.logger.error(e.stack);
                return;
            }
        }
        if (error) {
            ctx.status = 400;
            ctx.body = {
                name: 'validation error',
                message: 'invalid request message framing, malformed request syntax,or deceptive request routing.',
                detail: 'incomplete or invalid request'
            };
        } else {
            ctx.status = 204;
        }
    }
}

function createFindPasswordEmail(email, uuid, username, gravatar, domain, prefix, smtpConfig) {
    return {
        from: smtpConfig.auth.user, // sender address
        to: email, // list of receivers
        subject: '重置密码', // 主题
        text: '重置密码', // 这个没什么用
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
        <h1 class="user">${username}，您好！</h1>
    </header>
    <main class="main">
        <h2 class="message">
            您刚刚请求了重置密码，请点击重置密码按钮修改登录密码：</h2>
        <a class="btn"
           href="${domain}${prefix}/accounts/password/forget?id=${uuid}" target="_blank">重置密码</a>
        <p class="hint">
            如果按钮无法点击，请直接访问以下链接： <br/>
            <a href="${domain}${prefix}/accounts/password/forget?id=${uuid}" target="_blank">${domain}${prefix}/accounts/password/forget?id=${uuid}</a>
            <br/>（为保障账号安全性，该链接仅在 24 小时内有效。如果您并不想更换密码，无需进行任何操作。）</p>
    </main>
    <footer>
        <p class="service">
            邮件无需回复。
        </p>
    </footer>
</article>
</html>`
    }
}

function createActivateEmail(email, uuid, username, gravatar, domain, prefix, smtpConfig) {
    return {
        from: smtpConfig.auth.user, // sender address
        to: email, // list of receivers
        subject: '验证邮箱', // 主题
        text: '验证邮箱', // 这个没什么用
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
        <h1 class="user">${username}，您好！</h1>
    </header>
    <main class="main">
        <h2 class="message">欢迎使用，请验证邮箱。 </h2>
        <a class="btn"
           href="${domain}${prefix}/accounts/email/active?id=${uuid}" target="_blank">验证邮箱</a>
        <p class="hint">
            如果按钮无法点击，请直接访问以下链接： <br/>
            <a href="${domain}${prefix}/accounts/email/active?id=${uuid}" target="_blank">${domain}${prefix}/accounts/email/active?id=${uuid}</a><br/>
            （为保障账号安全性，该链接仅在 24 小时内有效。）</p>
    </main>
    <footer>
        <p class="service">
            邮件无需回复。
        </p>
    </footer>
</article>
</html>`
    }
}

export default {
    findPasswordByEmail,
    activeEmail,
    changePasswordByEmail,
    sendVerificationEmail
}
