import client from 'supertest';
import chai, { assert, expect } from 'chai';

import scaffold from '@iota-cn/svc-scaffolding';

import createConfig from '../config';
let options = createConfig({});

const should = chai.should();

describe('init auth tables', function () {
    this.timeout(10000);
    options.port = 58546;
    let app = scaffold(options),
        request = client.agent(app.server),
        models = app.iota.dc.models;
    before(async function () {
        await models.User.sync({ force: true });
        await models.SubUser.sync({ force: true });
        await models.Menu.sync({ force: false });
        await models.MenuPreDepends.sync({ force: false });
        await models.Operation.sync({ force: false });
        await models.OperationPreDepends.sync({ force: false });
        await models.Role.sync({ force: false });
        await models.RoleMenu.sync({ force: false });
        await models.RoleOperation.sync({ force: false });
        await models.Organization.sync({ force: false });
        await models.OrganizationRole.sync({ force: false });
        await models.Position.sync({ force: false });
        await models.PositionRole.sync({ force: false });
        await models.UserOrganization.sync({ force: false });
        await models.UserPosition.sync({ force: false });
        await models.UserRole.sync({ force: false });
        await models.User.create({ username: 'admin', password: '123456', isAdmin: true })
    });

    after(function () {
        app.server.close();
    });

    describe('init auth tables', function () {
        it('basic', function (done) {
            request
                .get('/notfound')
                .expect(404, done)
        });

    })
})