/**
 * Created by kadven on 2017/2/27.
 */
import { valBetween } from '@iota-cn/svc-util';
import WXpay from '../mw/wechat';
import { changeBalance } from './index';
import TRANSACTION_STATUS from '../model/const';
import account_service_package from './account_service_package';
import moment from 'moment';
export default class Order {
    constructor(opts) {
        this.opts = opts;
        this.wxpay = WXpay({
            appid: opts.wechatPay.appid,
            mch_id: opts.wechatPay.mch_id,
            partner_key: opts.wechatPay.partner_key, //微信商户平台API密钥
        });
        this.aliPay = opts.aliPay;
    }

    async find(ctx, next) {
        let id = ctx.params.id;
        let limit = valBetween(ctx.query.limit, 1, 200, 20);
        let offset = parseInt(ctx.query.offset) || 0;
        let state = ctx.query.state;
        let models = ctx.iota.dc.models;
        let account;
        account = await models.Account.findOne({ where: { userId: ctx.session.user.id } });
        if (id) {
            let order = await models.Order.findOne({
                include: [{ model: models.ServicePackage, as: 'service' }],
                where: { id: id }
            });
            order.fee = order.fee / 100;
            order.oldBalance = order.oldBalance / 100;
            order.newBalance = order.newBalance / 100;
            ctx.status = 200;
            ctx.body = order;
        } else {
            let condition = {
                where: state ? { paymentState: state } : {},
                limit: limit,
                offset: offset,
                order: [['updatedAt', 'DESC']]
            };
            condition.where.accountId = account.id;
            let orders = await models.Order.findAndCountAll(condition);
            orders.rows.forEach(order => {
                order.fee = order.fee / 100;
                order.oldBalance = order.oldBalance / 100;
                order.newBalance = order.newBalance / 100;
            })
            ctx.status = 200;
            ctx.body = {
                total: orders.count,
                orders: orders.rows
            }
        }
    }

    create = async (ctx, next) => {
        let that = this;
        let account;
        let data = ctx.request.body;
        let models = ctx.iota.dc.models;
        account = await models.Account.findOne({ where: { userId: ctx.session.user.id } });
        let acc_sp = await models.AccountServicePackage.findAll({
            where: {
                accountId: account.id,
                endTime: {
                    $gt: new Date()
                }
            },
            include: [
                {
                    model: models.ServicePackage,
                    as: 'servicePackage',
                    where: {
                        serviceType: { $not: models.ServicePackage.ServiceType.Free }// 如果是免费的服务，还可以继续买
                    }
                }
            ]
        });
        if (acc_sp.length > 0) {
            ctx.status = 409;
            ctx.body = {
                result: 'conflict err',
                message: 'You have already purchased the service'
            }
            return;
        }
        let service = await models.ServicePackage.findOne({
            where: {
                id: data.servicePackageId,
                serviceType: { $not: models.ServicePackage.ServiceType.Free }// 如果是免费的服务，还可以继续买
            }
        });
        let date = new Date();
        let year = date.getFullYear();
        let initMonth = date.getMonth() + 1;
        let initDay = date.getDate();
        let day = initDay > 10 ? initDay + '' : '0' + initDay;
        let month = initMonth > 10 ? initMonth + '' : '0' + initMonth;
        let out_trade_no = year + month + day + Math.random().toString().substr(2, 10);
        let order = {
            out_trade_no: out_trade_no,
            service_name: service.name,
            fee: service.price,
            oldBalance: account.balance,
            newBalance: account.balance,
            time_start: date,
            // time_end: date.toLocaleString(),
            payChannel: data.type,
            paymentSate: TRANSACTION_STATUS.UNPAID,
            transaction_id: data.transaction_id,
            bank_type: data.bank_type,
            openid: data.openid,
            standard: data.standard,
            servicePackageId: data.servicePackageId,
            product_id: data.product_id,
            accountId: account.id
        };
        let created_order = await models.Order.create(order);
        created_order.oldBalance = created_order.oldBalance / 100;
        created_order.newBalance = created_order.newBalance / 100;
        if (data.type == 'wechat') {
            await new Promise(function (resolve, reject) {
                that.wxpay.createUnifiedOrder({
                    body: "以太数据",
                    out_trade_no: out_trade_no,
                    total_fee: service.price,
                    spbill_create_ip: that.opts.wechatPay.spbill_create_ip,
                    notify_url: `${that.opts.global.domain || 'http://localhost'}${that.opts.global.prefix}${that.opts.wechatPay.order_notify_url}`,
                    trade_type: 'NATIVE',
                    product_id: data.product_id,
                    attach: 'order'
                    //openid: 'o88AAv_hXfeS-5KTp_VRBLrlQoR4'
                }, function (err, result) {
                    if (err) {
                        reject(err);
                    } else {
                        resolve(result)
                    }

                });
            }).then((result) => {
                created_order.fee = created_order.fee / 100;
                ctx.status = 200;
                ctx.body = { result: result, order: created_order };
            }).catch((err) => {
                ctx.status = 400;
            });
        } else if (data.type == 'alipay') {
            //请与贵网站订单系统中的唯一订单号匹配
            //let out_trade_no = out_trade_no;
            //订单名称，显示在支付宝收银台里的“商品名称”里，显示在支付宝的交易管理的“商品名称”的列表里。
            let subject = data.subject;
            //订单描述、订单详细、订单备注，显示在支付宝收银台里的“商品描述”里
            let body = data.alibody;
            //订单总金额，显示在支付宝收银台里的“应付总额”里
            let total_fee = service.price / 100;
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
                sParaTemp.push(["return_url", `${that.opts.global.domain || 'http://localhost'}${that.aliPay.return_order_redirect}`]);
                sParaTemp.push(["notify_url", `${that.opts.global.domain || 'http://localhost'}${that.opts.global.prefix}${that.aliPay.order_notify_url}`]);
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
            created_order.fee = created_order.fee / 100;
            ctx.body = { url: "https://" + that.aliPay.ALIPAY_HOST + "/" + sURL, order: created_order };
            ctx.status = 200;
        } else if (data.type == 'balance') {
            created_order.fee = created_order.fee / 100;
            ctx.status = 200;
            ctx.body = created_order;
        }
    }

