var util = require('./util');
var request = require('request');
var md5 = require('blueimp-md5');

exports = module.exports = WXPay;


function WXPay() {

    if (!(this instanceof WXPay)) {
        return new WXPay(arguments[0]);
    }

    this.options = arguments[0];
    this.wxpayID = { appid: this.options.appid, mch_id: this.options.mch_id };
}

WXPay.mix = function () {

    switch (arguments.length) {
        case 1:
            var obj = arguments[0];
            for (var key in obj) {
                if (WXPay.prototype.hasOwnProperty(key)) {
                    throw new Error('Prototype method exist. method: ' + key);
                }
                WXPay.prototype[key] = obj[key];
            }
            break;
        case 2:
            var key = arguments[0].toString(), fn = arguments[1];
            if (WXPay.prototype.hasOwnProperty(key)) {
                throw new Error('Prototype method exist. method: ' + key);
            }
            WXPay.prototype[key] = fn;
            break;
    }
};


WXPay.mix('option', function (option) {
    for (var k in option) {
        this.options[k] = option[k];
    }
});


WXPay.mix('sign', function (param) {

    var querystring = Object.keys(param).filter(function (key) {
        return param[key] !== undefined && param[key] !== '' && ['pfx', 'partner_key', 'sign', 'key'].indexOf(key) < 0;
    }).sort().map(function (key) {
        return key + '=' + param[key];
    }).join("&") + "&key=" + this.options.partner_key;

    return md5(querystring).toUpperCase();
});


WXPay.mix('createUnifiedOrder', function (opts, fn) {

    opts.nonce_str = opts.nonce_str || util.generateNonceString();
    util.mix(opts, this.wxpayID);
    opts.sign = this.sign(opts);

    request({
        url: "https://api.mch.weixin.qq.com/pay/unifiedorder",
        method: 'POST',
        body: util.buildXML(opts),
        agentOptions: {
            pfx: this.options.pfx,
            passphrase: this.options.mch_id
        }
    }, function (err, response, body) {
        util.parseXML(body, fn);
    });
});

WXPay.mix('getBrandWCPayRequestParams', function (order, fn) {

    order.trade_type = "JSAPI";
    var _this = this;
    this.createUnifiedOrder(order, function (err, data) {
        var reqparam = {
            appId: _this.options.appid,
            timeStamp: Math.floor(Date.now() / 1000) + "",
            nonceStr: data.nonce_str,
            package: "prepay_id=" + data.prepay_id,
            signType: "MD5"
        };
        reqparam.paySign = _this.sign(reqparam);
        fn(err, reqparam);
    });
});

WXPay.mix('createMerchantPrepayUrl', function (param) {

    param.time_stamp = param.time_stamp || Math.floor(Date.now() / 1000);
    param.nonce_str = param.nonce_str || util.generateNonceString();
    util.mix(param, this.wxpayID);
    param.sign = this.sign(param);

    var query = Object.keys(param).filter(function (key) {
        return ['sign', 'mch_id', 'product_id', 'appid', 'time_stamp', 'nonce_str'].indexOf(key) >= 0;
    }).map(function (key) {
        return key + "=" + encodeURIComponent(param[key]);
    }).join('&');

    return "weixin://wxpay/bizpayurl?" + query;
});


WXPay.mix('useWXCallback', function (fn) {
    return async function (ctx, next) {
        ctx.success = function () {
            ctx.response.set('Content-type', 'application/xml');
            ctx.status = 200;
            ctx.body = util.buildXML({ xml: { return_code: 'SUCCESS' } });
        };
        ctx.fail = function () {
            ctx.response.set('Content-type', 'application/xml');
            ctx.status = 200;
            ctx.body = util.buildXML({ xml: { return_code: 'FAIL' } });
        };
        let xml = await new Promise((resolve, reject) => {
            util.pipe(ctx.req, function (err, data) {
                var xml = data.toString('utf8');
                resolve(xml)
            });
        });
        let msg = await new Promise((resovle, reject) => {
            util.parseXML(xml, function (err, msg) {
                resovle(msg);
            });
        });
        ctx.request.body = msg;
        await fn(ctx, next);
    };
});


WXPay.mix('queryOrder', function (query, fn) {

    if (!(query.transaction_id || query.out_trade_no)) {
        fn(null, { return_code: 'FAIL', return_msg: '缺少参数' });
    }

    query.nonce_str = query.nonce_str || util.generateNonceString();
    util.mix(query, this.wxpayID);
    query.sign = this.sign(query);

    request({
        url: "https://api.mch.weixin.qq.com/pay/orderquery",
        method: "POST",
        body: util.buildXML({ xml: query })
    }, function (err, res, body) {
        util.parseXML(body, fn);
    });
});


WXPay.mix('closeOrder', function (order, fn) {

    if (!order.out_trade_no) {
        fn(null, { return_code: "FAIL", return_msg: "缺少参数" });
    }

    order.nonce_str = order.nonce_str || util.generateNonceString();
    util.mix(order, this.wxpayID);
    order.sign = this.sign(order);

    request({
        url: "https://api.mch.weixin.qq.com/pay/closeorder",
        method: "POST",
        body: util.buildXML({ xml: order })
    }, function (err, res, body) {
        util.parseXML(body, fn);
    });
});


WXPay.mix('refund', function (order, fn) {
    if (!(order.transaction_id || order.out_refund_no)) {
        fn(null, { return_code: 'FAIL', return_msg: '缺少参数' });
    }

    order.nonce_str = order.nonce_str || util.generateNonceString();
    util.mix(order, this.wxpayID);
    order.sign = this.sign(order);

    request({
        url: "https://api.mch.weixin.qq.com/secapi/pay/refund",
        method: "POST",
        body: util.buildXML({ xml: order }),
        agentOptions: {
            pfx: this.options.pfx,
            passphrase: this.options.mch_id
        }
    }, function (err, response, body) {
        util.parseXML(body, fn);
    });
});

