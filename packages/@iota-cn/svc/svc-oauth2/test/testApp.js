/**
 * Created by kadve on 2016/12/30.
 */
import { Buffer } from 'buffer';
import client from 'supertest';
import chai, { assert, expect } from 'chai';

import scaffold from '@iota-cn/svc-scaffolding';
import AppPlat from '../src/model/appplat'

import options from './config';

const should = chai.should();
describe("iOTA app test.", function () {
    options.port = 50008;
    this.timeout(10000);
    let app = scaffold(options);
    let logger = app.iota.logger;
    let cli = client.agent(app.server);
    let dc = app.iota.dc;
    let cache = dc.cache;
    let models = app.iota.dc.models;
    let user1;
    let userApp1;
    let user;
    let credentials;
    before(async function () {
        await models.User.sync({ force: true });
        user1 = await models.User.create({ username: 'abc', password: 'Iota123_' });
        await models.UserOAuth2.sync({ force: true });
        await models.UserApp.sync({ force: true });
        await models.UserApp.create({ platform: AppPlat.Android, name: 'App1', userId: user1.id });
        await models.UserApp.create({ platform: AppPlat.Application, name: 'App2', userId: user1.id });
        await models.UserApp.create({ platform: AppPlat.Web, name: 'App3', userId: user1.id });
        await models.UserApp.create({ platform: AppPlat.Application, name: 'App4', userId: user1.id });
        await models.UserApp.create({ platform: AppPlat.Android, name: 'App5', userId: user1.id });
        await models.UserApp.create({ platform: AppPlat.Application, name: 'App6', userId: user1.id });
        await models.UserApp.create({ platform: AppPlat.Android, name: 'sdp7', userId: user1.id, createdAt: '2017-1-2' });
        await models.UserApp.create({ platform: AppPlat.Web, name: 'App8', userId: user1.id });
        await models.UserApp.create({ platform: AppPlat.Application, name: 'App9', userId: user1.id });
        await models.UserApp.create({ platform: AppPlat.Application, name: 'App10', userId: user1.id });
        await models.UserApp.create({ platform: AppPlat.Application, name: 'App11', userId: user1.id });
        userApp1 = await models.UserApp.create({ platform: AppPlat.Android, name: 'mawsds', userId: user1.id });
        await models.UserApp.create({ platform: AppPlat.Application, name: 'sksk', userId: user1.id });
        await models.UserApp.create({ platform: AppPlat.Application, name: 'aasssaa', userId: user1.id });
        await models.UserApp.create({
            platform: AppPlat.Android,
            name: 'sdf',
            userId: user1.id,
            createdAt: '2017-1-2'
        });
        await models.UserApp.create({ platform: AppPlat.Android, name: 'aaasda', userId: user1.id });
        user = await models.User.findOne({
            where: { username: 'abc' }
        });
        credentials = new Buffer(`${user.key}:${user.secret}`).toString('base64');
    });

    after(function () {
        app.server.close();
    });
    it('test get app list no params', function (done) {
        cli.post('/oauth2/token')
            .set('Content-Type', 'application/x-www-form-urlencoded;charset=UTF-8')
            .set('Authorization', `Basic ${credentials}`)
            .send('grant_type=client_credentials')
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                let token = res.body;
                assert.isNotNull(token.access_token);
                cli.get('/oauth2/apps?limit=20')
                    .set('Authorization', `Bearer ${token.access_token}`)
                    .expect(200, (err, res) => {
                        if (err) {
                            done(err)
                        } else {
                            let data = res.body;
                            assert.equal(data.total, 16);
                            done();
                        }
                    })
            });
    });
    it('test get app list only limit', function (done) {
        cli.post('/oauth2/token')
            .set('Content-Type', 'application/x-www-form-urlencoded;charset=UTF-8')
            .set('Authorization', `Basic ${credentials}`)
            .send('grant_type=client_credentials')
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                let token = res.body;
                assert.isNotNull(token.access_token);
                cli.get('/oauth2/apps?limit=10')
                    .set('Authorization', `Bearer ${token.access_token}`)
                    .expect(200, (err, res) => {
                        if (err) {
                            done(err)
                        } else {
                            let data = res.body;
                            assert.equal(data.total, 16);
                            assert.equal(data.applications.length, 10);
                            done();
                        }
                    })
            });
    });

    it('test get app list only offset', function (done) {
        cli.post('/oauth2/token')
            .set('Content-Type', 'application/x-www-form-urlencoded;charset=UTF-8')
            .set('Authorization', `Basic ${credentials}`)
            .send('grant_type=client_credentials')
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                let token = res.body;
                assert.isNotNull(token.access_token);
                cli.get('/oauth2/apps?offset=10&limit=20')
                    .set('Authorization', `Bearer ${token.access_token}`)
                    .expect(200, (err, res) => {
                        if (err) {
                            done(err)
                        } else {
                            let data = res.body;
                            assert.equal(data.applications.length, 6);
                            done();
                        }
                    })
            });
    });

    it('test get app list on search', function (done) {
        cli.post('/oauth2/token')
            .set('Content-Type', 'application/x-www-form-urlencoded;charset=UTF-8')
            .set('Authorization', `Basic ${credentials}`)
            .send('grant_type=client_credentials')
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                let token = res.body;
                assert.isNotNull(token.access_token);
                cli.get('/oauth2/apps?offset=0&limit=10&appname=sD&platform=Android')
                    .set('Authorization', `Bearer ${token.access_token}`)
                    .expect(200, (err, res) => {
                        if (err) {
                            done(err)
                        } else {
                            let data = res.body;
                            assert.equal(data.applications.length, 4);
                            done();
                        }
                    })
            });
    });

    it('test get app list on search by platforms', function (done) {
        cli.post('/oauth2/token')
            .set('Content-Type', 'application/x-www-form-urlencoded;charset=UTF-8')
            .set('Authorization', `Basic ${credentials}`)
            .send('grant_type=client_credentials')
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                let token = res.body;
                assert.isNotNull(token.access_token);
                cli.get('/oauth2/apps?offset=0&limit=10&platform=Web,Android')
                    .set('Authorization', `Bearer ${token.access_token}`)
                    .expect(200, (err, res) => {
                        if (err) {
                            done(err)
                        } else {
                            let data = res.body;
                            assert.equal(data.applications.length, 8);
                            done();
                        }
                    })
            });
    });

    it('test get app list by limit and offset', function (done) {
        cli.post('/oauth2/token')
            .set('Content-Type', 'application/x-www-form-urlencoded;charset=UTF-8')
            .set('Authorization', `Basic ${credentials}`)
            .send('grant_type=client_credentials')
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                let token = res.body;
                assert.isNotNull(token.access_token);
                cli.get('/oauth2/apps?limit=10&offset=9')
                    .set('Authorization', `Bearer ${token.access_token}`)
                    .expect(200, (err, res) => {
                        if (err) {
                            done(err)
                        } else {
                            let data = res.body;
                            assert.equal(data.applications.length, 7);
                            done();
                        }
                    })
            });
    });

    it('test create app', function (done) {
        cli.post('/oauth2/token')
            .set('Content-Type', 'application/x-www-form-urlencoded;charset=UTF-8')
            .set('Authorization', `Basic ${credentials}`)
            .send('grant_type=client_credentials')
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                let token = res.body;
                assert.isNotNull(token.access_token);
                cli.post('/oauth2/apps')
                    .set('Authorization', `Bearer ${token.access_token}`)
                    .send({ platform: AppPlat.Application, name: 'App3' })
                    .expect(200, (err, res) => {
                        if (err) {
                            done(err)
                        } else {
                            done();
                        }
                    })
            });
    });

    it('test delete app', function (done) {
        cli.post('/oauth2/token')
            .set('Content-Type', 'application/x-www-form-urlencoded;charset=UTF-8')
            .set('Authorization', `Basic ${credentials}`)
            .send('grant_type=client_credentials')
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                let token = res.body;
                assert.isNotNull(token.access_token);
                cli.delete(`/oauth2/apps/${userApp1.id}`)
                    .set('Authorization', `Bearer ${token.access_token}`)
                    .expect(200, (err, res) => {
                        if (err) {
                            done(err)
                        } else {
                            done();
                        }
                    })
            });
    });


})