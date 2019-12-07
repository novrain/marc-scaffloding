import client from 'supertest';
import chai, { assert, expect } from 'chai';

import scaffold from '@iota-cn/svc-scaffolding';
import config from './config';

const should = chai.should();
describe('IOTA account test', function () {
    this.timeout(10000);
    config.port = 2140;
    const app = scaffold(config);
    const request = client.agent(app.server);
    const models = app.iota.dc.models;
    const dc = app.iota.dc;

    dc.cache.extra(`vcode=test`, '123456', 'PX', 99999);
    let cookie = 'iota_r=test';
    let User, User1;
    let Account, Account1;
    let ServicePackageA, ServicePackageB, ServicePackageC, ServicePackageD;
    let date1, date2;
    let ServiceType = models.ServicePackage.ServiceType;
    before(async function () {
        await models.User.sync({ force: true });
        //await models.SubUser.sync({force: true});
        User = await models.User.create({ username: 'kadven', password: '123456' });
        User1 = await models.User.create({ username: 'kadven1', password: '123456' });
        await models.Account.sync({ force: true });
        await models.ServicePackage.sync({ force: true });
        await models.AccountServicePackage.sync({ force: true });
        await models.Order.sync({ force: true });
        Account = await models.Account.create({ accountName: User.username, balance: 600000, userId: User.id });
        Account1 = await models.Account.create({ accountName: User1.username, balance: 600000, userId: User1.id });
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
        date1 = new Date('2118-02-02');
        date2 = new Date(date1);
        date2.setFullYear(date2.getFullYear() + 1);
        date2.setDate(date2.getDate() - 1);
        await models.AccountServicePackage.create({
            name: ServicePackageA.name,
            price: ServicePackageA.price,
            beginTime: date1,
            endTime: date2,
            specification: ServicePackageA.specification,
            initialSpecification: ServicePackageA.specification,
            accountId: Account.id,
            servicePackageId: ServicePackageA.id
        });
        //过期服务
        await models.AccountServicePackage.create({
            name: ServicePackageB.name,
            price: ServicePackageB.price,
            beginTime: new Date('2015-12-12'),
            endTime: new Date('2016-12-11'),
            specification: ServicePackageB.specification,
            initialSpecification: ServicePackageB.specification,
            accountId: Account1.id,
            servicePackageId: ServicePackageB.id
        });
    });
    it('basic', function (done) {
        request
            .get('/notfound')
            .expect(404, done);
    });
    it('signup success and create a account', function (done) {
        request
            .post('/signup')
            .set('cookie', cookie)
            .send({
                username: 'test',
                password: 123456,
                email: 'test@123.com',
                vcode: 123456
            })
            .end(function (err, res) {
                if (err) {
                    return done(err);
                }
                let account = res.body.account;
                assert.equal('test', account.accountName);
                assert.equal(0, account.balance);
                done();
            })
    });
    it('signup faild ,can not to create a account', function (done) {
        request
            .post('/signup')
            .set('cookie', cookie)
            .send({
                username: 'te',
                password: 1234,
                email: 'test@123.com',
                vcode: 123456
            })
            .expect(400, done)
    });
    it('add subuser success and create a account', function (done) {
        request
            .post('/signin')
            .send({
                username: 'kadven',
                password: '123456'
            })
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                } else {
                    request
                        .post(`/users/${User.id}/subusers`)
                        .send({
                            username: 'test_sub',
                            password: 123456,
                            email: 'test_sub@123.com',
                        })
                        .end(function (err, res) {
                            if (err) {
                                return done(err);
                            }
                            done();
                        })
                }
            })
    });

    it('test find account info', function (done) {
        request
            .post('/signin')
            .send({
                username: 'kadven',
                password: '123456'
            })
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                } else {
                    request
                        .get(`/accounts/finance`)
                        .expect(200, function (err, res) {
                            if (err) {
                                return done(err);
                            }
                            assert.equal('kadven', res.body.accountName);
                            assert.equal(6000, res.body.balance);
                            assert.equal(0, res.body.serviceInfo.price);
                            done();
                        })
                }
            })
    })
    it('test find account info has expired service', function (done) {
        request
            .post('/signin')
            .send({
                username: 'kadven1',
                password: '123456'
            })
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                } else {
                    request
                        .get(`/accounts/finance`)
                        .expect(200, function (err, res) {
                            if (err) {
                                return done(err);
                            }
                            assert.equal(true, res.body.serviceInfo.expired);
                            done();
                        })
                }
            })
    })
})