    onAliNotifyForOrder = async (ctx, next) => {
        //获取支付宝异步通知返回参数
        let that = this;
        let params = ctx.request.body;
        let out_trade_no_test = ctx.request.query.out_trade_no_test ? ctx.request.query.out_trade_no_test : undefined;
        let out_trade_no = out_trade_no_test ? out_trade_no_test : params.out_trade_no;      //获取订单号
        let trade_no = params.trade_no;              //支付宝交易号
        let total_fee = params.total_fee;              //总金额
        let subject = params.subject;                //商品名称、订单名称
        let body = params.body ? params.body : '';
        let buyer_email = params.buyer_email;
        let time_end = moment(params.gmt_payment, 'YYYY-MM-DD HH:mm:ss').toDate();
        let trade_status = params.trade_status;
        let models = ctx.iota.dc.models;
        let t = ctx.iota.session ? ctx.iota.session.transaction : undefined;
        let isLocalTransaction = !t;
        await new Promise(function (resolve, reject) {
            that.verity(params, async function (valid) {
                if (!valid) {
                    ctx.status = 200;
                    ctx.body = 'fail'
                    reject(valid)
                } else {
                    try {
                        t = isLocalTransaction ? await ctx.iota.dc.orm.transaction() : t;
                        ctx.iota.session = ctx.iota.session || {};
                        ctx.iota.session.transaction = t;
                        let order = await models.Order.findOne({ where: { out_trade_no: out_trade_no } });
                        let account = await models.Account.findOne({ where: { id: order.accountId } });
                        if (order.paymentState === TRANSACTION_STATUS.PREPAID) {
                            ctx.status = 200;
                            ctx.body = 'success';
                            return;
                        }
                        if (trade_status == "TRADE_FINISHED" || trade_status == "TRADE_SUCCESS") {
                            ctx.iota.session = ctx.iota.session || {};
                            ctx.iota.session.out_trade_no = order.out_trade_no;
                            let accountSP = await account_service_package.create(ctx);
                            await models.Order.update(
                                {
                                    paymentState: TRANSACTION_STATUS.PREPAID,
                                    beginTime: accountSP.beginTime,
                                    endTime: accountSP.endTime,
                                    oldBalance: account.balance,
                                    newBalance: account.balance,
                                    time_end: time_end
                                },
                                { where: { out_trade_no: out_trade_no }, transaction: t }
                            );
                        } else {
                            await models.Order.update(
                                {
                                    paymentState: TRANSACTION_STATUS.FAILURE,
                                    oldBalance: account.balance,
                                    newBalance: account.balance,
                                    time_end: time_end
                                },
                                { where: { out_trade_no: out_trade_no }, transaction: t }
                            );
                        }
                        if (isLocalTransaction) {
                            await t.commit()
                        }
                        ctx.status = 200;
                        ctx.body = 'success';
                    }
                    catch (err) {
                        if (isLocalTransaction && t) {
                            await t.rollback();
                        }
                        ctx.status = 200;
                        ctx.body = 'fail'
                    }
                    resolve(valid);
                }
            });
        })
    };

