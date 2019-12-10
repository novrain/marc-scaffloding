import client from 'supertest';
import chai, { assert, expect } from 'chai';

import scaffold from '@iota-cn/svc-scaffolding';
import Mmw from '@iota-cn/svc-mmw';

import config from './config';
import User from '../src/api/user';
import UserTypes from '../src/model/user_types';

const should = chai.should();

describe('iota user test >', function () {
    this.timeout(10000);
    config.port = 3335;
    const app = scaffold(config);
    const request = client.agent(app.server);
    const models = app.iota.dc.models;

    before(async function () {
        await models.User.sync({ force: true });
        await models.SubUser.sync({ force: true });
        await models.UserExtention.sync({ force: true });
        await models.User.create({
            username: 'xigua',
            password: '123456',
            mobile: '18130380275',
            email: '1@2.com'
        });
    });

    it('basic', function (done) {
        request
            .get('/notfound')
            .expect(404, done);
    });

    it('verify usable username', async function () {
        return request
            .get('/validations/usernames/validate')
            .query({ username: 'kadven' })
            .expect(204)
    });

    it('verify unusable username', async function () {
        return request
            .get('/validations/usernames/validate')
            .query({ username: 'xigua' })
            .expect(400)
    });

    it('verify usable mobile', async function () {
        return request
            .get('/validations/mobiles/validate')
            .query({ mobile: 17120155703 })
            .expect(204)
    });

    it('verify unusable mobile', async function () {
        return request
            .get('/validations/mobiles/validate')
            .query({ mobile: 18130380275 })
            .expect(400)
    });

    it('verify usable email', async function () {
        return request
            .get('/validations/emails/validate')
            .query({ email: 'xyz@123.com', })
            .expect(204)
    });

    it('verify unusable email', async function () {
        return request
            .get('/validations/emails/validate')
            .query({ email: '1@2.com', })
            .expect(400)
    });

    it('checkUser test', async function () {
        let ctx = {
            request: {
                body: {
                    username: 'xigua',
                    password: '123456'
                }
            },
            iota: app.iota
        };
        await User.checkUser(ctx);
        assert.equal(ctx.status, 400);
        ctx.request.body.username = 'abc';
        await User.checkUser(ctx);
        assert.equal(ctx.status, 400);
        ctx.request.body.username = 'abcdef';
        ctx.request.body.mobile = '12345678901';
        await User.checkUser(ctx);
        assert.equal(ctx.status, 200);
        ctx.request.body.email = '123@gmail.com';
        await User.checkUser(ctx);
        assert.equal(ctx.status, 200);
        ctx.request.body.email = '1@2.com';
        await User.checkUser(ctx);
        assert.equal(ctx.status, 409);
        ctx.request.body.email = '123@gmail.com';
        ctx.request.body.mobile = '18130380275';
        await User.checkUser(ctx);
        assert.equal(ctx.status, 409);
        ctx.request.body = {};
        await User.checkUser(ctx);
        assert.equal(ctx.status, 400);
    });

    it('create user test', async function () {
        let ctx = {
            request: {
                body: {
                    username: 'xigua',
                    password: '123456',
                    mobile: '18168073446',
                }
            },
            iota: app.iota
        };

        //invalid name
        await User.create(ctx);
        assert.equal(ctx.status, 409);
        //valid
        delete ctx.iota.session;
        ctx.request.body.username = 'abcdefg';
        await User.create(ctx);
        assert.equal(ctx.status, 200);
        //new valid and middleware
        ctx.request.body.username = 'abcdefgh';
        ctx.request.body.mobile = '18168072446';
        let testValue = 0;
        ctx.iota.user.hooks.afterCreate.use(async function (ctx, next) {
            testValue++;
            await next();
        });
        delete ctx.iota.session;
        await User.create(ctx);
        assert.equal(ctx.status, 200);
        assert.equal(testValue, 1);
        let parentId = ctx.body.id;
        //sub user
        ctx.request.body.username = 'abcdefghi';
        ctx.request.body.mobile = '18168071446';
        ctx.request.body.type = UserTypes.Sub;
        ctx.params = { parentId: parentId };
        ctx.iota.user.hooks.afterCreate.use(async function (ctx, next) {
            let parentId = ctx.params.parentId;
            let user = ctx.body;
            if (user.type === UserTypes.Sub) {
                if (!parentId) {
                    throw new Error('Invalid parentId', 'ParentId is invalid.')
                }
                let subUser = await models.SubUser.create({
                    parentId: parentId,
                    active: true,
                    individual: false,
                    userId: user.id
                }, { transaction: ctx.iota.session.transaction });
                if (subUser) {
                    ctx.body.subExt = subUser;
                }
            }
        });
        delete ctx.iota.session;
        await User.create(ctx);
        assert.equal(ctx.status, 200);
        assert.equal(testValue, 2);
        let user = await models.User.findOne({
            where: { id: ctx.body.id },
            include: [
                {
                    model: models.SubUser,
                    as: "subExt",
                    where: { parentId: parentId, userId: ctx.body.id }
                }
            ]
        });
        assert.equal(user.id, ctx.body.id);
        assert.equal(user.subExt.parentId, parentId);
        // assert.equal(user.subExt.userId, user.id);
    });


    it('update user test', async function () {
        let ctx = {
            request: {
                body: {
                    username: 'xiguanew',
                    password: '123456',
                    mobile: '18168083446',
                    email: '2@2.com'
                }
            },
            iota: app.iota
        };

        ctx.iota.user.hooks.afterCreate = new Mmw();
        delete ctx.iota.session;
        await User.create(ctx);
        //update with no change
        delete ctx.iota.session;
        ctx.request.body.id = ctx.body.id;
        await User.update(ctx);
        assert.equal(ctx.status, 204);
        //update with conflict name
        delete ctx.iota.session;
        ctx.request.body.username = 'xigua';
        await User.update(ctx);
        assert.equal(ctx.status, 409);
        //update with conflict email
        delete ctx.iota.session;
        ctx.request.body.username = 'xiguanew';
        ctx.request.body.email = '1@2.com';
        await User.update(ctx);
        assert.equal(ctx.status, 409);
        //update with conflict mobile
        delete ctx.iota.session;
        ctx.request.body.email = '2@2.com';
        ctx.request.body.mobile = '18168073446';
        await User.update(ctx);
        assert.equal(ctx.status, 409);

        //valid
        delete ctx.iota.session;
        ctx.request.body.username = 'bcdefg';
        ctx.request.body.mobile = '18168083446';
        await User.update(ctx);
        assert.equal(ctx.status, 204);
        //new valid and middleware
        ctx.request.body.username = 'bcdefgh';
        ctx.request.body.mobile = '18168082446';
        let testValue = 0;
        ctx.iota.user.hooks.afterUpdate.use(async function (ctx, next) {
            testValue++;
            await next();
        });
        delete ctx.iota.session;
        await User.update(ctx);
        assert.equal(ctx.status, 204);
        assert.equal(testValue, 1);
        //update with 部分信息
        ctx.request.body = {
            id: ctx.request.body.id,
            username: ctx.request.body.username,
            subExt: { enable: true, dependent: false }
        };
        ctx.iota.user.hooks.afterUpdate.use(async function (ctx, next) {
            await next();
        });
        delete ctx.iota.session;
        await User.update(ctx);
        assert.equal(ctx.status, 204);
        assert.equal(testValue, 2);
        //update with 空信息
        delete ctx.iota.session;
        ctx.request.body = { id: ctx.request.body };
        await User.update(ctx);
        assert.equal(ctx.status, 400);
    });
});

