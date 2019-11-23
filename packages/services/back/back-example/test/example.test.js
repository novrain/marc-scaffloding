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
        await models.User.create({ id: 'admin', username: 'admin', password: '123456', isAdmin: true })
        await models.Dictionary.sync({ force: true })
        await models.DictionaryItem.sync({ force: true })
        await models.DictionaryItem.sync({ force: true })
        await models.ProcessDef.sync({ fore: true })
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