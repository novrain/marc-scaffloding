import client from 'supertest';
import scaffold from '@iota-cn/svc-scaffolding';
import config from './config';
import { assert } from 'chai';

describe("iota authorization vcode test", function () {
    this.timeout(10000);
    config.port = 2142;
    const app = scaffold(config);
    const request = client.agent(app.server);

    let cookie;

    it("send vcode", function (done) {
        request
            .get('/validations/codes')
            .expect(200, (err, res) => {
                if (err) {
                    done(err)
                } else {
                    console.log(res.header["set-cookie"]);
                    cookie = res.header["set-cookie"][0];
                    assert.notEqual(res.text, null);
                    assert.isTrue(res.text.length > 27);
                    done()
                }
            })
    });
    it("refresh vcode", function (done) {
        request
            .get('/validations/codes')
            .expect(200, (err, res) => {
                if (err) {
                    done(err)
                } else {
                    //let cookie = res.header["set-cookie"][0];
                    //console.log(res.header["set-cookie"]);
                    console.log(res.header);
                    done()
                }
            })
    });
    app.iota.dc.cache.extra(`vcode=test`, '123456', 'PX', 99999);
    let cookie2 = 'iota_r=test';
    it("verify vcode", function (done) {
        const request = client.agent(app.server);
        request
            .get('/validations/codes/validate')
            .set('cookie', cookie2)
            .query({ vcode: '123456' })
            .expect(204, (err, res) => {
                if (err) {
                    done(err)
                } else {
                    //let cookie = res.header["set-cookie"][0];
                    //console.log(res.header["set-cookie"]);
                    console.log(res.header);
                    done()
                }
            })
    });
})