    onWXNotifyForOrder = async (ctx, next) => {
        let fn = async function (ctx, next) {
            let data = ctx.request.body;
            let models = ctx.iota.dc.models;
            let t = ctx.iota.session ? ctx.iota.session.transaction : undefined;
            let isLocalTransaction = !t;
            let updateInfo = {
                paymentState: TRANSACTION_STATUS.UNPAID,
                transaction_id: data.transaction_id,
                bank_type: data.bank_type,
                openid: data.openid,
                time_end: moment(data.time_end, 'YYYYMMDDHHmmss').toDate()
            };
            try {
                t = isLocalTransaction ? await ctx.iota.dc.orm.transaction() : t;
                ctx.iota.session = ctx.iota.session || {};
                ctx.iota.session.transaction = t;
                let order = await models.Order.findOne({ where: { out_trade_no: data.out_trade_no } });
                let account = await models.Account.findOne({ where: { id: order.accountId } });
                if (order.paymentState === TRANSACTION_STATUS.PREPAID) {
                    ctx.success();
                    return;
                }
                if (data.return_code == "SUCCESS") {
                    ctx.iota.session = ctx.iota.session || {};
                    ctx.iota.session.out_trade_no = order.out_trade_no;
                    let accountSP = await account_service_package.create(ctx);
                    updateInfo.paymentState = TRANSACTION_STATUS.PREPAID;
                    updateInfo.beginTime = accountSP.beginTime;
                    updateInfo.endTime = accountSP.endTime;
                    updateInfo.oldBalance = account.balance;
                    updateInfo.newBalance = account.balance;
                    await models.Order.update(
                        updateInfo,
                        { where: { out_trade_no: data.out_trade_no }, transaction: t }
                    );
                    ctx.success();
                } else {
                    updateInfo.paymentSate = TRANSACTION_STATUS.FAILURE;
                    updateInfo.oldBalance = account.balance;
                    updateInfo.newBalance = account.balance;
                    await models.Order.update(
                        updateInfo,
                        { where: { out_trade_no: data.out_trade_no }, transaction: t }
                    );
                    ctx.fail()
                }
                if (isLocalTransaction) {
                    await t.commit();
                }
            } catch (e) {
                if (isLocalTransaction && t) {
                    await t.rollback();
                }
                ctx.status = 500;
                ctx.body = {
                    name: 'create error',
                    message: 'An unexpected condition was encountered in the server and no more specific message is suitable.'
                }
            }
        };
        await this.wxpay.useWXCallback(fn)(ctx, next);
    }

    async onBalancePayCallback(ctx, next) {
        let data = ctx.request.body;
        let models = ctx.iota.dc.models;
        if (data && data.out_trade_no) {
            let t = ctx.iota.session ? ctx.iota.session.transaction : undefined;
            let isLocalTransaction = !t;
            try {
                t = isLocalTransaction ? await ctx.iota.dc.orm.transaction() : t;
                ctx.iota.session = ctx.iota.session || {};
                ctx.iota.session.transaction = t;
                let order = await models.Order.findOne({ where: { out_trade_no: data.out_trade_no } });
                let account = await models.Account.findOne({ where: { id: order.accountId } });
                ctx.iota.session = ctx.iota.session || {};
                ctx.iota.session.paramsObj = {
                    operate_type: 'reduce',
                    out_trade_no: order.out_trade_no,
                    balance: account.balance,
                    order_fee: order.fee,
                    account_id: order.accountId
                }
                await changeBalance(ctx);
                ctx.iota.session.out_trade_no = order.out_trade_no;
                let accountSP = await account_service_package.create(ctx);
                await models.Order.update(
                    {
                        beginTime: accountSP.beginTime,
                        endTime: accountSP.endTime,
                        paymentState: TRANSACTION_STATUS.PREPAID,
                        oldBalance: account.balance,
                        newBalance: account.balance - accountSP.price,
                        time_end: new Date()
                    },
                    { where: { out_trade_no: order.out_trade_no }, transaction: ctx.iota.session.transaction });
                if (isLocalTransaction) {
                    await t.commit();
                }
                ctx.status = 200;
                ctx.body = { result: 'SUCCESS' };
            } catch (e) {
                if (isLocalTransaction && t) {
                    await t.rollback();
                }
                ctx.status = 500;
                ctx.body = {
                    name: 'create error',
                    message: 'An unexpected condition was encountered in the server and no more specific message is suitable.'
                }
                ctx.iota.logger.error(`path: ${ctx.path}, error: ${e}, ${e.stack}`);
            }
        } else {
            ctx.status = 400;
            ctx.body = {
                name: 'create error',
                message: 'params err'
            }
        }
    }

    /*支付宝必要function*/
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
        let sPara = [];//转换为数组利于排序 除去空值和签名参数
        if (!params) return null;
        for (let key in params) {
            if ((!params[key]) || key == "sign" || key == "sign_type") {
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
}