import client from 'supertest';
import chai, { assert, expect } from 'chai';

import dcEntry from '@iota-cn/svc-dc';
import Koa from 'koa';
import Router from 'koa-router';
import restfulEntry from '../src/index';
import path from 'path';

describe('iota restful test', function () {
    let app = new Koa();
    let router = new Router();
    let options = {
        dc: {
            orm: {
                url: "postgres://postgres:ROOT@localhost:5433/iOTA_ut",
                opts: {}
            },
            mqtt: {
                broker: 'mqtt://127.0.0.1:1883',
                cmNotifyTopic: 'cm/notify'
            }
            /*
             ,
             cache:{

             }*/,
            models: [require(path.join(__dirname, 'stub/models')).default]
        }
    };
    dcEntry(app, options.dc);
    restfulEntry(app, router, {});
    const restful = app.iota.restful;
    const models = app.iota.dc.models;
    //create, list, read, update, delete
    //associations 和 include 二者只能取一,建议用 include

    let roleResource = restful.resource({
        //associations: true,
        model: models.Role,
        endpoints: ['/role', '/role/:id'],
        actions: ['list', 'read'],
        //attributes: ['id', 'name'],//这个属性无效，0.7.0貌似加了
        excludeAttributes: ['name'],//excludeAttributes为要过滤的字段
        include: [{
            model: models.User, as: 'users',
            attributes: [['name', 'username'], 'id', 'email', 'mobile']
            //可以重命名字段
            //excludeAttributes: ['name']//这里这个属性无效
        }]
    });

    roleResource.read.data.after((req, res, ctx) => {
        console.log(ctx.body)
    });

    restful.resource({
        model: models.Role,
        endpoints: ['/role', '/role/:id'],
        actions: ['create']
    });
    //app.use(app.router.routes());

    router.stack.map(function (v, i) {
        console.log(`${('             ' + v.methods).slice(-10)} - ${v.path}`)
    });

    app.use(router.routes());

    let server = app.listen(2210);

    const request = client.agent(server);

    before(async function () {
        await models.User.sync({ force: true });
        let user1 = await models.User.create({ name: 'xigua', password: '123456', type: 1 });
        await models.User.create({ name: 'nangua', password: '123456', type: 1 });
        await models.Role.sync({ force: true });
        let role1 = await models.Role.create({ name: '企业', desc: '默认企业用户', createBy: '-1' });
        await models.Role.create({ name: '个人', desc: '默认个人用户', createBy: '-1' });
        await models.UserRole.sync({ force: true });
        await models.UserRole.create({ userId: user1.id, roleId: role1.id })
    });

    it('basic', function (done) {
        request
            .get('/notfound')
            .expect(404, done);
    });

    it('get one role', function (done) {
        request
            .get('/role/1')
            .expect(200, (err, res) => {
                if (err) {
                    done(err)
                } else {
                    assert.equal(res.body.id, 1)
                    assert.equal(res.body.users.length, 1)
                    done();
                }
            })
    });

    it('get roles', function (done) {
        request
            .get('/role')
            .expect(200, (err, res) => {
                if (err) {
                    done(err)
                } else {
                    assert.equal(res.body.data.length, 2)
                    assert.equal(res.body.count, 2)
                    done();
                }
            })
    });

    it('post role', function (done) {
        request
            .post('/role')
            .send({ name: '随便创建' })
            .expect(201, done)
    });
});
