import request from "request";

let sendCaptchaSMS = function (opts) {
    // 根据选择的短信提供商，实现自己的短信提醒
    return fakesms
}

let fakesms = async function (ctx, next) {
    let mobile = ctx.request.body.mobile + '';
    let aday = 86400000; //24小时->60*60*1000*24
    if (mobile && (/^1\d{10}$/.test(mobile))) {
        try {
            await ctx.iota.dc.cache.extra(`mobileregister=${mobile}`, '123456', 'px', aday);
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

function randomnumber(n) {
    var rnd = "";
    for (var i = 0; i < n; i++)
        rnd += math.floor(math.random() * 10);
    return rnd;
}

function createpromiserequest(params) {
    return new promise((resolve, reject) => {
        request(params, (error, response, body) => {
            if (error || !body || json.parse(body).code != "000000") {
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

export default {
    fakesms,
    sendCaptchaSMS
}
