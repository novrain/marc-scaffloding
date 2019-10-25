import client from 'supertest';
import chai, { assert, expect } from 'chai';

import scaffold from '@iota-cn/svc-scaffolding';
import config from './config';

const should = chai.should();
describe('IOTA services test', function () {
    this.timeout(10000);
    config.port = 1117;
    const app = scaffold(config);
    const request = client.agent(app.server);
    const models = app.iota.dc.models;
    const dc = app.iota.dc;
    let user1, dashboard1;
    before(async function () {
        // await models.User.sync({ force: true });
        // await models.SubUser.sync({ force: true });
        await models.Dashboard.sync({ force: true });
        user1 = await models.User.create({ username: 'kadven', password: '123456' });
        dashboard1 = await models.Dashboard.create({ colspan: '12', height: '300px', source: '{}', option: "", userId: user1.id });
    });
    it('test signin', function (done) {
        request
            .post('/signin')
            .send({ username: 'kadven', password: '123456' })
            .expect(200, done);
    });
    it('get a dashboard', function (done) {
        request
            .get(`/dashboard/${dashboard1.id}`)
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                let dashboard = res.body;
                console.log(dashboard);
                done();
            })
    })
    it('get all dashboard', function (done) {
        request
            .get(`/dashboard`)
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                let dashboard = res.body;
                console.log(dashboard);
                done();
            })
    })
    it('create a dashboard', function (done) {
        let option = {
            style: { colspan: 6, height: '300px' },
            option: {
                title: {}
            }
        }
        request
            .post(`/dashboard`)
            .send({ option: option, meta: { colspan: '12', height: '280px', source: '/' } })
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                let dashboard = res.body;
                console.log(dashboard);
                done();
            })
    })
    it('update a dashboard', function (done) {
        let option = {
            style: { colspan: 6, height: '300px' },
            option: {
                title: {}
            }
        }
        request
            .put(`/dashboard/${dashboard1.id}`)
            .send({ option: option, meta: { colspan: '12', height: '200px', source: '/sss' } })
            .expect(204, function (err, res) {
                if (err) {
                    return done(err);
                }
                let dashboard = res.body;
                console.log(dashboard);
                done();
            })
    })
    it('delete a dashboard', function (done) {
        request
            .delete(`/dashboard/${dashboard1.id}`)
            .expect(204, function (err, res) {
                if (err) {
                    return done(err);
                }
                let dashboard = res.body;
                console.log(dashboard);
                done();
            })
    })
})