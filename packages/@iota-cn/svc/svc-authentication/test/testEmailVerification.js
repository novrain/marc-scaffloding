import client from 'supertest';
import scaffold from '@iota-cn/svc-scaffolding';
import config from './config';

config.global = config.global || {};
config.global.smtp = {
    host: 'smtp.exmail.qq.com',
    port: 465,
    secure: true, // use SSL
    auth: {
        user: 'service@theiota.cn',
        pass: 'IotaSM123_'
    }
};

describe("iota authorization email verification test", function () {
    this.timeout(10000);
    config.port = 2145;
    const app = scaffold(config);
    const request = client.agent(app.server);
    let models = app.iota.dc.models;
    let cache = app.iota.dc.cache;
    cache.extra(`findPassword=fpw`, 'wang.liang@theiota.cn', 'PX', '300000');
    cache.extra(`activateEmail=ae`, 'wang.liang@theiota.cn', 'PX', '300000');

    before(async function () {
        await models.User.sync({ force: true });
        await models.SubUser.sync({ force: true });
        await models.User.create({ username: 'xigua', password: '123456', email: `wang.liang@theiota.cn` });
    });

    it("send find password email", done => {
        request
            .post('/accounts/password/forget')
            .send({ email: 'wang.liang@theiota.cn' })
            .timeout(30000)
            .expect(204, (err, res) => {
                if (err) {
                    done(err)
                } else {
                    done()
                }
            })
    });

    it("send activate email", done => {
        request
            .post('/accounts/email/active')
            .send({ email: 'wang.liang@theiota.cn' })
            .timeout(30000)
            .expect(204, (err, res) => {
                if (err) {
                    done(err)
                } else {
                    done()
                }
            })
    });

    it("unregistered email", done => {
        request
            .post('/accounts/password/forget')
            .send({ email: '123456@qq.com' })
            .expect(403, (err, res) => {
                if (err) {
                    done(err)
                } else {
                    done()
                }
            })
    });

    it("email find password right id", done => {
        request
            .get('/accounts/password/forget')
            .query({ id: 'fpw' })
            .expect(204, (err, res) => {
                if (err) {
                    done(err)
                } else {
                    done()
                }
            })
    });

    it("email find password wrong id", done => {
        request
            .get('/accounts/password/forget')
            .query({ id: 'fpq' })
            .expect(400, (err, res) => {
                if (err) {
                    done(err)
                } else {
                    done()
                }
            })
    });

    it("email change password right id", done => {
        request
            .post('/accounts/password/reset')
            .send({ id: 'fpw', password: '233456' })
            .expect(204, (err, res) => {
                if (err) {
                    done(err)
                } else {
                    done()
                }
            })
    });

    it("email change password wrong id", done => {
        request
            .post('/accounts/password/reset')
            .send({ id: 'fpq', password: '233456' })
            .expect(400, (err, res) => {
                if (err) {
                    done(err)
                } else {
                    done()
                }
            })
    });

    it('unauthorized activate email', function (done) {
        request
            .get('/accounts/email/active')
            .query({ id: 'ae' })
            .expect(204, done)
    });

    it('signin', function (done) {
        request
            .post('/signin')
            .send({
                username: 'xigua',
                password: '233456'
            })
            .expect(200, done)
    });

    it('authorized activate email', function (done) {
        request
            .get('/accounts/email/active')
            .query({ id: 'ae' })
            .expect(204, done)
    });

    it('signout', function (done) {
        request
            .post('/signout')
            .expect(204, done)
    });
});
