import client from 'supertest';
import chai, { assert, expect } from 'chai';
import scaffold from '@iota-cn/svc-scaffolding';

import config from './config';

const should = chai.should();

describe('iota authorization basic verify test >', function () {
    this.timeout(10000);
    config.port = 2140;
    const app = scaffold(config);
    const request = client.agent(app.server);
    const models = app.iota.dc.models;
    const dc = app.iota.dc;

    dc.cache.extra(`vcode=test`, '123456', 'PX', 99999);
    let cookie = 'iota_r=test';

    before(async function () {
        await models.User.sync({ force: true });
        await models.SubUser.sync({ force: true });
        await models.User.create({
            username: 'xigua',
            password: '123456',
            mobile: '18130380275',
            email: 'xiguashenmede@123.com'
        });
    });

    it('basic', function (done) {
        request
            .get('/notfound')
            .expect(404, done);
    });

    it('verify right vcode', async function () {
        return request
            .get('/validations/codes/validate')
            .set('cookie', cookie)
            .query({ vcode: 123456 })
            .expect(204)
    });

    it('verify wrong vcode', async function () {
        return request
            .get('/validations/codes/validate')
            .set('cookie', cookie)
            .query({ vcode: 654123 })
            .expect(400)
    });
});