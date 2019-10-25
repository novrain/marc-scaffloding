/**
 * Created by rain on 2017/2/28.
 */
import client from 'supertest';
import chai, { assert, expect } from 'chai';

import scaffold from '@iota-cn/svc-scaffolding';

import options from './config';

const should = chai.should();

describe("iota authorization authorize test", function () {
    this.timeout(10000);
    options.port = 2281;
    let app = scaffold(options);
    let cli = client.agent(app.server);
    let dc = app.iota.dc;
    let models = dc.models;
    let parentUser, subUser1, subUser2, subUser3, invitedUser1, invitedUser2;
    let RsOpTypes = models.ResourceOperationType;
    let userGroup1Id, userGroup2Id;
    let resourceGroup1Id, resourceGroup2Id;
    let protocol1, protocol2, protocol3;
    let role1Id;
    let authorization1Id;
    before(async function () {
        await models.User.sync({ force: true });
        await models.SubUser.sync({ force: true });
        parentUser = await models.User.create({ username: 'abc', password: '123456' });
        invitedUser1 = await models.User.create({
            username: 'inv1',
            password: '123456',
            email: 'wang.liang@theiota.cn'
        });
        invitedUser2 = await models.User.create({
            username: 'inv2',
            password: '123456',
            email: 'wang.liang@free-sun.com.cn'
        });
        subUser1 = await models.User.create({
            username: 'abc1',
            password: '123456',
            type: models.User.UserTypes.Sub
        });
        subUser2 = await models.User.create({
            username: 'abc2',
            password: '123456',
            type: models.User.UserTypes.Sub
        });
        subUser3 = await models.User.create({
            username: 'abc3',
            password: '123456',
            type: models.User.UserTypes.Sub
        });
        await models.SubUser.create({ parentId: parentUser.id, userId: subUser1.id });
        await models.SubUser.create({ parentId: parentUser.id, userId: subUser2.id });
        await models.SubUser.create({ parentId: parentUser.id, userId: subUser3.id });
        await models.UserGroup.sync({ force: true });
        await models.UserGroupUser.sync({ force: true });
        await models.ResourceType.sync({ force: true });
        await models.ResourceOperationType.sync({ force: true });
        await models.Role.sync({ force: true });
        await models.ResourceGroup.sync({ force: true });
        await models.Resource.sync({ force: true });
        await models.Permission.sync({ force: true });
        await models.Authorization.sync({ force: true });
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
        await RsOpTypes.create({
            name: '修改',
            type: 'interface.update',
            desc: '',
            resourceTypeKey: interfaceRs.type
        });
        await RsOpTypes.create({
            name: '删除',
            type: 'interface.delete',
            desc: '',
            resourceTypeKey: interfaceRs.type
        });
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
        await models.ProtocolMeta.sync({ force: true });
        protocol1 = await models.ProtocolMeta.create({
            name: '11',
            createBy: parentUser.id,
            version: '111测试版本',
            enableTime: '2016-01-01',
            desc: '这就是是测试而已',
            protocolTypeId: 1
        });
        protocol2 = await models.ProtocolMeta.create({
            name: '21',
            createBy: parentUser.id,
            version: '222测试版本',
            enableTime: '2016-01-01',
            desc: '这就是是测试而已',
            protocolTypeId: 2
        });
        protocol3 = await models.ProtocolMeta.create({
            name: '31',
            version: '333测试版本',
            createBy: parentUser.id,
            enableTime: '2016-01-01',
            desc: '这就是是测试而已',
            protocolTypeId: 1
        });
        return cli
            .post('/signin')
            .send({
                username: 'abc',
                password: '123456'
            }).expect(200);
    });

    after(function () {
        app.server.close();
    });

    it('create resource group', function (done) {
        cli.post('/resource_groups')
            .send({
                name: 'group1',
                desc: 'group1',
                resources: [{
                    type: models.ResourceType.RSkeys.Protocol,
                    key: protocol1.id
                }]
            })
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                cli.get('/resource_groups?limit=20')
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        resourceGroup1Id = res.body.resourceGroups[0].id;
                        assert.equal(res.body.resourceGroups[0].name, 'group1');
                        done();
                    });
            })
    });

    it('create user group', function (done) {
        cli.post('/user_groups')
            .send({
                name: 'group1',
                desc: 'group1',
                users: [
                    {
                        type: 'Sub',
                        key: subUser1.id
                    },
                    {
                        type: 'Sub', key: subUser2.id
                    },
                    {
                        type: 'Invited',
                        key: 'wang.liang@theiota.cn'
                    }
                ]
            })
            .expect(200, function (err) {
                if (err) {
                    return done(err);
                }
                cli.get('/user_groups?limit=20')
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        userGroup1Id = res.body.userGroups[0].id;
                        assert.equal(res.body.userGroups[0].name, 'group1');
                        done();
                    });
            })
    })

    it('create role', function (done) {
        cli.post('/roles')
            .send({
                name: 'role1',
                desc: 'role1',
                permissions: [
                    {
                        resourceTypeKey: 'Protocol',
                        operationTypeKey: 'protocol.view'
                    }
                ]
            })
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                cli.get('/roles')
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        assert.equal(res.body.roles.length, 1);
                        let role = res.body.roles[0];
                        role1Id = role.id;
                        assert.equal(role.name, 'role1');
                        assert.equal(role.permissions.length, 1);
                        done();
                    })

            });
    });

    it('test create authorization', function (done) {
        cli.post('/authorizations')
            .send({
                userGroupId: userGroup1Id,
                resourceGroupId: resourceGroup1Id,
                roleId: role1Id,
            })
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                cli.get(`/user_groups/${userGroup1Id}/authorizations?limit=20`)
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        assert.equal(res.body.authorizations.length, 1);
                        let authorization = res.body.authorizations[0];
                        authorization.userGroupId = userGroup1Id;
                        authorization.resourceGroupId = resourceGroup1Id;
                        done();
                    })

            });
    });

    it('create authorization with same user gourp and resource group', function (done) {
        cli.post('/authorizations')
            .send({
                userGroupId: userGroup1Id,
                resourceGroupId: resourceGroup1Id,
                roleId: role1Id,
            })
            .expect(409, done);
    });

    it('create resource group 2', function (done) {
        cli.post('/resource_groups')
            .send({
                name: 'group2',
                desc: 'group2',
                resources: [{
                    type: models.ResourceType.RSkeys.Protocol,
                    key: protocol1.id
                }]
            })
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                cli.get('/resource_groups?limit=20')
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        resourceGroup2Id = res.body.resourceGroups[0].id;
                        assert.equal(res.body.resourceGroups[0].name, 'group2');
                        done();
                    });
            })
    });

    it('find reource group not assigned', function (done) {
        cli.get(`/user_groups/${userGroup1Id}/resource_groups/not_assigned`)
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                assert.equal(res.body.total, 1);
                assert.equal(res.body.resourceGroups[0].name, 'group2');
                done();
            });
    });

    it('test create authorization', function (done) {
        cli.post('/authorizations')
            .send({
                userGroupId: userGroup1Id,
                resourceGroupId: resourceGroup2Id,
                roleId: role1Id,
            })
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                cli.get(`/user_groups/${userGroup1Id}/authorizations?limit=20`)
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        assert.equal(res.body.authorizations.length, 2);
                        let authorization = res.body.authorizations[0];
                        authorization.userGroupId = userGroup1Id;
                        authorization.resourceGroupId = resourceGroup2Id;
                        authorization1Id = authorization.id;
                        done();
                    })

            });
    });

    it('test delete authorization', function (done) {
        cli.delete(`/authorizations/${authorization1Id}`)
            .expect(204, function (err, res) {
                if (err) {
                    return done(err);
                }
                cli.get(`/user_groups/${userGroup1Id}/authorizations?limit=1`)
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        assert.equal(res.body.authorizations.length, 1);
                        let authorization = res.body.authorizations[0];
                        authorization.userGroupId = userGroup1Id;
                        authorization.resourceGroupId = resourceGroup1Id;
                        done();
                    })

            });
    });

    it('test limit', async function () {
        let condition = {
            where: {
                createBy: parentUser.id,
                userGroupId: userGroup1Id
            },
            limit: 4,
            offset: 0,
            order: [['createdAt', 'DESC']]
        };
        let authorizations = await models.Authorization.findAndCountAll(condition);
        condition.distinct = true;
        let authWithResources = await models.Authorization.findAndCountAll({
            condition,
            include: [
                {
                    model: models.UserGroup,
                    as: 'userGroup'
                }, {
                    model: models.ResourceGroup,
                    as: 'resourceGroup'
                }, {
                    model: models.Role,
                    as: 'role'
                }
            ]
        });
        assert.equal(authorizations.count, authWithResources.count);
    })
});