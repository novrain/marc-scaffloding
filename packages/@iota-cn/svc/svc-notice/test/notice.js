import path from 'path';
import client from 'supertest';
import scaffold from '@iota-cn/svc-scaffolding';
import config from './config';
import chai, { assert, expect } from 'chai';

describe('notice test >', function () {
    this.timeout(10000);
    config.port = 3337;
    const app = scaffold(config);
    const request = client.agent(app.server);
    const dc = app.iota.dc;
    const models = dc.models;
    let user1, user2, notice0, notice1, notice2, notice3, notice4, un1, un2, un3;

    before(async function () {
        await models.User.sync({ force: true });
        await models.SubUser.sync({ force: true });
        user1 = await models.User.create({
            username: 'xigua',
            password: '123456',
            email: `358242939@qq.com`
        });
        user2 = await models.User.create({
            username: 'mantou',
            password: '123456',
            email: `358242938@qq.com`
        });
        await models.NoticeType.sync({ force: true });
        await models.NoticeType.create({
            id: 'WorkOrder',
            name: '工单通知',
            desc: '工单类型通知'
        });
        await models.NoticeType.create({
            id: 'System',
            name: '系统通知',
            desc: '系统类型通知'
        });
        await models.NoticeType.create({
            id: 'Certification',
            name: '认证通知',
            desc: '认证类型通知'
        });
        await models.Notice.sync({ force: true });
        notice0 = await models.Notice.create({
            receiver: '-1',
            content: '随便建一个啦',
            title: '标题1',
            type: 'System'
        });
        notice1 = await models.Notice.create({
            receiver: '-1',
            content: '大家好我们是可爱又迷人的反派角色',
            title: '标题2',
            type: 'System'
        });
        notice2 = await models.Notice.create({
            receiver: '-1',
            content: '他又啰啰嗦嗦的说了一大堆，什么回字的六种写法',
            title: '标题3',
            type: 'System'
        });
        notice3 = await models.Notice.create({
            receiver: user1.id,
            content: '你对力量一无所知',
            title: '标题4',
            type: 'System'
        });
        await models.UserNotice.sync({ force: true });
        un1 = await models.UserNotice.create({
            userId: user1.id,
            noticeId: notice1.id
        });
        un2 = await models.UserNotice.create({
            userId: user1.id,
            noticeId: notice2.id
        });
        un3 = await models.UserNotice.create({
            userId: user2.id,
            noticeId: notice3.id
        });
    })

    it('basic', function (done) {
        request
            .get('/notfound')
            .expect(404, done);
    });

    it('signin success', function (done) {
        request
            .post('/signin')
            .send({
                username: 'xigua',
                password: '123456'
            })
            .expect(200, done)
    });
    it(`find all user's notices`, function (done) {
        request
            .get('/notices/all')
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                //console.log('<<<<>>>>>', res.body)
                assert.equal(res.body.total, 4);
                assert.equal(res.body.unread, 2);
                assert.equal(res.body.notices.length, 4);
                done();
            })
    });

    it(`find one user's notice`, function (done) {
        request
            .get(`/notices/detail/${notice1.id}`)
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                //console.log('<<<<>>>>>', res.body)
                assert.equal(res.body.userNotices[0].id, un1.id);
                done();
            })
    });

    it(`find notice types`, function (done) {
        request
            .get(`/notice_types`)
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                console.log('<<<<>>>>>', res.body)
                //assert.equal(res.body.userNotices[0].id, un1.id);
                done();
            })
    });

    //it(`create all user's notices`, function (done) {
    //    request
    //        .post(`/notices`)
    //        .send({
    //            targetId: '-1',
    //            content: '您有一条新的消息，请注意查收',
    //            title: '标题5'
    //        })
    //        .expect(200, function (err, res) {
    //            if (err) {
    //                return done(err);
    //            }
    //            //console.log('<<<<>>>>>', res.body)
    //            notice4 = res.body;
    //            assert.equal(res.body.content, '您有一条新的消息，请注意查收');
    //            done();
    //        })
    //});
    //
    //it(`create one user's notice`, function (done) {
    //    request
    //        .post(`/notices`)
    //        .send({
    //            targetId: user2.id,
    //            content: '这是一条单人推送而已',
    //            title: '标题6'
    //        })
    //        .expect(200, function (err, res) {
    //            if (err) {
    //                return done(err);
    //            }
    //            //console.log('<<<<>>>>>', res.body)
    //            assert.equal(res.body.content, '这是一条单人推送而已');
    //            done();
    //        })
    //});

    it(`get all user's unread notices`, function (done) {
        request
            .get('/notices/unread')
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                //console.log('<<<<>>>>>', res.body)
                assert.equal(res.body.total, 2);
                assert.equal(res.body.notices.length, 2);
                done();
            })
    });

    it(`read one user's notice`, function (done) {
        request
            .post(`/notices/read`)
            .send({
                id: [notice3.id]
            })
            .expect(204, function (err1, res1) {
                if (err1) {
                    return done(err1);
                }
                request.get('/notices/all?noticeType=System')
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        //console.log('<<<<>>>>>', res.body)
                        assert.equal(res.body.unread, 1);
                        done();
                    })
            })
    });

    it(`read some user's notices`, function (done) {
        request
            .post(`/notices/read`)
            .send({
                id: [notice0.id, notice1.id, notice2.id, notice3.id]
            })
            .expect(204, function (err1, res1) {
                if (err1) {
                    return done(err1);
                }
                request.get('/notices/all')
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        //console.log('<<<<>>>>>', res.body)
                        assert.equal(res.body.unread, 0);
                        done();
                    })
            })
    });

    it(`get all user's readed notices`, function (done) {
        request
            .get('/notices/read')
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                //console.log('<<<<>>>>>', res.body)
                assert.equal(res.body.total, 4);
                assert.equal(res.body.notices.length, 4);
                done();
            })
    });

    it('signout', function (done) {
        request
            .post('/signout')
            .expect(204, done)
    });

});
