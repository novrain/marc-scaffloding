/**
 * Created by kadven on 2017/2/16.
 */
import client from 'supertest';
import chai, { assert, expect } from 'chai';

import scaffold from '@iota-cn/svc-scaffolding';
import config from './config';

describe('IOTA purchased service test', function () {
    this.timeout(10000);
    config.port = 2142;
    const app = scaffold(config);
    const request = client.agent(app.server);
    const models = app.iota.dc.models;
    let User;
    let Account;
    let ServicePackageA, ServicePackageB, ServicePackageC, ServicePackageD;
    let date1, date2;
    let ServiceType = models.ServicePackage.ServiceType;
    before(async function () {
        await models.User.sync({ force: true });
        User = await models.User.create({ username: 'kadven', password: '123456' });
        await models.Account.sync({ force: true });
        Account = await models.Account.create({ accountName: User.username, balance: 600000, userId: User.id });
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
        await models.AccountServicePackage.sync({ force: true });
        date1 = new Date();
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
    });
    it('basic', function (done) {
        request
            .get('/notfound')
            .expect(404, done);
    });

    it('signin', function (done) {
        request
            .post('/signin')
            .send({
                username: 'kadven',
                password: '123456'
            })
            .expect(200, done)
    });

    it('to obtain a purchased services', function (done) {
        request
            .get(`/accounts/services`)
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                let account = res.body;
                assert.equal(6000, account.balance);
                assert.equal(0, account.service.price);
                assert.equal('免费版', account.service.name);
                done();
            })
    });

})