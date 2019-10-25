import client from 'supertest';
import scaffold from '@iota-cn/svc-scaffolding';
import config from './config';

describe('iota authorization signup test >', function () {
    this.timeout(10000);
    config.port = 2141;
    const app = scaffold(config);
    const request = client.agent(app.server);
    const dc = app.iota.dc;
    const models = app.iota.dc.models;

    dc.cache.extra(`vcode=test`, '123456', 'PX', 99999);
    let cookie = 'iota_r=test';

    before(async function () {
        await models.User.sync({force: true});
        await models.SubUser.sync({force: true});
        await models.User.create({username: 'xigua', password: '123456'});
    });

    it('basic', function (done) {
        request
            .get('/notfound')
            .expect(404, done);
    });

    it('signup valid email user', function (done) {
        request
            .post('/signup')
            .set('cookie', cookie)
            .send({
                username: 'xigua1',
                password: 1234567891234567,
                email: 'xiguashenmede@123.com',
                vcode: 123456
            })
            .end(function (err, res) {
                if (err) {
                    return done(err);
                }
                done();
            })
    });

    it('signup valid mobile user', function (done) {
        request
            .post('/signup')
            .set('cookie', cookie)
            .send({
                username: 'xigua2',
                password: 123456,
                mobile: 18130380275,
                vcode: 123456
            })
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                done();
            })
    });

    it('signup with too short name', function (done) {
        request
            .post('/signup')
            .set('cookie', cookie)
            .send({
                username: 'x',
                password: 123456,
                mobile: 18120155704,
                vcode: 123456
            })
            .expect(400, done)
    });

    it('signup with too short password', function (done) {
        request
            .post('/signup')
            .set('cookie', cookie)
            .send({
                username: 'xig',
                password: 123,
                mobile: 18120155705,
                vcode: 123456
            })
            .expect(400, done)
    });

    it('signup with wrong email', function (done) {
        request
            .post('/signup')
            .set('cookie', cookie)
            .send({
                username: 'sdgs',
                password: 123456,
                email: 18120155706,
                vcode: 123456
            })
            .expect(400, done)
    });

    it('signup with wrong mobile', function (done) {
        request
            .post('/signup')
            .set('cookie', cookie)
            .send({
                username: '胡西瓜',
                password: 123456,
                mobile: 181201,
                vcode: 123456
            })
            .expect(400, done)
    });
});
