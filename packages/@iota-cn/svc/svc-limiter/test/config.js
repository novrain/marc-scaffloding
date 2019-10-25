/**
 * Created by rain on 2016/6/21.
 */
import path from 'path';
import os from 'os';
import { entry as restfulEntry } from '@iota-cn/svc-restful'
import { entry as userEntry, models as userModels } from '@iota-cn/svc-user';
import { entry as authenticationEntry, models as authenticationModels } from '@iota-cn/svc-authentication';
import { entry as authorizationEntry, models as authorizationModels } from '@iota-cn/svc-authorization';
import { entry as accountEntry, models as accountModels } from '@iota-cn/svc-account';
import { entry as limitEntry } from '../src';
export default {
    port: 4000,
    //global:{
    //    domain:'http://localhost:9080',
    //    prefix:'/v1/api'
    //},
    mws: [
        {
            entry: limitEntry,
            opts: {
                max: {
                    default: {
                        times: 10,
                        frequency: 5
                    },
                    expired: {
                        times: 30,
                        frequency: 10
                    }
                },
                duration: {
                    times: 30 * 1000,
                    frequency: 1 * 1000
                }
            }
        },
        {
            entry: userEntry,
            opts: {}
        },
        {
            entry: restfulEntry, opts: {}
        },
        {
            entry: authenticationEntry, opts: {
                exclude: [
                    { p: '/signin/wechat', o: 'GET' },
                    { p: '/signin/wechat/binding', o: 'POST' },
                    { p: '/signin/wechat/signup', o: 'POST' },
                    { p: '/oauth2/token', o: 'POST' },
                    { p: '/services/packages/:id?', o: 'GET' }
                ],
                remMaxAge: 30,
                inputName: 'iotaupload',
                rootPath: 'web',
                childPath: 'upload/avatar',//目前只支持两级目录
                maxSize: 1048576////in bytes ->1mb = 1024*1024=1048576
            }
        },
        { entry: authorizationEntry, opts: {} },
        {
            entry: accountEntry, opts: {
                wechatPay: {
                    appid: 'wxd3d1d2131f2b1b43',
                    mch_id: '1439034402',
                    partner_key: '0e8d254a6051e397f9c8932db3d1ac29', //微信商户平台API密钥
                    spbill_create_ip: '49.65.71.132', //@TODO 需要获取
                    recharge_notify_url: '/accounts/recharges/wechat_result_notify',
                    order_notify_url: '/accounts/orders/wechat_result_notify'
                },
                aliPay: {
                    partner: "2088421286728062",// 合作身份者ID，以2088开头由16位纯数字组成的字符串
                    key: "khs3p6km87gs6jl4tozp5086yf0j3sgr",// 交易安全检验码，由数字和字母组成的32位字符串
                    seller_email: "liu.jiangang@theiota.cn",// 签约支付宝账号或卖家收款支付宝帐户
                    recharge_notify_url: '/accounts/recharges/alipay_result_notify',
                    order_notify_url: '/accounts/orders/alipay_result_notify',
                    return_recharge_redirect: "/console/account/recharge_list", // 当前页面跳转之后的页面
                    return_order_redirect: "/console/account/cost",
                    ALIPAY_HOST: "mapi.alipay.com",
                    HTTPS_VERIFY_PATH: "/gateway.do?service=notify_verify&",
                    ALIPAY_PATH: "gateway.do?",
                    log_path: "~/alipay_log_.txt",
                    input_charset: "UTF-8", // 字符编码格式 目前支持 gbk 或 utf-8
                    sign_type: "MD5" // 签名方式 不需修改
                }
            }
        }
    ],
    dc: {
        orm: {
            url: "postgres://postgres:ROOT@localhost:5433/iOTA_ut",
            opts: { logging: true }
        },
        cache: {
            host: '127.0.0.1',
            port: '6379'
        },
        models: [userModels, authenticationModels, authorizationModels, accountModels]
    },
    logger: {
        koa: true,
        level: 'debug',
        json: false,
        filename: path.join(__dirname, 'log', 'runtime.txt'),
        colorize: true,
        maxsize: 1024 * 1024 * 5,
        rotationFormat: false,
        zippedArchive: true,
        maxFiles: 10,
        prettyPrint: true,
        label: '',
        timestamp: true,
        eol: os.EOL,
        tailable: true,
        depth: null,
        showLevel: true,
        maxRetries: 1
    }
};