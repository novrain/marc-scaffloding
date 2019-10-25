/**
 * Created by guan on 2017/2/24.
 */
export default class alipayMmw {
    constructor(opts) {
        this.opts = opts;
        this.aliPay = opts.aliPay;
    };

    verity = function (params, callback) {
        let mysign = this.getMySign(params);
        let sign = params["sign"] ? params["sign"] : "";
        if (mysign == sign) {
            let responseTxt = 'true';
            if (params["notify_id"]) {
                //获取远程服务器ATN结果，验证是否是支付宝服务器发来的请求
                let partner = this.aliPay.partner;
                let veryfy_path = this.aliPay.HTTPS_VERIFY_PATH + "partner=" + partner + "&notify_id=" + params["notify_id"];
                this.requestUrl(this.aliPay.ALIPAY_HOST, veryfy_path, function (responseTxt) {
                    if (responseTxt) {
                        callback(true);
                    } else {
                        callback(false);
                    }
                });
            }
        } else {
            callback(false);
        }
    };
    getMySign = function (params) {
        console.log('test getMySign')
        let sPara = [];//转换为数组利于排序 除去空值和签名参数
        if (!params) return null;
        for (let key in params) {
            if ((!params[key]) || key == "sign" || key == "sign_type") {
                console.log('null:' + key);
                continue;
            }
            ;
            sPara.push([key, params[key]]);
        }
        sPara.sort();
        //生成签名结果
        let prestr = "";
        //把数组所有元素，按照“参数=参数值”的模式用“&”字符拼接成字符串
        for (let i2 = 0; i2 < sPara.length; i2++) {
            let obj = sPara[i2];
            if (i2 == sPara.length - 1) {
                prestr = prestr + obj[0] + "=" + obj[1];
            } else {
                prestr = prestr + obj[0] + "=" + obj[1] + "&";
            }

        }
        prestr = prestr + this.aliPay.key; //把拼接后的字符串再与安全校验码直接连接起来
        //body=Hello&buyer_email=13758698870&buyer_id=2088002007013600&discount=-5&extra_common_param=你好，这是测试商户的广告。&gmt_close=2008-10-22 20:49:46&gmt_create=2008-10-22 20:49:31&gmt_payment=2008-10-22 20:49:50&gmt_refund=2008-10-29 19:38:25&is_total_fee_adjust=N&notify_id=70fec0c2730b27528665af4517c27b95&notify_time=2009-08-12 11:08:32&notify_type=交易状态同步通知(trade_status_sync)&out_trade_no=3618810634349901&payment_type=1&price=10.00&quantity=1&refund_status=REFUND_SUCCESS&seller_email=chao.chenc1@alipay.com&seller_id=2088002007018916&sign=_p_w_l_h_j0b_gd_aejia7n_ko4_m%2Fu_w_jd3_nx_s_k_mxus9_hoxg_y_r_lunli_pmma29_t_q%3D%3D&sign_type=DSA&subject=iphone手机&total_fee=10.00&trade_no=2008102203208746&trade_status=TRADE_FINISHED&use_coupon=N

        let crypto = require('crypto');
        return crypto.createHash('md5').update(prestr, this.aliPay.input_charset).digest("hex");
    };
    requestUrl = function (host, path, callback) {

        let https = require('https');
        let options = {
            host: host,
            port: 443,
            path: path,
            method: 'GET'
        };
        let req = https.request(options, function (res) {
            res.on('data', function (d) {
                callback(d);
            });
        });
        req.end();
        req.on('error', function (e) {
            console.log(e)
        })
    };
    create = async (ctx, next) => {
        let that = this;
        let models = ctx.iota.dc.models;
        let data = ctx.request.body;
        let date = new Date();
        let year = date.getFullYear();
        let initMonth = date.getMonth() + 1;
        let initDay = date.getDate();
        let day = initDay > 10 ? initDay + '' : '0' + initDay;
        let month = initMonth > 10 ? initMonth + '' : '0' + initMonth;
        let out_trade_no = year + month + day + Math.random().toString().substr(2, 10);
        //if (ctx.session && ctx.session.user && ctx.session.user.id) {
        //    try {
        //        account = await models.Account.findOne({where: {userId: ctx.session.user.id}});
        //    } catch (e) {
        //        ctx.status = 500;
        //        ctx.body = {
        //            name: 'Server error',
        //            message: 'account query failure.'
        //        };
        //        ctx.iota.logger.error(`path: ${ctx.path}, error: ${e}`);
        //    }
        //} else {
        //    ctx.status = 402;
        //    ctx.body = {
        //        name: 'Storage error',
        //        message: `Client or server's storage was not stored properly.`
        //    };
        //    return false;
        //}
        if (data) {
            //try{
            //    let service=await models.ServicePackage.findOne({where: {id: data.servicePackageId}});
            //}
            //请与贵网站订单系统中的唯一订单号匹配
            //let out_trade_no = out_trade_no;
            //订单名称，显示在支付宝收银台里的“商品名称”里，显示在支付宝的交易管理的“商品名称”的列表里。
            let subject = data.subject;
            //订单描述、订单详细、订单备注，显示在支付宝收银台里的“商品描述”里
            let body = data.alibody;
            //订单总金额，显示在支付宝收银台里的“应付总额”里
            let total_fee = data.fee;
            //扩展功能参数——默认支付方式//
            //默认支付方式，取值见“即时到帐接口”技术文档中的请求参数列表
            let paymethod = "";
            //默认网银代号，代号列表见“即时到帐接口”技术文档“附录”→“银行列表”
            let defaultbank = "";
            //扩展功能参数——防钓鱼//
            //防钓鱼时间戳
            let anti_phishing_key = "";
            //获取客户端的IP地址，建议：编写获取客户端IP地址的程序
            let exter_invoke_ip = "";
            //扩展功能参数——其他///
            //自定义参数，可存放任何内容（除=、&等特殊字符外），不会显示在页面上
            let extra_common_param = "";
            //默认买家支付宝账号
            let buyer_email = "";
            //商品展示地址，要用http:// 格式的完整路径，不允许加?id=123这类自定义参数
            let show_url = "http://www.xxx.com/order/myorder.jsp";
            //扩展功能参数——分润(若要使用，请按照注释要求的格式赋值)//
            //提成类型，该值为固定值：10，不需要修改
            let royalty_type = "";
            //提成信息集
            let royalty_parameters = "";
            //把请求参数打包成数组
            let sParaTemp = [];
            sParaTemp.push(["payment_type", "1"]);
            sParaTemp.push(["out_trade_no", out_trade_no]);
            sParaTemp.push(["subject", subject]);
            sParaTemp.push(["body", body]);
            sParaTemp.push(["total_fee", total_fee]);
            //    sParaTemp.push(["show_url", show_url]);
            sParaTemp.push(["paymethod", paymethod]);
            sParaTemp.push(["defaultbank", defaultbank]);
            sParaTemp.push(["anti_phishing_key", anti_phishing_key]);
            sParaTemp.push(["exter_invoke_ip", exter_invoke_ip]);
            sParaTemp.push(["extra_common_param", extra_common_param]);
            sParaTemp.push(["buyer_email", buyer_email]);
            sParaTemp.push(["royalty_type", royalty_type]);
            sParaTemp.push(["royalty_parameters", royalty_parameters]);

            let create_direct_pay_by_user = function (sParaTemp) {
                //增加基本配置
                sParaTemp.push(["service", "create_direct_pay_by_user"]);
                sParaTemp.push(["partner", that.aliPay.partner]);
                sParaTemp.push(["return_url", that.aliPay.return_url]);
                sParaTemp.push(["notify_url", that.aliPay.notify_url]);
                sParaTemp.push(["seller_email", that.aliPay.seller_email]);
                sParaTemp.push(["_input_charset", that.aliPay.input_charset]);


                let buildURL = function (SparaTemp) {
                    let buildRequestPara = function (SparaTemp) {
                        let sPara = [];
                        //除去数组中的空值和签名参数
                        for (let i1 = 0; i1 < sParaTemp.length; i1++) {
                            let value = sParaTemp[i1];
                            if (value[1] == null || value[1] == "" || value[0] == "sign"
                                || value[0] == "sign_type") {
                                continue;
                            }
                            sPara.push(value);
                        }
                        sPara.sort();
                        //生成签名结果
                        let prestr = "";
                        //把数组所有元素，按照“参数=参数值”的模式用“&”字符拼接成字符串
                        for (let i2 = 0; i2 < sPara.length; i2++) {
                            let obj = sPara[i2];
                            if (i2 == sPara.length - 1) {
                                prestr = prestr + obj[0] + "=" + obj[1];
                            } else {
                                prestr = prestr + obj[0] + "=" + obj[1] + "&";
                            }
                        }
                        prestr = prestr + that.aliPay.key; //把拼接后的字符串再与安全校验码直接连接起来
                        let crypto = require('crypto');
                        let mysign = crypto.createHash('md5').update(prestr, that.aliPay.input_charset).digest("hex");
                        //签名结果与签名方式加入请求提交参数组中
                        sPara.push(["sign", mysign]);
                        sPara.push(["sign_type", that.aliPay.sign_type]);
                        return sPara;
                    };
                    //待请求参数数组
                    let sPara = buildRequestPara(sParaTemp);
                    let path = that.aliPay.ALIPAY_PATH;
                    for (let i3 = 0; i3 < sPara.length; i3++) {
                        let obj = sPara[i3];
                        let name = obj[0];
                        let value = encodeURIComponent(obj[1]);
                        if (i3 < (sPara.length - 1)) {
                            path = path + name + "=" + value + "&";
                        } else {
                            path = path + name + "=" + value;
                        }
                    }
                    return path.toString();
                };
                return buildURL(sParaTemp)
            };
            let sURL = create_direct_pay_by_user(sParaTemp);
            console.log("https://" + that.aliPay.ALIPAY_HOST + "/" + sURL);
            ctx.body = { url: "https://" + that.aliPay.ALIPAY_HOST + "/" + sURL };
            ctx.status = 200;
        }
    };

