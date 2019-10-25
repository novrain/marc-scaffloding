/**
 * Created by rain on 2016/11/4.
 */
import { Buffer } from 'buffer';
import client from 'supertest';
import chai, { assert, expect } from 'chai';

import scaffold from '@iota-cn/svc-scaffolding';
import AppPlat from '../src/model/appplat'

import options from './config';

const should = chai.should();

describe("iOTA oauth2 token test.", function () {
    options.port = 50004
    this.timeout(10000);
    let app = scaffold(options);
    let logger = app.iota.logger;
    let cli = client.agent(app.server);
    let dc = app.iota.dc;
    let cache = dc.cache;
    let models = app.iota.dc.models;
    let user1;
    let token;
    let user;
    let credentials;
    before(async function () {
        await models.User.sync({ force: true });
        user1 = await models.User.create({ username: 'abc', password: 'Iota123_' });
        await models.User.create({ username: 'abcd', password: 'Iota123_' });
        await models.User.create({ username: 'abcde', password: 'Iota123_' });
        await models.User.create({ username: 'abcdef', password: 'Iota123_' });
        await models.UserOAuth2.sync({ force: true });
        await models.UserApp.sync({ force: true });
        await models.UserApp.create({ platform: AppPlat.Application, name: 'Application-App1', userId: user1.id });
        await models.UserApp.create({ platform: AppPlat.Android, name: 'Android-App2', userId: user1.id });
        await models.UserApp.create({ platform: AppPlat.iOS, name: 'iOS-App2', userId: user1.id });

        user = await models.User.findOne({
            where: { username: 'abc' }
        });
        credentials = new Buffer(`${user.key}:${user.secret}`).toString('base64');
    });

    after(function () {
        app.server.close();
    });

    it('test get access token.', function (done) {
        cli.post('/oauth2/token')
            .set('Content-Type', 'application/x-www-form-urlencoded;charset=UTF-8')
            .set('Authorization', `Basic ${credentials}`)
            .send('grant_type=client_credentials')
            .expect(200)
            .end(function (err, res) {
                if (err) {
                    return done(err);
                }
                token = res.body;
                assert.isNotNull(token.access_token);
                cli.get('/accounts/profile')
                    .set('Authorization', `Bearer ${token.access_token}`)
                    .expect(200)
                    .end(function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        assert.equal(res.body.user.username, 'abc');
                        done();
                    });
            });
    });

    it('test refresh token.', function (done) {
        cli.post('/oauth2/token/refresh')
            .set('Content-Type', 'application/x-www-form-urlencoded;charset=UTF-8')
            .set('Authorization', `Basic ${credentials}`)
            .send(`grant_type=refresh_token&refresh_token=${token.refresh_token}`)
            .expect(200)
            .end(function (err, res) {
                if (err) {
                    return done(err);
                }
                let newToken = res.body;
                assert.isNotNull(newToken.access_token);
                assert.notEqual(newToken.access_token, token.access_token);
                token = newToken;
                done();
            });
    });

    it('test invalidate token.', function (done) {
        cli.post('/oauth2/token/invalidate')
            .set('Content-Type', 'application/x-www-form-urlencoded;charset=UTF-8')
            .set('Authorization', `Basic ${credentials}`)
            .send(`access_token=${token.access_token}`)
            .expect(204)
            .end(function (err, res) {
                if (err) {
                    return done(err);
                }
                done();
            });
    });

    it('test invalid get access token.', function (done) {
        credentials = '';
        cli.post('/oauth2/token')
            .set('Content-Type', 'application/x-www-form-urlencoded;charset=UTF-8')
            .set('Authorization', `Basic ${credentials}`)
            .send('grant_type=client_credentials')
            .expect(401)
            .end(function (err, res) {
                if (err) {
                    return done(err);
                }
                let token = res.body;
                assert.isUndefined(token.access_token);
                done();
            });
    });

    it('test invalid get access token2.', function (done) {
        cli.post('/oauth2/token')
            .set('Content-Type', 'application/x-www-form-urlencoded;charset=UTF-8')
            .set('Authorization', `Basic MTYwMjYwY2M3NWIxOGE3MjZiOTcxNDBlNWI1MjIzNmJmZTlmMmNiMTo2Y2E4YzY4NzY0ZWUxNjY4MmYxNWNjNmQ0ZWU1YWEzZTgwYzY3MTNm`)
            .send('grant_type=client_credentials')
            .expect(401)
            .end(function (err, res) {
                if (err) {
                    return done(err);
                }
                let token = res.body;
                assert.isUndefined(token.access_token);
                done();
            });
    });

});