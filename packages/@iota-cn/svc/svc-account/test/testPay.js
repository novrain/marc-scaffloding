import client from 'supertest';
import parser from 'xml2js';
import chai, { assert, expect } from 'chai';

import scaffold from '@iota-cn/svc-scaffolding';
import config from './config';
import moment from 'moment';

describe('All order test', function () {
    this.timeout(10000);
    config.port = 4322;
    let app = scaffold(config);
    let request = client.agent(app.server);
    let models = app.iota.dc.models;
    let User, User2, User3, User4;
    let Account, Account2, Account3, Account4;
    let ServicePackageA, ServicePackageB, ServicePackageC, ServicePackageD;
    let order, recharge;
    let Order2, Order3, Order4, Recharge1;
    let ServiceType = models.ServicePackage.ServiceType;
    before(async function () {
        await models.User.sync({ force: true });
        User = await models.User.create({ username: 'kadven', password: '123456' });
        User2 = await models.User.create({ username: 'kadven2', password: '123456' });
        User3 = await models.User.create({ username: 'kadven3', password: '123456' });
        User4 = await models.User.create({ username: 'kadven4', password: '123456' });
        await models.Account.sync({ force: true });
        Account = await models.Account.create({ accountName: User.username, balance: 600000, userId: User.id });
        Account2 = await models.Account.create({ accountName: User2.username, balance: 200000, userId: User2.id });
        Account3 = await models.Account.create({ accountName: User3.username, balance: 600000, userId: User3.id });
        Account4 = await models.Account.create({ accountName: User4.username, balance: 600000, userId: User4.id });
        await models.ServicePackage.sync({ force: true });
        let specificationA = {
            resources: {//资源配额类
                thing: {
                    viewType: 1,//
                    available: true,
                    name: "创建Thing",
                    desc: "",
                    quota: 1,
                    unit: "个",
                    extend: ''//单位后面的文字描述
                },
                device: {
                    viewType: 1,
                    available: true,
                    name: "创建设备",
                    desc: "您可以创建多少个设备",
                    quota: 1,
                    unit: "个",
                    extend: ''
                },
                protocol: {
                    viewType: 1,
                    available: true,
                    name: "创建设备",
                    desc: "您可以创建多少条协议",
                    quota: 1,
                    unit: "条",
                    extend: ''
                },
                interface: {
                    viewType: 1,
                    available: true,
                    name: "创建接口",
                    desc: "您可以创建多少个接口",
                    quota: 1,
                    unit: "个",
                    extend: ''
                },
                rule: {
                    viewType: 1,
                    available: true,
                    name: "创建规则",
                    desc: "您可以创建多少个规则",
                    quota: 1,
                    unit: "个",
                    extend: ''
                }
            },
            server: {//服务类
                s1: {
                    viewType: 1,
                    available: true,
                    name: "工单响应",
                    desc: "",
                    quota: 24,
                    unit: "小时",
                    extend: '内',
                },
                s2: {
                    viewType: 2,
                    available: false,
                    name: "一对一技术支持",
                    desc: "",
                },
                s3: {
                    viewType: 2,
                    available: false,
                    name: "一对一客户服务"
                },
                s4: {
                    viewType: 2,
                    available: false,
                    name: "支付系统技术指导"
                }
            }
        };
        let specificationB = {
            resources: {//资源配额类
                thing: {
                    viewType: 1,//数值类
                    available: true,
                    name: "创建Thing",
                    desc: "",
                    quota: 5,
                    unit: "个",
                    extend: ''//单位后面的文字描述
                },
                device: {
                    viewType: 1,
                    available: true,
                    name: "创建设备",
                    desc: "您可以创建多少个设备",
                    quota: 10,
                    unit: "个",
                    extend: ''
                },
                protocol: {
                    viewType: 1,
                    available: true,
                    name: "创建设备",
                    desc: "您可以创建多少条协议",
                    quota: 10,
                    unit: "条",
                    extend: ''
                },
                interface: {
                    viewType: 1,
                    available: true,
                    name: "创建接口",
                    desc: "您可以创建多少个接口",
                    quota: 10,
                    unit: "个",
                    extend: ''
                },
                rule: {
                    viewType: 1,
                    available: true,
                    name: "创建规则",
                    desc: "您可以创建多少个规则",
                    quota: 10,
                    unit: "个",
                    extend: ''
                }
            },
            server: {//服务类
                s1: {
                    viewType: 1,
                    available: true,
                    name: "工单响应",
                    desc: "",
                    quota: 24,
                    unit: "小时",
                    extend: '内',
                },
                s2: {
                    viewType: 2,
                    available: false,
                    name: "一对一技术支持",
                    desc: "",
                },
                s3: {
                    viewType: 2,
                    available: false,
                    name: "一对一客户服务"
                },
                s4: {
                    viewType: 2,
                    available: false,
                    name: "支付系统技术指导"
                }

            }
        };
        let specificationC = {
            resources: {//资源配额类
                thing: {
                    viewType: 1,//数值类
                    available: true,
                    name: "创建Thing",
                    desc: "",
                    quota: 10,
                    unit: "个",
                    extend: ''//单位后面的文字描述
                },
                device: {
                    viewType: 1,
                    available: true,
                    name: "创建设备",
                    desc: "您可以创建多少个设备",
                    quota: 20,
                    unit: "个",
                    extend: ''
                },
                protocol: {
                    viewType: 1,
                    available: true,
                    name: "创建设备",
                    desc: "您可以创建多少条协议",
                    quota: 40,
                    unit: "条",
                    extend: ''
                },
                interface: {
                    viewType: 1,
                    available: true,
                    name: "创建接口",
                    desc: "您可以创建多少个接口",
                    quota: 40,
                    unit: "个",
                    extend: ''
                },
                rule: {
                    viewType: 1,
                    available: true,
                    name: "创建规则",
                    desc: "您可以创建多少个规则",
                    quota: 40,
                    unit: "个",
                    extend: ''
                }
            },
            server: {//服务类,
                s1: {
                    viewType: 1,
                    available: true,
                    name: "工单响应",
                    desc: "",
                    quota: 60,
                    unit: "分钟",
                    extend: '内',
                },
                s2: {
                    viewType: 2,
                    available: true,
                    name: "5×10技术支持",
                    desc: "",
                },
                s3: {
                    viewType: 2,
                    available: true,
                    name: "5×10客户服务"
                },
                s4: {
                    viewType: 2,
                    available: true,
                    name: "支付系统技术指导"
                }

            }
        };
        let specificationD = {
            resources: {//资源配额类
                thing: {
                    viewType: 1,//数值类
                    available: true,
                    name: "创建Thing",
                    desc: "",
                    quota: 20,
                    unit: "个",
                    extend: ''//单位后面的文字描述
                },
                device: {
                    viewType: 1,
                    available: true,
                    name: "创建设备",
                    desc: "您可以创建多少个设备",
                    quota: 40,
                    unit: "个",
                    extend: ''
                },
                protocol: {
                    viewType: 1,
                    available: true,
                    name: "创建设备",
                    desc: "您可以创建多少条协议",
                    quota: 80,
                    unit: "条",
                    extend: ''
                },
                interface: {
                    viewType: 1,
                    available: true,
                    name: "创建接口",
                    desc: "您可以创建多少个接口",
                    quota: 80,
                    unit: "个",
                    extend: ''
                },
                rule: {
                    viewType: 1,
                    available: true,
                    name: "创建规则",
                    desc: "您可以创建多少个规则",
                    quota: 80,
                    unit: "个",
                    extend: ''
                }
            },
            server: {//服务类
                s1: {
                    viewType: 1,
                    available: true,
                    name: "工单响应",
                    desc: "",
                    quota: 15,
                    unit: "分钟",
                    extend: '内',
                },
                s2: {
                    viewType: 2,
                    available: true,
                    name: "7×10技术支持",
                    desc: "",
                },
                s3: {
                    viewType: 2,
                    available: true,
                    name: "7×10客户服务"
                },
                s4: {
                    viewType: 2,
                    available: true,
                    name: "支付系统技术指导"
                }

            }
        };
        ServicePackageA = await models.ServicePackage.create({
            name: '免费版',
            serviceType: ServiceType.Free,
            desc: '描述你能干什么',
            price: 0,
            specification: JSON.stringify(specificationA)
        });
        ServicePackageB = await models.ServicePackage.create({
            name: '基础版',
            serviceType: ServiceType.Basic,
            desc: '描述服务包B能干什么',
            specification: JSON.stringify(specificationB),
            price: 1
        });
        ServicePackageC = await models.ServicePackage.create({
            name: '专业版',
            serviceType: ServiceType.Professional,
            desc: '描述服务包C能干什么',
            specification: JSON.stringify(specificationC),
            price: 1
        });
        ServicePackageD = await models.ServicePackage.create({
            name: '企业版',
            serviceType: ServiceType.Customized,
            desc: '描述服务包D能干什么',
            specification: JSON.stringify(specificationD),
            price: 1
        });
        await models.AccountServicePackage.sync({ force: true });
        let oldSpecification = Object.assign({}, specificationB);
        oldSpecification.resources.interface.quota = 0;
        oldSpecification.resources.device.quota = 0;
        oldSpecification.resources.protocol.quota = 0;
        oldSpecification.resources.thing.quota = 0;
        let accsp = await models.AccountServicePackage.create({
            name: ServicePackageB.name,
            price: ServicePackageB.price,
            beginTime: new Date('2016-1-1'),
            endTime: new Date('2016-1-10'),
            specification: JSON.stringify(oldSpecification),
            initialSpecification: ServicePackageB.specification,
            accountId: Account4.id,
            servicePackageId: ServicePackageB.id
        });
        let date = new Date();
        let year = date.getFullYear();
        let initMonth = date.getMonth() + 1;
        let initDay = date.getDate();
        let day = initDay > 10 ? initDay + '' : '0' + initDay;
        let month = initMonth > 10 ? initMonth + '' : '0' + initMonth;
        let out_trade_no = year + month + day + Math.random().toString().substr(2, 10);
        await models.Order.sync({ force: true });
        await models.Recharge.sync({ force: true });
        order = await models.Order.create({
            product_id: '1',
            service_name: ServicePackageA.name,
            fee: ServicePackageA.price,
            bank_type: '工商银行',
            time_start: new Date(),
            out_trade_no: out_trade_no + '10',
            servicePackageId: ServicePackageA.id,
            accountId: Account.id
        });
        Order2 = await models.Order.create({
            product_id: '2',
            service_name: ServicePackageB.name,
            fee: ServicePackageB.price,
            bank_type: '农业银行',
            time_start: new Date(),
            accountId: Account.id,
            out_trade_no: out_trade_no + '11',
            servicePackageId: ServicePackageB.id
        });
        Order3 = await models.Order.create({
            product_id: '3',
            fee: ServicePackageA.price,
            bank_type: '交通银行',
            time_start: new Date(),
            out_trade_no: out_trade_no + '12',
            servicePackageId: ServicePackageA.id,
            accountId: Account.id
        });
        Order4 = await models.Order.create({
            product_id: '4',
            service_name: ServicePackageD.name,
            fee: ServicePackageD.price,
            bank_type: '建设银行',
            time_start: new Date(),
            out_trade_no: out_trade_no + '13',
            servicePackageId: ServicePackageD.id,
            accountId: Account.id
        });
        recharge = await models.Recharge.create({
            product_id: '1',
            fee: 5000,
            bank_type: '中国银行',
            time_start: new Date(),
            accountId: Account.id,
            out_trade_no: out_trade_no + '10'
        });
        Recharge1 = await models.Recharge.create({
            product_id: '1100',
            fee: 19990000,
            bank_type: '建设银行',
            time_start: new Date(),
            accountId: Account.id,
            out_trade_no: out_trade_no + '11'
        });
        await models.Recharge.create({
            product_id: '3',
            fee: 7000,
            bank_type: '农业银行',
            time_start: new Date(),
            accountId: Account.id,
            out_trade_no: out_trade_no + '12'
        });
        await models.Recharge.create({
            product_id: '4',
            fee: 8000,
            bank_type: '工商银行',
            time_start: new Date(),
            accountId: Account.id,
            out_trade_no: out_trade_no + '13',
            paymentState: 'prepaid'
        });
    });
    after(function () {
        app.server.close()
    });

    it('basic', function (done) {
        request
            .get('/notfound')
            .expect(404, done);
    });
    it('signin success', function (done) {
        request
            .post('/signin')
            .send({
                username: 'kadven',
                password: '123456'
            })
            .expect(200, done)
    });

    it('get single recharge', function (done) {
        request
            .get(`/accounts/recharges/${recharge.id}`)
            .expect(200, (err, res) => {
                if (err) {
                    done(err)
                } else {
                    assert.equal(res.body.fee, 50);
                    done();
                }
            })
    });
    it('get recharges by limit(1) and offset(0)', function (done) {
        request
            .get('/accounts/recharges?limit=1')
            .expect(200, (err, res) => {
                if (err) {
                    done(err)
                } else {
                    let recharges = res.body.recharges;
                    let total = res.body.total;
                    assert.equal(total, 4);
                    assert.equal(recharges.length, 1);
                    assert.equal(recharges[0].fee, 80);
                    done();
                }
            })
    });
    it('get all recharges support panging', function (done) {
        request
            .get('/accounts/recharges?limit=3&offset=0')
            .expect(200, (err, res) => {
                if (err) {
                    done(err)
                } else {
                    let recharges = res.body.recharges;
                    let total = res.body.total;
                    assert.equal(total, 4);
                    assert.equal(recharges.length, 3);
                    assert.equal(recharges[0].fee, 80);
                    done();
                }
            })
    });
    it('get all recharges support panging and filter is prepaid', function (done) {
        request
            .get('/accounts/recharges?limit=3&offset=0&state=prepaid')
            .expect(200, (err, res) => {
                if (err) {
                    done(err)
                } else {
                    let recharges = res.body.recharges;
                    let total = res.body.total;
                    assert.equal(total, 1);
                    assert.equal(recharges.length, 1);
                    done();
                }
            })
    });
    it('get all recharges support panging and filter is unpaid', function (done) {
        request
            .get('/accounts/recharges?limit=3&offset=0&state=unpaid')
            .expect(200, (err, res) => {
                if (err) {
                    done(err)
                } else {
                    let recharges = res.body.recharges;
                    let total = res.body.total;
                    assert.equal(recharges.length, 3);
                    assert.equal(total, 3);
                    done();
                }
            })
    });
    it('post recharge', function (done) {
        request
            .post('/accounts/recharges')
            .send({
                type: 'wechat',
                fee: 100,
                bank_type: 'CHINA',
                product_id: '12331432'
            })
            .expect(200, (err, res) => {
                if (err) {
                    done(err)
                } else {
                    assert.equal(res.body['recharge'].fee, 100);
                    assert.equal(res.body['result'].return_code, 'SUCCESS');
                    done()
                }
            })
    });

    it('test wechat recharge callback', function () {
        let xml = `<xml>
            <appid><![CDATA[wx2421b1c4370ec43b]]></appid>
            <attach><![CDATA[wechat]]></attach>
            <bank_type><![CDATA[ICBC]]></bank_type>
            <fee_type><![CDATA[RMB]]></fee_type>
            <is_subscribe><![CDATA[Y]]></is_subscribe>
            <mch_id><![CDATA[10000100]]></mch_id>
            <nonce_str><![CDATA[5d2b6c2a8db53831f7eda20af46e531c]]></nonce_str>
            <openid><![CDATA[oUpF8uMEb4qRXf22hE3X68TekukE]]></openid>
            <out_trade_no><![CDATA[${recharge.out_trade_no}]]></out_trade_no>
            <result_code><![CDATA[SUCCESS]]></result_code>
            <return_code><![CDATA[SUCCESS]]></return_code>
            <sign><![CDATA[B552ED6B279343CB493C5DD0D78AB241]]></sign>
            <sub_mch_id><![CDATA[10000100]]></sub_mch_id>
            <time_end><![CDATA[${moment(new Date()).format('YYYYMMDDHHmmss')}]]></time_end>
            <total_fee>${recharge.fee}</total_fee>
            <trade_type><![CDATA[recharge]]></trade_type>
            <transaction_id><![CDATA[1000010000]]></transaction_id>
        </xml>`;
        return request
            .post('/accounts/recharges/wechat_result_notify')
            .set('Content-Type', 'application/xml')
            .send(xml)
            .expect(200)
            .then((res) => {
                return new Promise((resolve, reject) => {
                    return parser.parseString(res.text, async function (err, result) {
                        if (err)
                            reject(err);
                        else {
                            assert.equal(result.xml.return_code, 'SUCCESS');
                            let acc = await models.Account.findOne({ where: { id: Account.id } });
                            assert.equal(acc.balance, 605000);
                            resolve()
                        }
                    });
                });
            })
    })
    it('get single order', function (done) {
        request
            .get(`/accounts/orders/${order.id}`)
            .expect(200, (err, res) => {
                if (err) {
                    done(err)
                } else {
                    assert.equal(res.body.fee, 0);
                    assert.equal(res.body.service_name, '免费版');
                    assert.equal(res.body.service.name, '免费版')
                    done();
                }
            })
    });
    it('get orders by default limit(1) and offset(0)', function (done) {
        request
            .get('/accounts/orders?limit=1')
            .expect(200, (err, res) => {
                if (err) {
                    done(err)
                } else {
                    let orders = res.body.orders;
                    let total = res.body.total;
                    assert.equal(total, 4);
                    assert.equal(orders.length, 1);
                    done();
                }
            })
    });
    it('get all orders support paging', function (done) {
        request
            .get('/accounts/orders?limit=3&offset=0')
            .expect(200, (err, res) => {
                if (err) {
                    done(err)
                } else {
                    let orders = res.body.orders;
                    let total = res.body.total;
                    assert.equal(total, 4);
                    assert.equal(orders.length, 3);
                    done();
                }
            })
    });
    it('get all orders support paging and filter is prepaid', function (done) {
        request
            .get('/accounts/orders?limit=3&offset=0&state=prepaid')
            .expect(200, (err, res) => {
                if (err) {
                    done(err)
                } else {
                    let orders = res.body.orders;
                    let total = res.body.total;
                    assert.equal(total, 0);
                    assert.equal(orders.length, 0);
                    done();
                }
            })
    });
    it('get all orders support paging and filter is unpaid', function (done) {
        request
            .get('/accounts/orders?limit=3&offset=0&state=unpaid')
            .expect(200, (err, res) => {
                if (err) {
                    done(err)
                } else {
                    let orders = res.body.orders;
                    let total = res.body.total;
                    assert.equal(total, 4);
                    assert.equal(orders.length, 3);
                    done();
                }
            })
    });
    let wechatOrder;
    it('use wechat to buy service', function (done) {
        request
            .post('/accounts/orders')
            .send({
                type: 'wechat',
                servicePackageId: ServicePackageB.id,
                bank_type: 'CHINA',
                product_id: '12331432'
            })
            .expect(200, (err, res) => {
                if (err) {
                    done(err)
                } else {
                    assert.equal(res.body['order'].fee, 0.01);
                    assert.equal(res.body['order'].oldBalance, 6050);
                    assert.equal(res.body['order'].newBalance, 6050);
                    assert.equal(res.body['result'].return_code, 'SUCCESS');
                    wechatOrder = res.body.order;
                    done()
                }
            })
    });
    it('use wechat to pay order callback', function () {
        let xml = `<xml>
            <appid><![CDATA[wx2421b1c4370ec43b]]></appid>
            <attach><![CDATA[wechat]]></attach>
            <bank_type><![CDATA[ICBC]]></bank_type>
            <fee_type><![CDATA[RMB]]></fee_type>
            <is_subscribe><![CDATA[Y]]></is_subscribe>
            <mch_id><![CDATA[10000100]]></mch_id>
            <nonce_str><![CDATA[5d2b6c2a8db53831f7eda20af46e531c]]></nonce_str>
            <openid><![CDATA[oUpF8uMEb4qRXf22hE3X68TekukE]]></openid>
            <out_trade_no><![CDATA[${wechatOrder.out_trade_no}]]></out_trade_no>
            <result_code><![CDATA[SUCCESS]]></result_code>
            <return_code><![CDATA[SUCCESS]]></return_code>
            <sign><![CDATA[B552ED6B279343CB493C5DD0D78AB241]]></sign>
            <sub_mch_id><![CDATA[10000100]]></sub_mch_id>
            <time_end><![CDATA[${moment(new Date()).format('YYYYMMDDHHmmss')}]]></time_end>
            <total_fee>${wechatOrder.fee}</total_fee>
            <trade_type><![CDATA[order]]></trade_type>
            <transaction_id><![CDATA[200000010203]]></transaction_id>
        </xml>`;
        return request
            .post('/accounts/orders/wechat_result_notify')
            .set('Content-Type', 'application/xml')
            .send(xml)
            .expect(200)
            .then((res) => {
                return new Promise((resolve, reject) => {
                    parser.parseString(res.text, async function (err, result) {
                        if (err)
                            reject(err);
                        else {
                            assert.equal(result.xml.return_code, 'SUCCESS');
                            let acc = await models.Account.findOne({ where: { id: wechatOrder.accountId } });
                            assert.equal(acc.balance, 605000);
                            let ord = await models.Order.findOne({ where: { out_trade_no: wechatOrder.out_trade_no } });
                            assert.equal(ord.paymentState, 'prepaid');
                            assert.equal(ord.oldBalance, 605000);
                            assert.equal(ord.newBalance, 605000);
                            let acc_s = await models.AccountServicePackage.findAll({
                                where: { accountId: wechatOrder.accountId }
                            });
                            assert.equal(1, acc_s.length);
                            resolve()
                        }
                    });
                });
            })
    })
    //服务重复被重复购买
    it('Not allowed to repeat purchase', function (done) {
        request
            .post('/accounts/orders')
            .send({
                type: 'wechat',
                servicePackageId: ServicePackageC.id,
                bank_type: 'CHINA',
                product_id: '12331432'
            })
            .expect(409, done)
    });
    it('signout', function (done) {
        request
            .post('/signout')
            .expect(204, done)
    })
    it('signin another user', function (done) {
        request
            .post('/signin')
            .send({
                username: 'kadven2',
                password: '123456'
            })
            .expect(200, done)
    });
    let balanceOrder;
    it('user2 use balance to buy service', function (done) {
        request
            .post('/accounts/orders')
            .send({
                type: 'balance',
                servicePackageId: ServicePackageB.id
            })
            .expect(200, (err, res) => {
                if (err) {
                    done(err)
                } else {
                    balanceOrder = res.body;
                    assert.equal(balanceOrder.fee, 0.01);
                    assert.equal(balanceOrder.oldBalance, 2000);
                    assert.equal(balanceOrder.newBalance, 2000);
                    done()
                }
            })
    });
    it('user2 pay for order with balance', function () {
        return request
            .put('/accounts/orders/balance_pay_callback')
            .send({
                type: 'balance',
                out_trade_no: balanceOrder.out_trade_no
            })
            .expect(200)
            .then(async (res) => {
                assert.equal(res.body.result, 'SUCCESS');
                let acc = await models.Account.findOne({ where: { id: balanceOrder.accountId } });
                assert.equal(acc.balance, 199999);
                let ord = await models.Order.findOne({ where: { out_trade_no: balanceOrder.out_trade_no } });
                assert.equal(ord.paymentState, 'prepaid');
                assert.equal(ord.oldBalance, 200000);
                assert.equal(ord.newBalance, 199999);
                let acc_s = await models.AccountServicePackage.findAll({
                    where: { accountId: balanceOrder.accountId }
                });
                assert.equal(1, acc_s.length);
            });
    });
    it('signout', function (done) {
        request
            .post('/signout')
            .expect(204, done)
    })
    it('signin another user', function (done) {
        request
            .post('/signin')
            .send({
                username: 'kadven3',
                password: '123456'
            })
            .expect(200, done)
    });
    let alipayOrder;
    it('test aliPay to buy service', function (done) {
        request
            .post('/accounts/orders')
            .send({
                type: "alipay",
                alibody: ServicePackageD.desc,
                servicePackageId: ServicePackageD.id,
                subject: ServicePackageD.name
            })
            .expect(200, (err, res) => {
                if (err) {
                    done(err)
                } else {
                    alipayOrder = res.body.order;
                    assert.equal(alipayOrder.fee, 0.01);
                    assert.equal(alipayOrder.oldBalance, 6000);
                    assert.equal(alipayOrder.newBalance, 6000);
                    done()
                }
            })
    });
    it('test alipay order callback', function () {
        return request
            .post(`/accounts/orders/alipay_result_notify?out_trade_no_test=${alipayOrder.out_trade_no}`)
            .set('Accept', 'text/plain')
            .send({
                discount: '0.00',
                payment_type: '1',
                subject: '服务包D',
                trade_no: '2017030921001004940265926667',
                buyer_email: '13912976880',
                gmt_create: '2017-03-09 11:45:36',
                notify_type: 'trade_status_sync',
                quantity: '1',
                out_trade_no: '201703095072594489',
                seller_id: '2088421286728062',
                notify_time: '2017-03-09 11:45:45',
                body: '描述服务包D能干什么',
                trade_status: 'TRADE_SUCCESS',
                is_total_fee_adjust: 'N',
                total_fee: '0.01',
                gmt_payment: '2017-03-09 11:45:45',
                seller_email: 'liu.jiangang@theiota.cn',
                price: '0.01',
                buyer_id: '2088012116332948',
                notify_id: '21a9067e0781ffb8c23da0b0c84cc6en96',
                use_coupon: 'N',
                sign_type: 'MD5',
                sign: '8b30ab2a928bbc867b9bf27346a19d7c'
            })
            .expect(200)
            .then(async (res) => {
                assert.equal(res.text, 'success');
                let acc = await models.Account.findOne({ where: { id: alipayOrder.accountId } });
                assert.equal(acc.balance, 600000);
                let ord = await models.Order.findOne({ where: { out_trade_no: alipayOrder.out_trade_no } });
                assert.equal(ord.paymentState, 'prepaid');
                assert.equal(ord.oldBalance, 600000);
                assert.equal(ord.newBalance, 600000);
                let acc_s = await models.AccountServicePackage.findOne({ where: { name: alipayOrder.service_name } });
                assert.equal('企业版', acc_s.name);
            });
    });
    let alipayRecharge
    it('test recharge by alipay', function (done) {
        request
            .post('/accounts/recharges')
            .send({
                type: "alipay",
                fee: 1
            })
            .expect(200, (err, res) => {
                if (err) {
                    done(err)
                } else {
                    assert.equal(res.body.url.length > 0, true);
                    alipayRecharge = res.body.recharge;
                    done()
                }
            })
    });
    it('test recharge by alipay callBack', function () {
        return request
            .post(`/accounts/recharges/alipay_result_notify?out_trade_no_test=${alipayRecharge.out_trade_no}`)
            .set('Accept', 'text/plain')
            .send({
                discount: '0.00',
                payment_type: '1',
                subject: 'test',
                trade_no: '2017030921001004940265953883',
                buyer_email: '13912976880',
                gmt_create: '2017-03-09 12:01:28',
                notify_type: 'trade_status_sync',
                quantity: '1',
                out_trade_no: '201703096539290380',
                seller_id: '2088421286728062',
                notify_time: '2017-03-09 12:01:37',
                body: '123321321',
                trade_status: 'TRADE_SUCCESS',
                is_total_fee_adjust: 'N',
                total_fee: '0.01',
                gmt_payment: '2017-03-09 12:01:36',
                seller_email: 'liu.jiangang@theiota.cn',
                price: '0.01',
                buyer_id: '2088012116332948',
                notify_id: '7046fd38ae6613cdc48060d744b8ac1n96',
                use_coupon: 'N',
                sign_type: 'MD5',
                sign: '491dfbb0edd0a5b2e72b03f6a3fdcad5'
            })
            .expect(200)
            .then(async (res) => {
                assert.equal(res.text, 'success');
                let acc = await models.Account.findOne({ where: { id: alipayRecharge.accountId } });
                assert.equal(acc.balance, 600100);
                let rec = await models.Recharge.findOne({ where: { out_trade_no: alipayRecharge.out_trade_no } });
                assert.equal(rec.paymentState, 'prepaid');
            });
    });
    it('signout', function (done) {
        request
            .post('/signout')
            .expect(204, done)
    })
    it('signin another user', function (done) {
        request
            .post('/signin')
            .send({
                username: 'kadven4',
                password: '123456'
            })
            .expect(200, done)
    });
    //测试服务过期，购买新服务
    let balanceOrder2;
    it('user4 use balance to buy service', function (done) {
        request
            .post('/accounts/orders')
            .send({
                type: 'balance',
                servicePackageId: ServicePackageC.id
            })
            .expect(200, async (err, res) => {
                if (err) {
                    done(err)
                } else {
                    balanceOrder2 = res.body;
                    assert.equal(balanceOrder2.fee, 0.01);
                    assert.equal(balanceOrder2.oldBalance, 6000);
                    assert.equal(balanceOrder2.newBalance, 6000);
                    done();
                }
            })
    });
    it('user4 buy new service', function () {
        return request
            .put('/accounts/orders/balance_pay_callback')
            .send({
                type: 'balance',
                out_trade_no: balanceOrder2.out_trade_no
            })
            .expect(200)
            .then(async (res) => {
                assert.equal(res.body.result, 'SUCCESS');
                let acc_s = await models.AccountServicePackage.findOne({
                    where: { accountId: balanceOrder2.accountId }
                });
                //旧服务包B已使用配额：thing:5,device:10,interface:10,protocol:10
                //新包C应该减去旧包的配额
                let specification = JSON.parse(acc_s.specification);
                assert.equal(specification.resources.thing.quota, 5);//10-5
                assert.equal(specification.resources.device.quota, 10);//20-10
                assert.equal(specification.resources.protocol.quota, 30);//40-10
                assert.equal(specification.resources.interface.quota, 30);//40-10
                assert.equal(specification.resources.rule.quota, 40);//40-0
            });
    });
});

