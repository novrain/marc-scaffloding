import client from 'supertest';
import chai, { assert, expect } from 'chai';

import scaffold from '@iota-cn/svc-scaffolding';

import options from './config';

const should = chai.should();

describe("iota authorization resource group test", function () {
    this.timeout(10000);
    options.port = 2211;
    let app = scaffold(options);
    let cli = client.agent(app.server);
    let dc = app.iota.dc;
    let models = dc.models;
    let user, protocol1, protocol2, protocol3, group1Id, group2Id, resource1Id;
    before(async function () {
        await models.User.sync({ force: true });
        user = await models.User.create({ username: 'abc', password: '123456' });
        await models.ResourceType.sync({ force: true });
        await models.ResourceType.create({
            name: "协议",
            type: models.ResourceType.RSkeys.Protocol,
            desc: "协议资源",
            model: 'ProtocolMeta',
            nameField: 'name',
            idField: 'id',
            key: 'protocols',
            url: 'meta/protocols'
        });
        await models.ResourceType.create({
            name: "接口",
            type: models.ResourceType.RSkeys.Interface,
            desc: "接口资源",
            model: 'InterfaceMeta',
            nameField: 'name',
            idField: 'id',
            key: 'interfaces',
            url: 'meta/interfaces'
        });
        await models.ResourceType.create({
            name: "设备",
            type: models.ResourceType.RSkeys.Device,
            desc: "设备资源",
            model: 'DeviceMeta',
            nameField: 'name',
            idField: 'id',
            key: 'devices',
            url: 'meta/devices'
        });
        await models.ResourceType.create({
            name: "Thing",
            type: models.ResourceType.RSkeys.Thing,
            desc: "Thing资源",
            model: 'Thing',
            nameField: 'name',
            idField: 'id',
            key: 'things',
            url: 'things'
        });
        await models.ResourceType.create({
            name: "Deploy",
            type: models.ResourceType.RSkeys.Deploy,
            desc: "设备布设",
            model: 'Thing',
            nameField: 'name',
            idField: 'id',
            key: 'things',
            url: 'things'
        });
        await models.ProtocolMeta.sync({ force: true });
        protocol1 = await models.ProtocolMeta.create({
            name: '11',
            createBy: user.id,
            belongTo: user.id,
            version: '111测试版本',
            enableTime: '2016-01-01',
            desc: '这就是是测试而已',
            protocolTypeId: 1
        });
        protocol2 = await models.ProtocolMeta.create({
            name: '21',
            createBy: user.id,
            belongTo: user.id,
            version: '222测试版本',
            enableTime: '2016-01-01',
            desc: '这就是是测试而已',
            protocolTypeId: 2
        });
        protocol3 = await models.ProtocolMeta.create({
            name: '31',
            createBy: user.id,
            belongTo: user.id,
            version: '333测试版本',
            enableTime: '2016-01-01',
            desc: '这就是是测试而已',
            protocolTypeId: 1
        });
        await models.ResourceGroup.sync({ force: true });
        await models.Resource.sync({ force: true });
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
                cli.get('/resource_groups')
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        group1Id = res.body.resourceGroups[0].id;
                        assert.equal(res.body.resourceGroups[0].name, 'group1');
                        done();
                    });
            })
    })

    it('update resource group', function (done) {
        cli.put(`/resource_groups/${group1Id}`)
            .send({
                name: 'changeNameGroup1',
                desc: 'changeDescGroup1',
            })
            .expect(204, function (err) {
                if (err) {
                    return done(err);
                }
                cli.get('/resource_groups')
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        assert.equal(res.body.resourceGroups[0].name, 'changeNameGroup1');
                        assert.equal(res.body.resourceGroups[0].desc, 'changeDescGroup1');
                        done();
                    });
            })
    })

    it('update one item(name) resource group', function (done) {
        cli.put(`/resource_groups/${group1Id}`)
            .send({
                name: 'chgagain',
            })
            .expect(204, function (err) {
                if (err) {
                    return done(err);
                }
                cli.get('/resource_groups')
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        assert.equal(res.body.resourceGroups[0].name, 'chgagain');
                        done();
                    });
            })
    })

    it('update resource group when id is wrong', function (done) {
        cli.put(`/resource_groups/48f0ad36-bf0d-4e15-a122-b348da053530`)
            .send({
                name: 'changeNameGroup1',
            })
            .expect(404, function (err) {
                if (err) {
                    return done(err);
                }
                cli.get('/resource_groups/48f0ad36-bf0d-4e15-a122-b348da053530')
                    .expect(404, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        cli.get('/resource_groups')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.resourceGroups[0].name, 'chgagain');
                                done();
                            });
                    });
            })
    })

    it('delete resource group when id is wrong', function (done) {
        cli.delete(`/resource_groups?ids=48f0ad36-bf0d-4e15-a122-b348da053530`)
            .expect(404, function (err) {
                if (err) {
                    return done(err);
                }
                cli.get('/resource_groups')
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        assert.equal(res.body.total, 1);
                        done();
                    });
            })
    })

    it('delete resource group1', function (done) {
        cli.delete(`/resource_groups/${group1Id}`)
            .expect(204, function (err) {
                if (err) {
                    return done(err);
                }
                cli.get('/resource_groups')
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        assert.equal(res.body.total, 0);
                        done();
                    });
            })
    })

    it('create another resource group with some resources', function (done) {
        cli.post('/resource_groups')
            .send({
                name: 'group2',
                desc: 'group2',
                resources: [{
                    type: models.ResourceType.RSkeys.Protocol,
                    key: protocol2.id
                }, {
                    type: models.ResourceType.RSkeys.Protocol,
                    key: protocol3.id
                }]
            })
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                group2Id = res.body.id;
                cli.get(`/resource_groups/${group2Id}/resources`)
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        assert.equal(res.body.resources.length, 2);
                        assert.equal(res.body.resources[0].resourceGroupId, group2Id);
                        assert.equal(res.body.resources[1].resourceGroupId, group2Id);
                        done();
                    });
            })
    })

    it('find resource not in group2 after create', function (done) {
        cli.get(`/resource_groups/${group2Id}/not_in_group/resources/Protocol`)
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                assert.equal(res.body.protocols.length, 1);
                done();
            })
    })

    it('create resource in group1(not exist) ', function (done) {
        cli.post(`/resource_groups/${group1Id}/resources`)
            .send({
                resources: [{
                    type: models.ResourceType.RSkeys.Protocol,
                    key: protocol2.id
                }]
            })
            .expect(400, function (err) {
                if (err) {
                    return done(err);
                }
                done()
            })
    })

    it('create resource in group2(exist) ', function (done) {
        cli.post(`/resource_groups/${group2Id}/resources`)
            .send({
                resources: [{
                    type: models.ResourceType.RSkeys.Protocol,
                    key: protocol1.id
                }]
            })
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                cli.get(`/resource_groups/${group2Id}/resources`)
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        resource1Id = res.body.resources[0].id;
                        assert.equal(res.body.resources.length, 3);
                        done();
                    });
            })
    })

    it('update resource in group2(exist) ', function (done) {
        cli.put(`/resource_groups/${group2Id}/resources/${resource1Id}`)
            .send({
                type: models.ResourceType.RSkeys.Protocol,
                key: protocol1.id
            })
            .expect(204, function (err, res) {
                if (err) {
                    return done(err);
                }
                cli.get(`/resource_groups/${group2Id}/resources`)
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        assert.equal(res.body.resources.length, 3);
                        done();
                    });
            })
    })

    it('find resource not in group2 after create', function (done) {
        cli.get(`/resource_groups/${group2Id}/not_in_group/resources/Protocol`)
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                assert.equal(res.body.protocols.length, 0);
                done();
            })
    })

    it('delete resource in group2(exist) ', function (done) {
        cli.delete(`/resource_groups/${group2Id}/resources?ids=${resource1Id}`)
            .expect(204, function (err, res) {
                if (err) {
                    return done(err);
                }
                cli.get(`/resource_groups/${group2Id}/resources`)
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        assert.equal(res.body.resources.length, 2);
                        done();
                    });
            })
    })

    it('find resource not in group2 after delete', function (done) {
        cli.get(`/resource_groups/${group2Id}/not_in_group/resources/Protocol`)
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                assert.equal(res.body.protocols.length, 1);
                done();
            })
    })

    it('delete resource in group1(no exist) ', function (done) {
        cli.delete(`/resource_groups/${group1Id}/resources/${resource1Id}`)
            .expect(404, function (err, res) {
                if (err) {
                    return done(err);
                }
                done()
            })
    })

    it('test limit', async function () {
        let condition = {
            where: {
                createBy: user.id,
            },
            limit: 4,
            offset: 0,
            order: [
                ['createdAt', 'DESC']
            ]
        };
        let rsGroup = await models.ResourceGroup.findAndCountAll(condition);
        let rsGroupWithRs = await models.ResourceGroup.findAndCountAll({
            where: {
                createBy: user.id,
            },
            include: [{
                model: models.Resource,
                as: 'resources'
            }],
            limit: 4,
            offset: 0,
            distinct: true,
            order: [
                ['createdAt', 'DESC']
            ]
        });
        assert.equal(rsGroup.count, rsGroupWithRs.count);
    })

    // it('test include without association', async function () {
    //     let condition = {
    //         include: [
    //             {
    //                 association: new dc.ORM.Association.HasMany(models.ProtocolMeta, models.Resource, { as: 'resources', foreignKey: 'key' })
    //             }
    //         ]
    //     };
    //     let resources = await models.ProtocolMeta.findAndCountAll(condition);
    // })

    it('test sub query in where', async function () {
        const Model = require('sequelize/lib/model')
        let rsCondition = {
            attributes: ['key'],
            where: {
                type: 'Protocol'
            },
            include: [{
                model: models.ResourceGroup,
                attributes: [],
                as: 'resourceGroup'
            }]
        };
        Model._validateIncludedElements.bind(models.Resource)(rsCondition);
        const filterQuery = models.Resource.QueryGenerator.selectQuery('Resource', rsCondition, models.Resource).slice(0, -1);
        console.log(filterQuery);
        let condition = {
            where: {
                id: {
                    $notIn: dc.orm.literal(`(${filterQuery})`)
                }
            }
        };
        let resources = await models.ProtocolMeta.findAndCountAll(condition);
    })
});