import client from 'supertest';
import chai, { assert, expect } from 'chai';

import scaffold from '@iota-cn/svc-scaffolding';

import options from './config';

const should = chai.should();

describe("iota authorization resource type and operation type test", function () {
    this.timeout(10000);
    options.port = 2171;
    let app = scaffold(options);
    let cli = client.agent(app.server);
    let dc = app.iota.dc;
    let models = dc.models;
    let RsOpTypes = models.ResourceOperationType;
    before(async function () {
        await models.User.sync({ force: true });
        await models.User.create({ username: 'abc', password: '123456' });
        await models.ResourceType.sync({ force: true });
        await models.ResourceOperationType.sync({ force: true });
        let protocolRs = await models.ResourceType.create({
            name: "协议",
            type: models.ResourceType.RSkeys.Protocol,
            desc: "协议资源",
            model: 'ProtocolMeta',
            nameField: 'name',
            idField: 'id',
            key: 'protocols',
            url: 'meta/protocols'
        });
        let interfaceRs = await models.ResourceType.create({
            name: "接口",
            type: models.ResourceType.RSkeys.Interface,
            desc: "接口资源",
            model: 'InterfaceMeta',
            nameField: 'name',
            idField: 'id',
            key: 'interfaces',
            url: 'meta/interfaces'
        });
        let deviceRs = await models.ResourceType.create({
            name: "设备",
            type: models.ResourceType.RSkeys.Device,
            desc: "设备资源",
            model: 'DeviceMeta',
            nameField: 'name',
            idField: 'id',
            key: 'devices',
            url: 'meta/devices'
        });
        let thingRs = await models.ResourceType.create({
            name: "Thing",
            type: models.ResourceType.RSkeys.Thing,
            desc: "Thing资源",
            model: 'Thing',
            nameField: 'name',
            idField: 'id',
            key: 'things',
            url: 'things'
        });
        let deployRs = await models.ResourceType.create({
            name: "Deploy",
            type: models.ResourceType.RSkeys.Deploy,
            desc: "设备布设",
            model: 'Thing',
            nameField: 'name',
            idField: 'id',
            key: 'things',
            url: 'things'
        });
        //
        await RsOpTypes.create({ name: '所有', type: 'protocol.*', desc: '', resourceTypeKey: protocolRs.type });
        await RsOpTypes.create({ name: '查看', type: 'protocol.view', desc: '', resourceTypeKey: protocolRs.type });
        await RsOpTypes.create({ name: '修改', type: 'protocol.update', desc: '', resourceTypeKey: protocolRs.type });
        await RsOpTypes.create({ name: '删除', type: 'protocol.delete', desc: '', resourceTypeKey: protocolRs.type });
        //
        await RsOpTypes.create({ name: '所有', type: 'interface.*', desc: '', resourceTypeKey: interfaceRs.type });
        await RsOpTypes.create({ name: '查看', type: 'interface.view', desc: '', resourceTypeKey: interfaceRs.type });
        await RsOpTypes.create({ name: '修改', type: 'interface.update', desc: '', resourceTypeKey: interfaceRs.type });
        await RsOpTypes.create({ name: '删除', type: 'interface.delete', desc: '', resourceTypeKey: interfaceRs.type });
        //
        await RsOpTypes.create({ name: '所有', type: 'device.*', desc: '', resourceTypeKey: deviceRs.type });
        await RsOpTypes.create({ name: '查看', type: 'device.view', desc: '', resourceTypeKey: deviceRs.type });
        await RsOpTypes.create({ name: '修改', type: 'device.update', desc: '', resourceTypeKey: deviceRs.type });
        await RsOpTypes.create({ name: '删除', type: 'device.delete', desc: '', resourceTypeKey: deviceRs.type });
        //
        await RsOpTypes.create({ name: '所有', type: 'thing.*', desc: '', resourceTypeKey: thingRs.type });
        await RsOpTypes.create({ name: '查看', type: 'thing.view', desc: '', resourceTypeKey: thingRs.type });
        await RsOpTypes.create({ name: '修改', type: 'thing.update', desc: '', resourceTypeKey: thingRs.type });
        await RsOpTypes.create({ name: '删除', type: 'thing.delete', desc: '', resourceTypeKey: thingRs.type });
        //
        await RsOpTypes.create({ name: '所有', type: 'deploy.*', desc: '', resourceTypeKey: deployRs.type });
        await RsOpTypes.create({ name: '查看', type: 'deploy.view', desc: '', resourceTypeKey: deployRs.type });
        await RsOpTypes.create({ name: '修改', type: 'deploy.update', desc: '', resourceTypeKey: deployRs.type });
        await RsOpTypes.create({ name: '删除', type: 'deploy.delete', desc: '', resourceTypeKey: deployRs.type });
    });

    after(function () {
        app.server.close();
    });

    it('get property type', function (done) {
        cli.post('/signin')
            .send({
                username: 'abc',
                password: '123456'
            })
            .expect(200, function () {
                cli.get('/resource_types')
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        assert.equal(res.body.resourceTypes.length, 5);
                        let deviceRs = res.body.resourceTypes[2];
                        assert.equal(deviceRs.name, '设备');
                        assert.equal(deviceRs.operationTypes.length, 4);
                        done();
                    });
            })
    });
});
