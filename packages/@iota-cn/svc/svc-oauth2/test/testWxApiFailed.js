import client from 'supertest';
import chai, { assert, expect } from 'chai';

import scaffold from '@iota-cn/svc-scaffolding';

import OAuth2Plat from '../src/model/oauth2plat';
import options from './config';

const should = chai.should();

describe("iOTA oauth2 WeChat test(wx api).", function () {
    options.port = 50002;
    this.timeout(10000);
    let app = scaffold(options);
    let logger = app.iota.logger;
    let cli = client.agent(app.server);
    let dc = app.iota.dc;
    let cache = dc.cache;
    let models = app.iota.dc.models;
    it('test wx api return error.', function (done) {
        cli.get('/oauth2/third_parties/wechat')
            .expect(302)
            .expect('Location', 'http://localhost/oauth2/third_parties/wechat/error')
            .end(function (err, res) {
                if (err) {
                    return done(err);
                }
                done();
            });
    });

    it('test wx api return error 2.', function (done) {
        cli.get('/oauth2/third_parties/wechat?code=AAAAAAAAAAAAAAAAAAAAAAAAAAAA')
            .expect(302)
            .expect('Location', 'http://localhost/oauth2/third_parties/wechat/error')
            .end(function (err, res) {
                if (err) {
                    return done(err);
                }
                done();
            });
    })
});