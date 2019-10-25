import client from 'supertest';
import chai, { assert, expect } from 'chai';
import scaffold from '@iota-cn/svc-scaffolding';
import config from './config';
import limiter from '../src';
import Router from 'koa-router';

describe('IOTA rate limit test', function () {
    this.timeout(5000);
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
    let specificationA, specificationB, specificationC, specificationD;
    let date1, date2;
    let ServiceType = models.ServicePackage.ServiceType;
    before(async function () {
        await models.User.sync({ force: true });
        await models.SubUser.sync({ force: true });
        User = await models.User.create({ username: 'admin', password: '123456' });
        User1 = await models.User.create({ username: 'admin1', password: '123456' });
        await models.Account.sync({ force: true });
        await models.ServicePackage.sync({ force: true });
        await models.AccountServicePackage.sync({ force: true });
        await models.Order.sync({ force: true });
        Account = await models.Account.create({ accountName: User.username, balance: 600000, userId: User.id });
        Account1 = await models.Account.create({ accountName: User1.username, balance: 600000, userId: User1.id });
        specificationA = {
            resources: { //资源配额类
                thing: {
                    viewType: 1, //
                    available: true,
                    name: "创建Thing",
                    desc: "",
                    quota: 1,
                    unit: "个",
                    extend: '' //单位后面的文字描述
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
            server: { //服务类
                times: {
                    viewType: 1,
                    available: true,
                    name: "接口调用",
                    desc: "",
                    quota: 1000,
                    unit: "次/月"
                },
                frequency: {
                    viewType: 1,
                    available: true,
                    name: "接口调用",
                    desc: "",
                    quota: 5,
                    unit: "次/秒"
                },
                s2: {
                    viewType: 1,
                    available: true,
                    name: "工单响应",
                    desc: "",
                    quota: 24,
                    unit: "小时",
                    extend: '内',
                },
                s3: {
                    viewType: 2,
                    available: false,
                    name: "一对一技术支持",
                    desc: "",
                },
                s4: {
                    viewType: 2,
                    available: false,
                    name: "一对一客户服务"
                }
            }
        };
        specificationB = {
            resources: { //资源配额类
                thing: {
                    viewType: 1, //数值类
                    available: true,
                    name: "创建Thing",
                    desc: "",
                    quota: 5,
                    unit: "个",
                    extend: '' //单位后面的文字描述
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
            server: {
                times: {
                    viewType: 1,
                    available: true,
                    name: "接口调用",
                    desc: "",
                    quota: 5000,
                    unit: "次/月"
                },
                frequency: {
                    viewType: 1,
                    available: true,
                    name: "接口调用",
                    desc: "",
                    quota: 15,
                    unit: "次/秒"
                },
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
                }

            }
        };
        specificationC = {
            resources: { //资源配额类
                thing: {
                    viewType: 1, //数值类
                    available: true,
                    name: "创建Thing",
                    desc: "",
                    quota: 10,
                    unit: "个",
                    extend: '' //单位后面的文字描述
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
            server: {
                times: {
                    viewType: 1,
                    available: true,
                    name: "接口调用",
                    desc: "",
                    quota: 100000,
                    unit: "次/月"
                },
                frequency: {
                    viewType: 1,
                    available: true,
                    name: "接口调用",
                    desc: "",
                    quota: 100,
                    unit: "次/秒"
                },
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
        specificationD = {
            resources: { //资源配额类
                thing: {
                    viewType: 1, //数值类
                    available: true,
                    name: "创建Thing",
                    desc: "",
                    quota: 20,
                    unit: "个",
                    extend: '' //单位后面的文字描述
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
            server: {
                times: {
                    viewType: 1,
                    available: true,
                    name: "接口调用",
                    desc: "",
                    quota: 500000,
                    unit: "+次/月"
                },
                frequency: {
                    viewType: 1,
                    available: true,
                    name: "接口调用",
                    desc: "",
                    quota: 200,
                    unit: "+次/秒"
                },
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
        date1 = new Date('2018-02-02');
        date2 = new Date(date1);
        date2.setFullYear(date2.getFullYear() + 100);
        date2.setDate(date2.getDate() - 1);
        await models.AccountServicePackage.create({
            name: ServicePackageA.name,
            price: ServicePackageA.price,
            beginTime: date1,
            endTime: date2,
            specification: ServicePackageA.specification,
            initialSpecification: ServicePackageA.specification,
            accountId: Account1.id,
            servicePackageId: ServicePackageA.id
        });
        //过期服务
        await models.AccountServicePackage.create({
            name: ServicePackageB.name,
            price: ServicePackageB.price,
            beginTime: new Date('2015-12-12'),
            endTime: new Date('2017-12-11'),
            specification: ServicePackageB.specification,
            initialSpecification: ServicePackageB.specification,
            accountId: Account.id,
            servicePackageId: ServicePackageB.id
        });
    });
    /*未登录时访问接口限制， 从配置文件读取给定配额*/
    for (let i = 1; i <= 7; i++) {
        it(`test signin before call ${i} times`, (done) => {
            if (i <= 5) {
                request
                    .get(`/services/packages/${ServicePackageA.id}`)
                    .set('X-real-ip', `127.0.0.2`)
                    .expect(200)
                    .end((err, res) => {
                        if (err) {
                            console.log(res.text);
                            return done(err)
                        };
                        console.log('剩余次数:', res.header['rate-limit-remaining']);
                        console.log('总次数:', res.header['rate-limit-total']);
                        assert.equal(res.header['rate-limit-remaining'], 5 - i);
                        done();
                    })
            } else {
                request
                    .get(`/services/packages/${ServicePackageA.id}`)
                    .set('X-real-ip', `127.0.0.2`)
                    .expect(429, done)
            }
        });
    }
    it('test signin', (done) => {
        request
            .post('/signin')
            .set('X-real-ip', '127.0.0.1')
            .send({ username: "admin", password: '123456' })
            .expect(200, (err, res) => {
                if (err) {
                    console.log(res.text);
                    return done(err)
                }
                console.log('剩余次数:', res.header['rate-limit-remaining']);
                console.log('总次数:', res.header['rate-limit-total']);
                done();
            })
    });
    for (let i = 1; i <= 16; i++) {
        if (i <= 15) {
            it(`after signin test call ${i} times`, (done) => {
                request
                    .get('/accounts/finance')
                    .set('X-real-ip', '127.0.0.1')
                    .expect(200)
                    .end((err, res) => {
                        if (err) return done(err);
                        console.log('剩余次数:', res.header['rate-limit-remaining']);
                        console.log('总次数:', res.header['rate-limit-total']);
                        assert.equal(res.header['rate-limit-remaining'], 40 - i);
                        done();
                    })
            })
        } else {
            it(`after signin test call ${i} times`, (done) => {
                request
                    .get('/accounts/finance')
                    .set('X-real-ip', '127.0.0.1')
                    .expect(429, (err, res) => {
                        console.log(res.header);
                        done();
                    })
            })
        }

    }

    /*it('test signout',(done) => {
     request
     .post('/signout')
     .set('X-real-ip','127.0.0.3')
     .expect(204,done)
     })*/
})