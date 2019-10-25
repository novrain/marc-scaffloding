import client from 'supertest';
import chai, { assert, expect } from 'chai';

import scaffold from '@iota-cn/svc-scaffolding';
import Mmw from '@iota-cn/svc-mmw';

import config from './config';

const should = chai.should();

describe('iota user test >', function () {
    this.timeout(10000);
    config.port = 5002;
    const app = scaffold(config);
    const request = client.agent(app.server);
    const models = app.iota.dc.models;

    before(async function () {
        await models.User.sync({ force: true });
        await models.SubUser.sync({ force: true });
        await models.Menu.sync({ force: true });
        await models.MenuPreDepends.sync({ force: true });
        await models.Operation.sync({ force: true });
        await models.OperationPreDepends.sync({ force: true });
        await models.Role.sync({ force: true });
        await models.RoleMenu.sync({ force: true });
        await models.RoleOperation.sync({ force: true });
        await models.Organization.sync({ force: true });
        await models.OrganizationRole.sync({ force: true });
        await models.Position.sync({ force: true });
        await models.PositionRole.sync({ force: true });
        await models.UserOrganization.sync({ force: true });
        await models.UserPosition.sync({ force: true });
        await models.UserRole.sync({ force: true });
        await models.User.create({
            username: 'iota',
            password: '123456',
            email: '1@2.com'
        });
    });

    describe("device model test.", function () {
        it('basic', function (done) {
            request
                .get('/notfound')
                .expect(404, done);
        });
    });
});