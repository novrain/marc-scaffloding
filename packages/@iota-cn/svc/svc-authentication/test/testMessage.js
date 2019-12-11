import request from 'supertest';
import scaffold from '@iota-cn/svc-scaffolding';
import config from './config';

describe("iota authorization SMS test", function () {
    this.timeout(10000);
    config.port = 2143;
    const app = scaffold(config);
    const client = request.agent(app.server);
    let models = app.iota.dc.models;
    let cache = app.iota.dc.cache;

    it("send SMS", function (done) {
        client
            .post('/validations/smses')
            .send({ mobile: '18130380275' })
            .expect(204, (err, res) => {
                console.log(res.text);
                if (err) {
                    done(err)
                } else {
                    done()
                }
            })
    });

    it("wrong mobile", function (done) {
        client
            .post('/validations/smses')
            .send({ mobile: '18120sadas155703' })
            .expect(400, done)
    });

    it("right verification SMS", async function () {
        await cache.extra(`mobileRegister=18120155703`, '123456', 'PX', '300000');
        return client
            .get(`/validations/smses/validate`)
            .query({ mobile: '18120155703', captcha: 123456 })
            .expect(204)
    });

    it("wrong verification SMS", function (done) {
        client
            .get('/validations/smses/validate')
            .query({ mobile: '18120155703', captcha: 656664 })
            .expect(400, done)
    });
});
