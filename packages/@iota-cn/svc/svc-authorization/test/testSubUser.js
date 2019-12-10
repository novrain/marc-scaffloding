import client from 'supertest';
import chai, { assert, expect } from 'chai';

import scaffold from '@iota-cn/svc-scaffolding';
import config from './config';

const should = chai.should();

describe('iota subUser test >', function () {
    this.timeout(10000);
    config.port = 2170;
    const app = scaffold(config);
    const request = client.agent(app.server);
    const models = app.iota.dc.models;
    let user, subUser, subUser1Id, subUser2Id;

    before(async function () {
        await models.User.sync({ force: true });
        user = await models.User.create({
            username: 'xigua',
            password: '123456',
            mobile: '18130380275',
            email: 'xiguashenmede@123.com',
            type: models.User.UserTypes.Master
        });
        subUser = await models.User.create({
            username: 'xiaomage',
            password: '123456',
            mobile: '18130380274',
            email: 'xiaomage@123.com',
            type: models.User.UserTypes.Sub
        });
        await models.SubUser.sync({ force: true });
        await models.SubUser.create({
            parentId: user.id,
            dependent: true,
            enable: false,
            userId: subUser.id
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
                username: 'xigua',
                password: '123456'
            })
            .expect(200, done)
    });

    it('create subUser', async function () {
        return request
            .post(`/users/${user.id}/subusers`)
            .send({
                username: 'wangbo',
                password: '123456',
                mobile: '18130380222',
                email: 'bo@123.com',
                type: models.User.UserTypes.Sub
            })
            .expect(200)
            .then((res) => {
                // subUser1Id = res.body.subExt.userId;
                subUser1Id = res.body.id;
                assert.equal(res.body.subExt.parentId, user.id);
                assert.equal(res.body.type, models.User.UserTypes.Sub);
            })
    });

    it('create another subUser', async function () {
        return request
            .post(`/users/${user.id}/subusers`)
            .send({
                username: 'guan',
                password: '123456',
                mobile: '18130380333',
                email: 'guan@123.com',
                type: models.User.UserTypes.Sub
            })
            .expect(200)
            .then((res) => {
                subUser2Id = res.body.id;
                // subUser2Id = res.body.subExt.userId;
                assert.equal(res.body.subExt.parentId, user.id);
                assert.equal(res.body.type, models.User.UserTypes.Sub);
            })
    });

    it('get all subUsers after create && without limit', async function () {
        return request
            .get(`/users/${user.id}/subusers?limit=20&&offset=0`)
            .expect(200)
            .then((res) => {
                assert.equal(res.body.users.length, 3);
                assert.equal(res.body.total, 3);
            })
    });

    it('get all subUsers after create && with limit.', async function () {
        return request
            .get(`/users/${user.id}/subusers?limit=1&offset=1`)
            .expect(200)
            .then((res) => {
                assert.equal(res.body.users.length, 1);
                assert.equal(res.body.total, 3);
            })
    });

    it('get one subUser after create', async function () {
        return request
            .get(`/users/${user.id}/subusers/${subUser1Id}`)
            .expect(200)
            .then((res) => {
                assert.equal(res.body.subExt.parentId, user.id);
                assert.equal(res.body.subExt.dependent, true);
            })
    });

    it('multiply enable subUsers', async function () {
        return request
            .post(`/users/${user.id}/subusers/enable`)
            .send({ ids: [subUser.id, subUser1Id, subUser2Id] })
            .expect(204)
            .then((res) => {
                return request
                    .get(`/users/${user.id}/subusers?limit=20`)
                    .expect(200)
                    .then((res) => {
                        assert.equal(res.body.users[0].subExt.enable, true);
                        assert.equal(res.body.users[1].subExt.enable, true);
                        assert.equal(res.body.users[2].subExt.enable, true);
                    })
            })
    });

    it('multiply disable subUsers', async function () {
        return request
            .post(`/users/${user.id}/subusers/disable`)
            .send({ ids: [subUser.id, subUser1Id, subUser2Id] })
            .expect(204)
            .then((res) => {
                return request
                    .get(`/users/${user.id}/subusers?limit=20`)
                    .expect(200)
                    .then((res) => {
                        assert.equal(res.body.users[0].subExt.enable, false);
                        assert.equal(res.body.users[1].subExt.enable, false);
                        assert.equal(res.body.users[2].subExt.enable, false);
                    })
            })
    });

    it('multiply independent subUsers', async function () {
        return request
            .post(`/users/${user.id}/subusers/independent`)
            .send({ ids: [subUser.id, subUser1Id, subUser2Id] })
            .expect(204)
            .then((res) => {
                return request
                    .get(`/users/${user.id}/subusers?limit=20`)
                    .expect(200)
                    .then((res) => {
                        assert.equal(res.body.users[0].subExt.dependent, false);
                        assert.equal(res.body.users[1].subExt.dependent, false);
                        assert.equal(res.body.users[2].subExt.dependent, false);
                    })
            })
    });

    it('multiply dependent subUsers', async function () {
        return request
            .post(`/users/${user.id}/subusers/dependent`)
            .send({ ids: [subUser.id, subUser1Id, subUser2Id] })
            .expect(204)
            .then((res) => {
                return request
                    .get(`/users/${user.id}/subusers?limit=20`)
                    .expect(200)
                    .then((res) => {
                        assert.equal(res.body.users[0].subExt.dependent, true);
                        assert.equal(res.body.users[1].subExt.dependent, true);
                        assert.equal(res.body.users[2].subExt.dependent, true);
                    })
            })
    });

    it('update subUser', async function () {
        return request
            .put(`/users/${user.id}/subusers/${subUser.id}`)
            .send({ username: 'xigua2', subExt: { enable: true, dependent: false } })
            .expect(204)
            .then((res) => {
                return request
                    .get(`/users/${user.id}/subusers/${subUser.id}`)
                    .expect(200)
                    .then((res) => {
                        assert.equal(res.body.subExt.enable, true);
                        assert.equal(res.body.subExt.dependent, false);
                    })
            })
    });
});