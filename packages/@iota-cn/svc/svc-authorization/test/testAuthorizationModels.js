/**
 * Created by rain on 2017/2/17.
 */
import client from 'supertest';
import chai, {assert, expect} from 'chai';

import scaffold from '@iota-cn/svc-scaffolding';

import options from './config';

const should = chai.should();

describe("iota authorization resource type test", function () {
    this.timeout(10000);
    options.port = 2172;
    let app = scaffold(options);
    let cli = client.agent(app.server);
    let dc = app.iota.dc;
    let models = dc.models;
    before(async function () {
        await models.User.sync({force: true});
        await models.User.create({username: 'abc', password: '123456'});
        await models.SubUser.sync({force: true});
        await models.ResourceType.sync({force: true});
        await models.ResourceGroup.sync({force: true});
        await models.Resource.sync({force: true});
        await models.Role.sync({force: true});
        await models.Permission.sync({force: true});
        await models.UserGroup.sync({force: true});
        await models.UserGroupUser.sync({force: true});
        await models.Authorization.sync({force: true});
    });

    after(function () {
        app.server.close();
    });

    it('get property type', function (done) {
        //cli.post('/signin')
        //    .send({
        //        username: 'abc',
        //        password: '123456'
        //    })
        //    .expect(200, function () {
        //        cli.get('/resource_types')
        //            .expect(200, function (err, res) {
        //                if (err) {
        //                    return done(err);
        //                }
        //                assert.equal(res.body.resourceTypes.length, 5);
        //                assert.equal(res.body.resourceTypes[2].name, '设备');
        //                done();
        //            });
        //    })
        done();
    });
});
