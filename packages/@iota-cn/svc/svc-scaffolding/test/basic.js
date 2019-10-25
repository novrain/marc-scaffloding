'use strict';
import request from 'supertest';
import session from '@iota-cn/svc-session'
import Router from 'koa-router';
import {assert} from 'chai';
//use require as function here or us import at the beginning of file.
const scaffold = require('../src/index').default;
const config = require('../src/config').default;
config.port = 34444;
//'c'：console ; 'b':'background' 这里是测试 t :test
config.cookie = {prefix: 't'};
const app = scaffold(config);
const router = new Router();

app.use(session({
    key: 'iota'
}));

app.use(async (ctx, next) => {
    console.log('<--begin-->');
    console.log(ctx.session);
    ctx.body = 'ok';
    await next();
})

app.use(router.routes());

router.get("/get", (ctx) => {
        console.log('<--set-->');
        ctx.session.get = {name: "get"};
        ctx.session.maxAge = 3600 * 1000 * 24 * 7;

        console.log(ctx.session);
    })
    .post("/post", (ctx) => {
        console.log('<--post-->');
        ctx.session.post = {name: "post"};
        ctx.session.maxAge = 3600 * 1000 * 24 * 7;

        console.log(ctx.session);


    })
    .put("/put", (ctx) => {
        console.log('<--put-->');
        ctx.session.put = {name: "put"};
        console.log(ctx.session);

    })
describe('basic test', function () {
    this.timeout(10000);
    let cookie, cookie1, cookie2;
    const client = request.agent(app.listen());

    it("should be work", done => {
        client
            .get("/")
            .expect(200, 'ok', done);
    });
    it("post", done => {
        client
            .post("/post")
            .send({
                username: 'test',
                password: '123456',
                remember: true
            })
            .expect(200, (err, res) => {
                if (err) done(err);
                console.log(res.header);
                cookie = res.header["set-cookie"][0];
                assert.equal(cookie[0], 't');
                console.log(res.header["set-cookie"]);
                console.log(cookie);
                done();
            })
    });
    it("get post", done => {
        client
            .get("/")
            .set('cookie', cookie)
            .expect(200, 'ok', done);
    });
    it("put", done => {
        client
            .put("/put")
            //.set('Access-Control-Allow-Origin', '*')
            .expect(200, (err, res) => {
                if (err) done(err);
                cookie1 = res.header["set-cookie"][0];
                assert.equal(cookie1[0], 't');
                console.log(res.header["set-cookie"]);
                console.log(cookie1);
                done();
            })
    });
    it("get put", done => {
        client
            .get("/")
            .set('cookie', cookie1)
            .expect(200, 'ok', done);
    });
    it("get", done => {
        client
            .get("/get")
            //.set('Access-Control-Allow-Origin', '*')
            .expect(200, (err, res) => {
                if (err) done(err);
                cookie2 = res.header["set-cookie"][0];
                assert.equal(cookie2[0], 't');
                console.log(res.header["set-cookie"]);
                console.log(cookie2);
                done();
            })
    });
    it("get get", done => {
        client
            .get("/")
            .set('cookie', cookie2)
            .expect(200, 'ok', done);
    });
});