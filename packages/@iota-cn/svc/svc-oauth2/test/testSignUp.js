import client from 'supertest';
import chai, { assert, expect } from 'chai';

import scaffold from '@iota-cn/svc-scaffolding';

import OAuth2Plat from '../src/model/oauth2plat';
import options from './config';

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

    options.port = 50001;
    let app = scaffold(options);
    let logger = app.iota.logger;
    let cli = client.agent(app.server);
    let dc = app.iota.dc;
    let cache = dc.cache;
    let models = app.iota.dc.models;
    let user1;
    before(async function () {
        await models.User.sync({ force: true });
        user1 = await models.User.create({ username: 'abc', password: 'Iota123_' });
        await models.UserOAuth2.sync({ force: true });
        await models.UserOAuth2.create({
            userId: user1.id,
            openId: testWxToken.unionid,
            platform: OAuth2Plat.WeChat
        });
    });

    after(function () {
        app.server.close();
    });


    describe("iOTA oauth2 WeChat test(signUp).", function () {

        let cookie = 'iota_r=test';
        afterEach(async function () {
            await cache.delete('userkey');
            await cache.delete('userkey1');
            await cache.delete('vcode=test');
        });

        beforeEach(async function () {
            await cache.set('userkey', JSON.stringify(testWxUser));
            await cache.set('userkey1', JSON.stringify(testWxUser1));
            await cache.set(`vcode=test`, '123456');
        });
        /**
         * register
         */
        it('test signup user already exist.', function (done) {
            cli.post('/oauth2/third_parties/wechat/signup')
                .send({
                    username: 'abc',
                    password: 'Iota123_',
                    mobile: 18120155703,
                    vcode: '123456'
                })
                .set('Cookie', 'wxk=userkey1' + ';' + cookie)
                .expect(409, done);
        });

        it('test signup wx biding other.', function (done) {
            cli.post('/oauth2/third_parties/wechat/signup')
                .send({ username: 'abc', password: 'Iota123_' })
                .set('Cookie', ['wxk=userkey'])
                .expect(409)
                .end(function (err, res) {
                    if (err) {
                        return done(err);
                    }

                    let result = res.body;
                    assert.equal(result.name, 'wx_binding_other');
                    done();
                });
        });

        it('test signup key expires.', function (done) {
            cli.post('/oauth2/third_parties/wechat/signup')
                .send({ username: 'xxx', password: 'bbb' })
                .set('Cookie', ['wxk=erkey'])
                .expect(400)
                .end(function (err, res) {
                    if (err) {
                        return done(err);
                    }
                    let result = res.body;
                    assert.equal(result.name, 'invalid request');
                    done();
                });
        });

        it('test signup user success.', function () {
            return cli.post('/oauth2/third_parties/wechat/signup')
                .send({
                    username: 'abc123',
                    password: 'Iota123_',
                    mobile: 18120155703,
                    vcode: '123456'
                })
                .set('Cookie', 'wxk=userkey1' + ';' + cookie)
                .expect(200)
                .then(async function (res) {
                    let recOpenid = await models.UserOAuth2.findAll({
                        where: {
                            openId: testWxToken1.unionid
                        }
                    });
                    assert.equal(recOpenid.length, 1);
                    assert.equal(recOpenid[0].userId, res.body.id);
                });
        });
    });
});

