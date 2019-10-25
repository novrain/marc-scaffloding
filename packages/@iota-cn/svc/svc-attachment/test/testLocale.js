import path from 'path';
import client from 'supertest';
import scaffold from '@iota-cn/svc-scaffolding';
import config from './config';

describe('attchment test >', function () {
    this.timeout(10000);
    config.port = 13337;
    const app = scaffold(config);
    const request = client.agent(app.server);
    const dc = app.iota.dc;
    const models = app.iota.dc.models;

    let jpgpath = path.join(__dirname, 'upload', 'pikaqq.jpg');
    let bmppath = path.join(__dirname, 'upload', 'dragon.bmp');
    let jpg2path = path.join(__dirname, 'upload', 'rockets.jpg');
    let errpath = path.join(__dirname, 'upload', '404.html');

    let image;

    before(async function () {
        await models.User.sync({ force: true });
        await models.User.create({ username: 'xigua', password: '123456', email: `358242939@qq.com` });
    })

    it('signin success', function (done) {
        request
            .post('/signin')
            .send({
                username: 'xigua',
                password: '123456'
            })
            .expect(200, done)
    });

    it("upload avatar", function (done) {
        request
            .post('/attachment/gravatar')
            .attach('iotaupload', jpgpath)
            .expect(200, done);
    });

    it("upload avatar2", function (done) {
        request
            .post('/attachment/device')
            .attach('iotaupload', bmppath)
            .expect(200, done);
    });

    it("upload avatar3", function (done) {
        request
            .post('/attachment/update')
            .attach('iotaupload', bmppath)
            .expect(200, (err, res) => {
                //console.log(res.text);
                if (err) {
                    done(err)
                } else {
                    image = res.body.uploaded + '';
                    done()
                }
            })
    });

    // it("err upload", function(done) {
    //     request
    //         .post('/attachment/gravatar')
    //         .attach('iotaupload', errpath)
    //         .expect(400, done)
    // });


    // it("update avatar", (done) => {
    //     request
    //         .put('/attachment')
    //         .query({src: image})
    //         .attach('iotaupload', jpgpath)
    //         .expect(200, (err, res)=> {
    //             console.log(res.body);
    //             if (err) {
    //                 done(err)
    //             } else {
    //                 image = res.body.uploaded + '';
    //                 done()
    //             }
    //         })
    // });

    // it("update avatar 2", (done) => {
    //     request
    //         .put('/attachment')
    //         .query({src: image})
    //         .attach('iotaupload', jpg2path)
    //         .expect(200, done);
    // });

    // it("err update", (done) => {
    //     request
    //         .put('/attachment')
    //         .query({src: image})
    //         .attach('iotaupload', errpath)
    //         .expect(500, done);
    // });

    // it.skip("err update 2", (done) => {
    //     request
    //         .put('/attachment')
    //         .attach('iotaupload', errpath)
    //         .expect(400)
    //         .end(function (err, res) {
    //             if (err) {
    //                 return done(err);
    //             }
    //             done();
    //         });
    // });

    it('signout', function (done) {
        request
            .post('/signout')
            .expect(204, done)
    });

});