    payNotify = async (ctx, next) => {
        //获取支付宝异步通知返回参数
        let that = this;
        let params = ctx.query;
        let out_trade_no = ctx.query.out_trade_no;      //获取订单号
        let trade_no = ctx.query.trade_no;              //支付宝交易号
        let total_fee = ctx.query.total_fee;              //总金额
        let subject = ctx.query.subject;                //商品名称、订单名称
        let body = ctx.query.body ? ctx.query.body : '';
        let buyer_email = ctx.query.buyer_email;
        let trade_status = ctx.query.trade_status;
        await new Promise(function (resolve, reject) {
            that.verity(params, function (result) {
                if (result) {
                    resolve(result)
                } else {
                    reject(result)
                }
            });
        }).then(() => {
            if (trade_status == "TRADE_FINISHED" || trade_status == "TRADE_SUCCESS") {
                //商户自己的逻辑
            }
            ctx.status = 200;
            ctx.body = 'success';
        }
            ).catch((err) => {
                console.log(err);
                ctx.status = 200;
                ctx.body = 'fail'
            });
    };

    payReturn = async (ctx, next) => {
        //获取支付宝同步通知返回参数
        let that = this;
        let params = ctx.query;
        let trade_no = ctx.query.trade_no;
        let out_trade_no = ctx.query.out_trade_no;
        let fee = ctx.query.total_fee;
        let subject = ctx.query.subject;
        let body = ctx.query.body ? ctx.query.body : "";
        let buyer_email = ctx.query.buyer_email;
        let trade_status = ctx.query.trade_status;
        await new Promise(function (resolve, reject) {
            that.verity(params, function (result) {
                if (result) {
                    resolve(result)
                } else {
                    reject(result)
                }
            })
        }).then((result) => {
            //商户自己的逻辑
            ctx.status = 200;
            ctx.body = "success"
        }
            ).catch((err) => {
                console.log(err);
                ctx.status = 400;
                ctx.body = 'fail'
            });
        //that.verity(params, function (result) {
        //    console.log('result',result);
        //    //如果成功，更新表记录
        //    if (result) {
        //        if (trade_status == "TRADE_FINISHED") {
        //            //判断该笔订单是否在商户网站中已经做过处理
        //            //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
        //            //如果有做过处理，不执行商户的业务程序
        //        } else if (trade_status = "TRADE_SUCCESS") {
        //            //判断该笔订单是否在商户网站中已经做过处理
        //            //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
        //            //如果有做过处理，不执行商户的业务程序
        //            //注意：
        //            //该种交易状态只在一种情况下出现——开通了高级即时到账，买家付款成功后。
        //        }
        //        ctx.status = 200;
        //        ctx.body = "success"
        //    }
        //    ctx.status = 200;
        //    ctx.body = "fail"
        //})
    }
}