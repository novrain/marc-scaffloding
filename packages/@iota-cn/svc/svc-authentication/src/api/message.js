import request from "request";
import querystring from 'querystring';

function buildWsseHeader(appKey, appSecret){
    var crypto = require('crypto');
    var util = require('util');

    var time = new Date(Date.now()).toISOString().replace(/.[0-9]+\Z/, 'Z'); //Created
    var nonce = crypto.randomBytes(64).toString('hex'); //Nonce
    var passwordDigestBase64Str = crypto.createHash('sha256').update(nonce + time + appSecret).digest('base64'); //PasswordDigest

    return util.format('UsernameToken Username="%s",PasswordDigest="%s",Nonce="%s",Created="%s"', appKey, passwordDigestBase64Str, nonce, time);
}

function buildRequestBody(sender, receiver, templateId, templateParas, statusCallBack, signature){
    if (null !== signature && signature.length > 0) {
        return querystring.stringify({
            'from': sender,
            'to': receiver,
            'templateId': templateId,
            'templateParas': templateParas,
            'statusCallback': statusCallBack,
            'signature': signature
        });
    }

    return querystring.stringify({
        'from': sender,
        'to': receiver,
        'templateId': templateId,
        'templateParas': templateParas,
        'statusCallback': statusCallBack
    });
}

let sendCaptchaSMS = function (opts) {
    return async function (ctx, next) {
        let mobile = ctx.request.body.mobile + '';
        if (mobile && (/^1\d{10}$/.test(mobile))) {
            try {
                // let apiKey = opts && opts.message && opts.message.apiKey ? opts.message.apiKey : '08a32b5cc39cb8a56ad23a3bc6e5c51a';

                const appKey = opts && opts.message && opts.message.appKey ? opts.message.appKey : 'oFy5133360gxXBgXBO82qcbXMGm8';
                const appSecret = opts && opts.message && opts.message.appSecret ? opts.message.appSecret : '69GAxx3MV75s4H7ES0A03oQZo4yD';
                const signature = 'iOTA';
                let templateParas = [];
                const sender = '8819021963516'; //国内短信签名通道号或国际/港澳台短信通道号
                const receiver = mobile;
                let uri = opts && opts.message && opts.message.uri ? opts.message.uri : 'https://api.rtc.huaweicloud.com:10443/sms/batchSendSms/v1';
                let statusCallBack = '';
                const templateId = 'b30ed0ad4f464181b6dfe7757162f823';
                let random = randomNumber(6);
                templateParas.push(random)
                const body = buildRequestBody(sender, receiver, templateId, JSON.stringify(templateParas), statusCallBack, signature);
                let params = {
                    uri: uri,
                    method: 'POST',
                    body: body,
                    encoding: 'utf8',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                        'Authorization': 'WSSE realm="SDP",profile="UsernameToken",type="Appkey"',
                        'X-WSSE': buildWsseHeader(appKey, appSecret)
                    },
                    rejectUnauthorized: false //为防止因HTTPS证书认证失败造成API调用失败,需要先忽略证书信任问题
                };

                let content = `【iOTA】欢迎使用iOTA，您的验证码是：${random}，请在10分钟内输入。请勿告诉其他人。`;

                let exp = 600000;//10分钟->10*60*1000
                let aday = 86400000; //24小时->60*60*1000*24

                let harassment = await ctx.iota.dc.cache.get(`harassmentMobile=${mobile}`);
                if (harassment) {
                    harassment = parseInt(harassment);
                    if (harassment < 5) {
                        harassment = harassment + 1;
                        await ctx.iota.dc.cache.extra(`harassmentMobile=${mobile}`, harassment, 'PX', aday);
                    } else {
                        ctx.status = 403;
                        ctx.body = {
                            name: 'forbidden error',
                            message: 'the request was a valid request, but the server is refusing to respond to it.',
                            detail: '5 text messages can be sent within one day by 1 person'
                        };
                        return false;
                    }
                } else {
                    await ctx.iota.dc.cache.extra(`harassmentMobile=${mobile}`, 1, 'PX', aday);
                }

                await createPromiseRequest(params);
                await ctx.iota.dc.cache.extra(`mobileRegister=${mobile}`, random, 'PX', exp);
                ctx.status = 204;

            } catch (e) {
                ctx.status = 500;
                ctx.body = {
                    name: 'server error',
                    message: 'an unexpected condition was encountered in the server and no more specific message is suitable.'
                };
                if (e instanceof Error) {
                    ctx.iota.logger.error(`path: ${ctx.path}, mobile: ${mobile}, error: ${e.message}, ${e.stack}`);
                } else {
                    ctx.iota.logger.error(`path: ${ctx.path}, mobile: ${mobile}, error: ${JSON.stringify(e)}`);
                }
            }
        } else {
            ctx.status = 400;
            ctx.body = {
                name: 'validation error',
                message: 'invalid request message framing, malformed request syntax,or deceptive request routing.',
                detail: 'invalid mobile'
            };
        }
    }
};

let fakeSMS = async function (ctx, next) {
    let mobile = ctx.request.body.mobile + '';
    let aday = 86400000; //24小时->60*60*1000*24
    if (mobile && (/^1\d{10}$/.test(mobile))) {
        try {
            await ctx.iota.dc.cache.extra(`mobileRegister=${mobile}`, '123456', 'PX', aday);
            ctx.status = 204;
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
            detail: 'invalid mobile'
        };
    }
};

function randomNumber(n) {
    var rnd = "";
    for (var i = 0; i < n; i++)
        rnd += Math.floor(Math.random() * 10);
    return rnd;
}

function createPromiseRequest(params) {
    return new Promise((resolve, reject)=> {
        request(params, (error, response, body)=> {
            if (error || !body || JSON.parse(body).code != "000000") {
                let data = {};
                data.error = error;
                data.body = body;
                reject(data);
            } else {
                resolve(body);
            }
        })
    });
}

export default{
    fakeSMS,
    sendCaptchaSMS
}
