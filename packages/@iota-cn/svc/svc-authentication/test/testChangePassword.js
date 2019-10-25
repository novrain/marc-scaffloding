import client from 'supertest';
import scaffold from '@iota-cn/svc-scaffolding';
import config from './config';

describe('iota authorization signin-changepassword-signin test >', function () {
    this.timeout(10000);
    config.port = 2144;
    const app = scaffold(config);
    const request = client.agent(app.server);
    const dc = app.iota.dc;
    const models = app.iota.dc.models;

    before(async function () {
        await models.User.sync({ force: true });
        await models.SubUser.sync({ force: true });
        await models.User.create({ username: 'xigua', password: '123456' });
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
                username: 'xigua',
                password: '123456'
            })
            .expect(200, done)
    });

    it('change password', function (done) {
        request
            .post('/accounts/password/change')
            .send({ old: "123456", new: "111111" })
            .expect(204, done)
    });

    it('signout', function (done) {
        request
            .post('/signout')
            .expect(204, done)
    });

    //because:password was changed
    it('signin failure', function (done) {
        request
            .post('/signin')
            .send({
                username: 'xigua',
                password: '123456'
            })
            .expect(400, done)
    });

    it('signin success by new password', function (done) {
        request
            .post('/signin')
            .send({
                username: 'xigua',
                password: '111111'
            })
            .expect(200, done)
    });

    it('signout', function (done) {
        request
            .post('/signout')
            .expect(204, done)
    });
});
