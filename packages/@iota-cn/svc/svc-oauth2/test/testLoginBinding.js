import client from 'supertest';
import chai, { assert, expect } from 'chai';

import scaffold from '@iota-cn/svc-scaffolding';

import options from './config';
import OAuth2Plat from '../src/model/oauth2plat';

const should = chai.should();

describe("All Test", function () {
    this.timeout(10000);
    let testWxToken = {
        "openid": "o88AAv_hXfeS-5KTp_VRBLrlQoR4",
        "nickname": "nov rain",
        "sex": 1,
        "language": "zh_CN",
        "city": "Nanjing",
        "province": "Jiangsu",
        "country": "CN",
        "headimgurl": "http:\/\/wx.qlogo.cn\/mmopen\/XYrRG5UShDd2kjNHk2WvEm6CQEvvNm9AhZkDgVuSW7rlUhpMFOvvnm1rAQgqrwVFWLJrU0MaiaW4Ftxh5tcgyQQ\/0",
        "privilege": [],
        "unionid": "oiKTlv3LDYGCLrKmL4DHaakClp0s"
    };

    let testWxUser = {
        "access_token": "3oylfOXNDmEjPm_cvT1t9uTcipBshdOdBnTydTGBuwJtDEYZFMQN-nM2ejKE_6xIi3CDZ38Ir7gMdxHuQm01Jm6Xfs-lnMOWk2gTNrm5kw0",
        "expires_in": 7200,
        "refresh_token": "yPx-Me5lp0ti_VZFftrTEBJ90rT15TKNIMNXblW09grJE8aDTDpfUnRfaaf15irLnhfGwpkIn3Y2cob4lm_de724fYHugUa6egL2CQY2Pa4",
        "openid": "o88AAv_hXfeS-5KTp_VRBLrlQoR4",
        "scope": "snsapi_signin",
        "unionid": "oiKTlv3LDYGCLrKmL4DHaakClp0s",
    };
    let testWxToken1 = {
        "openid": "o88AAv_hXfeS-5KTp_VRBLrlQoR4",
        "nickname": "nov rain",
        "sex": 1,
        "language": "zh_CN",
        "city": "Nanjing",
        "province": "Jiangsu",
        "country": "CN",
        "headimgurl": "http:\/\/wx.qlogo.cn\/mmopen\/XYrRG5UShDd2kjNHk2WvEm6CQEvvNm9AhZkDgVuSW7rlUhpMFOvvnm1rAQgqrwVFWLJrU0MaiaW4Ftxh5tcgyQQ\/0",
        "privilege": [],
        "unionid": "oiKTlv3LDYGCLrKmL4DHaakClp0s1"
    };

    let testWxUser1 = {
        "access_token": "3oylfOXNDmEjPm_cvT1t9uTcipBshdOdBnTydTGBuwJtDEYZFMQN-nM2ejKE_6xIi3CDZ38Ir7gMdxHuQm01Jm6Xfs-lnMOWk2gTNrm5kw0",
        "expires_in": 7200,
        "refresh_token": "yPx-Me5lp0ti_VZFftrTEBJ90rT15TKNIMNXblW09grJE8aDTDpfUnRfaaf15irLnhfGwpkIn3Y2cob4lm_de724fYHugUa6egL2CQY2Pa4",
        "openid": "o88AAv_hXfeS-5KTp_VRBLrlQoR4",
        "scope": "snsapi_signin",
        "unionid": "oiKTlv3LDYGCLrKmL4DHaakClp0s1",
    };
    testWxUser.token = testWxToken;
    testWxUser1.token = testWxToken1;
    options.port = 50003;
    let app = scaffold(options);
    let logger = app.iota.logger;
    let cli = client.agent(app.server);
    let dc = app.iota.dc;
    let cache = dc.cache;
    let models = app.iota.dc.models;
    let user1, user2, user3;
    before(async function () {
        await models.User.sync({ force: true });
        await models.SubUser.sync({ force: true });
        user1 = await models.User.create({ username: 'abc', password: 'Iota123_' });
        user2 = await models.User.create({ username: 'abcd', password: 'Iota123_' });
        user3 = await models.User.create({ username: 'abcde', password: 'Iota123_' });
        await models.User.create({ username: 'abcdef', password: 'Iota123_' });
        await models.UserOAuth2.sync({ force: true });
        await models.UserOAuth2.create({
            userId: user2.id,
            openId: testWxToken.unionid,
            platform: OAuth2Plat.WeChat
        });
        await models.UserOAuth2.create({ userId: user3.id, openId: 'testid', platform: OAuth2Plat.WeChat });
    });

    after(function () {
        app.server.close();
    });

    describe("iOTA oauth2 WeChat test / signin user binding / unbind.", function () {
        /**
         * confirm cannot be test.
         */
        /**
         * binding
         */

        it('test query binding status without signin.', function (done) {
            cli.get('/accounts/wechat/binding/status')
                .expect(401, done());
        });

        it('test query binding status: already binding.', function (done) {
            cli.post('/signin')
                .send({ username: 'abcd', password: 'Iota123_' })
                .expect(200)
                .end(function (err, res) {
                    if (err) {
                        return done(err);
                    }
                    cli.get('/accounts/wechat/binding/status')
                        .expect(200)
                        .end(function (err, res) {
                            if (err) {
                                return done(err);
                            }

                            let result = res.body;
                            assert.equal(result.binding, true);
                            done();
                        });
                });
        });

        it('test query binding status: does not binding.', function (done) {
            cli.post('/signin')
                .send({ username: 'abc', password: 'Iota123_' })
                .expect(200)
                .end(function (err, res) {
                    if (err) {
                        return done(err);
                    }
                    cli.get('/accounts/wechat/binding/status')
                        .expect(200)
                        .end(function (err, res) {
                            if (err) {
                                return done(err);
                            }

                            let result = res.body;
                            assert.equal(result.binding, false);
                            done();
                        });
                });
        });

        it('test unbind : does not binding.', function (done) {
            cli.post('/signin')
                .send({ username: 'abc', password: 'Iota123_' })
                .expect(200)
                .end(function (err, res) {
                    if (err) {
                        return done(err);
                    }
                    cli.get('/accounts/wechat/unbind')
                        .expect(200, done());
                });
        });

        it('test unbind : already binding.', function (done) {
            cli.post('/signin')
                .send({ username: 'abcd', password: 'Iota123_' })
                .expect(200)
                .end(function (err, res) {
                    if (err) {
                        return done(err);
                    }
                    cli.get('/accounts/wechat/unbind')
                        .expect(200, done());
                });
        });
    });
});