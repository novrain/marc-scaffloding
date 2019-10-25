import client from 'supertest';
import chai, { assert, expect } from 'chai';

import scaffold from '@iota-cn/svc-scaffolding';
import Mmw from '@iota-cn/svc-mmw';

import config from './config';

const should = chai.should();

describe('iota user test >', function () {
    this.timeout(10000);
    config.port = 5003;
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
        await models.User.create({ id: '1', username: 'u1', password: '123456', email: '1@2.com', isAdmin: true });
        await models.User.create({ id: '2', username: 'u2', password: '123456', email: '2@2.com' });
        await models.User.create({ id: '3', username: 'u3', password: '123456', email: '3@2.com' });
        await models.User.create({ id: '4', username: 'u4', password: '123456', email: '4@2.com', type: 'Sub' });
        await models.User.create({ id: '5', username: 'u5', password: '123456', email: '5@2.com', type: 'Sub' });
        await models.SubUser.create({ userId: '4', parentId: '2' })
        await models.SubUser.create({ userId: '5', parentId: '2' })
        await models.SubUser.create({ userId: '2', parentId: '1' })
        await models.SubUser.create({ userId: '3', parentId: '1' })
        //Menus
        await models.Menu.create({ id: '0', name: 'MRoot', key: 'MRoot' });
        await models.Menu.create({ id: '1', name: 'M1', key: 'M1', parentId: '0' });
        await models.Menu.create({ id: '1.1', name: 'M1.1', key: 'M1.1', parentId: '1' });
        await models.Menu.create({ id: '1.2', name: 'M1.2', key: 'M1.2', parentId: '1' });
        await models.Menu.create({ id: '1.3', name: 'M1.3', key: 'M1.3', parentId: '1' });
        await models.Menu.create({ id: '2', name: 'M2', key: 'M2', parentId: '0' });
        await models.Menu.create({ id: '2.1', name: 'M2.1', key: 'M2.1', parentId: '2' });
        await models.Menu.create({ id: '2.2', name: 'M2.2', key: 'M2.2', parentId: '2' });
        await models.Menu.create({ id: '2.3', name: 'M2.3', key: 'M2.3', parentId: '2' });
        await models.Menu.create({ id: '3', name: 'M3', key: 'M3', parentId: '0' });
        await models.Menu.create({ id: '3.1', name: 'M3.1', key: 'M3.1', parentId: '3' });
        await models.Menu.create({ id: '3.2', name: 'M3.2', key: 'M3.2', parentId: '3' });
        await models.Menu.create({ id: '3.3', name: 'M3.3', key: 'M3.3', parentId: '3' });
        //Operations
        await models.Operation.create({ id: '0', name: 'ORoot', key: 'ORoot' });
        await models.Operation.create({ id: '1', name: 'O1', key: 'O1', parentId: '0' });
        await models.Operation.create({ id: '1.1', name: 'O1.1', key: 'O1.1', parentId: '1' });
        await models.Operation.create({ id: '1.2', name: 'O1.2', key: 'O1.2', parentId: '1' });
        await models.Operation.create({ id: '1.3', name: 'O1.3', key: 'O1.3', parentId: '1' });
        await models.Operation.create({ id: '2', name: 'O2', key: 'O2', parentId: '0' });
        await models.Operation.create({ id: '2.1', name: 'O2.1', key: 'O2.1', parentId: '2' });
        await models.Operation.create({ id: '2.2', name: 'O2.2', key: 'O2.2', parentId: '2' });
        await models.Operation.create({ id: '2.3', name: 'O2.3', key: 'O2.3', parentId: '2' });
        await models.Operation.create({ id: '3', name: 'O3', key: 'O3', parentId: '0' });
        await models.Operation.create({ id: '3.1', name: 'O3.1', key: 'O3.1', parentId: '3' });
        await models.Operation.create({ id: '3.2', name: 'O3.2', key: 'O3.2', parentId: '3' });
        await models.Operation.create({ id: '3.3', name: 'O3.3', key: 'O3.3', parentId: '3' });
        //Org
        await models.Organization.create({ id: '0', name: 'ORoot', key: 'ORoot' });
        await models.Organization.create({ id: '1', name: 'O1', key: 'O1', parentId: '0' });
        await models.Organization.create({ id: '1.1', name: 'O1.1', key: 'O1.1', parentId: '1' });
        await models.Organization.create({ id: '1.2', name: 'O1.2', key: 'O1.2', parentId: '1' });
        await models.Organization.create({ id: '1.3', name: 'O1.3', key: 'O1.3', parentId: '1' });
        await models.Organization.create({ id: '2', name: 'O2', key: 'O2', parentId: '0', belongTo: '2' });
        await models.Organization.create({ id: '2.1', name: 'O2.1', key: 'O2.1', parentId: '2', belongTo: '2' });
        await models.Organization.create({ id: '2.2', name: 'O2.2', key: 'O2.2', parentId: '2', belongTo: '2' });
        await models.Organization.create({ id: '2.3', name: 'O2.3', key: 'O2.3', parentId: '2', belongTo: '4' });
        await models.Organization.create({ id: '3', name: 'O3', key: 'O3', parentId: '0', belongTo: '3' });
        await models.Organization.create({ id: '3.1', name: 'O3.1', key: 'O3.1', parentId: '3', belongTo: '3' });
        await models.Organization.create({ id: '3.2', name: 'O3.1', key: 'O3.1', parentId: '3', belongTo: '3' });
        await models.Organization.create({ id: '3.3', name: 'O3.2', key: 'O3.2', parentId: '3', belongTo: '3' });
        //Position
        await models.Position.create({ id: '0', name: 'PRoot', key: 'PRoot' });
        await models.Position.create({ id: '1', name: 'P1', key: 'P1', parentId: '0' });
        await models.Position.create({ id: '1.1', name: 'P1.1', key: 'P1.1', parentId: '1' });
        await models.Position.create({ id: '1.2', name: 'P1.2', key: 'P1.2', parentId: '1' });
        await models.Position.create({ id: '1.3', name: 'P1.3', key: 'P1.3', parentId: '1' });
        await models.Position.create({ id: '2', name: 'P2', key: 'P2', parentId: '0', belongTo: '2' });
        await models.Position.create({ id: '2.1', name: 'P2.1', key: 'P2.1', parentId: '2', belongTo: '2' });
        await models.Position.create({ id: '2.2', name: 'P2.2', key: 'P2.2', parentId: '2', belongTo: '2' });
        await models.Position.create({ id: '2.3', name: 'P2.3', key: 'P2.3', parentId: '2', belongTo: '4' });
        await models.Position.create({ id: '3', name: 'P3', key: 'P3', parentId: '0' });
        await models.Position.create({ id: '3.1', name: 'P3.1', key: 'P3.1', parentId: '3' });
        await models.Position.create({ id: '3.2', name: 'P3.2', key: 'P3.1', parentId: '3' });
        await models.Position.create({ id: '3.3', name: 'P3.2', key: 'P3.2', parentId: '3' });
        //Role
        await models.Role.create({ id: '1', name: 'Role1' })
        await models.Role.create({ id: '2', name: 'Role2', belongTo: '2' })
        await models.Role.create({ id: '3', name: 'Role3' })
        await models.Role.create({ id: '4', name: 'Role4', belongTo: '4' })
        await models.Role.create({ id: '5', name: 'Role5', belongTo: '4' })
        //UserRole
        await models.UserRole.create({ userId: '5', roleId: '2' })
        await models.UserRole.create({ userId: '4', roleId: '2' })
        await models.UserRole.create({ userId: '3', roleId: '3' })
        await models.UserRole.create({ userId: '3', roleId: '1' })
        //
        await models.UserOrganization.create({ userId: '2', organizationId: '2' })
        await models.UserOrganization.create({ userId: '4', organizationId: '2.3' })
        await models.UserPosition.create({ userId: '3', positionId: '3' })
        await models.UserPosition.create({ userId: '4', positionId: '2.3' })
        //
        await models.OrganizationRole.create({ roleId: '2', organizationId: '2' })
        await models.OrganizationRole.create({ roleId: '1', organizationId: '3' })
        await models.OrganizationRole.create({ roleId: '4', organizationId: '2.3' })
        await models.OrganizationRole.create({ roleId: '5', organizationId: '2.3' })
        await models.PositionRole.create({ roleId: '1', positionId: '3' })
        await models.PositionRole.create({ roleId: '4', positionId: '2.3' })
        await models.PositionRole.create({ roleId: '4', positionId: '2' })
        await models.PositionRole.create({ roleId: '5', positionId: '2.3' })

        //Role  menu
        await models.RoleMenu.create({ menuId: '2', roleId: '2' })
        await models.RoleMenu.create({ menuId: '2.1', roleId: '2' })
        await models.RoleMenu.create({ menuId: '2.2', roleId: '2' })
        await models.RoleMenu.create({ menuId: '2.3', roleId: '2' })

        await models.RoleMenu.create({ menuId: '3', roleId: '3' })
        await models.RoleMenu.create({ menuId: '3.1', roleId: '3' })
        await models.RoleMenu.create({ menuId: '3.2', roleId: '3' })
        await models.RoleMenu.create({ menuId: '3.3', roleId: '3' })

        await models.RoleMenu.create({ menuId: '1', roleId: '1' })
        await models.RoleMenu.create({ menuId: '1.1', roleId: '1' })
        await models.RoleMenu.create({ menuId: '1.2', roleId: '1' })
        await models.RoleMenu.create({ menuId: '1.3', roleId: '1' })

        //Role operation 
        await models.RoleOperation.create({ operationId: '2', roleId: '2' })
        await models.RoleOperation.create({ operationId: '2.1', roleId: '2' })
        await models.RoleOperation.create({ operationId: '2.2', roleId: '2' })
        await models.RoleOperation.create({ operationId: '2.3', roleId: '2' })

        await models.RoleOperation.create({ operationId: '3', roleId: '3' })
        await models.RoleOperation.create({ operationId: '3.1', roleId: '3' })
        await models.RoleOperation.create({ operationId: '3.2', roleId: '3' })
        await models.RoleOperation.create({ operationId: '3.3', roleId: '3' })

        await models.RoleOperation.create({ operationId: '1', roleId: '1' })
        await models.RoleOperation.create({ operationId: '1.1', roleId: '1' })
        await models.RoleOperation.create({ operationId: '1.2', roleId: '1' })
        await models.RoleOperation.create({ operationId: '1.3', roleId: '1' })

    });

    describe("auth model test.", function () {
        it('basic', function (done) {
            request
                .get('/notfound')
                .expect(404, done);
        });

        describe("/authorizations/menus", function () {
            it("u1's menus ( is an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/menus')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.menus.length, 13)
                                done();
                            })
                    })
            });

            it("u2's menus ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/menus')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.menus.length, 5)
                                done();
                            })
                    })
            });

            it("u3's menus ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u3', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/menus')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.menus.length, 9)
                                done();
                            })
                    })
            });
        });

        describe("/authorizations/operations", function () {
            it("u1's operations ( is an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/operations')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.operations.length, 13)
                                done();
                            })
                    })
            });

            it("u2's operations ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/operations')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.operations.length, 5)
                                done();
                            })
                    })
            });

            it("u3's operations ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u3', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/operations')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.operations.length, 9)
                                done();
                            })
                    })
            });
        })

        describe("/authorizations/users/:userId/menus/:id?", function () {
            it("u1 query u2's menus ( an administrator query another user)", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/users/2/menus')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.menus.length, 5)
                                done();
                            })
                    })
            });

            it("u2 query u3's menus ( an normal user query another user which is not his sub user.)", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/users/3/menus')
                            .expect(403, done)
                    })
            });

            it("u2 query u4's menus ( an normal user query another user which is his sub user.)", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/users/4/menus')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.menus.length, 5)
                                done();
                            })
                    })
            });


            it("u3's menus ( not an administrator, query its self )", function (done) {
                request.post('/signin')
                    .send({ username: 'u3', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/users/3/menus')
                            .expect(403, done)
                    })
            });
        })

        describe("/authorizations/users/:userId/operations/:id?", function () {
            it("u1 query u2's operations ( an administrator query another user)", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/users/2/operations')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.operations.length, 5)
                                done();
                            })
                    })
            });

            it("u2 query u3's operations ( an normal user query another user which is not his sub user.)", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/users/3/operations')
                            .expect(403, done)
                    })
            });

            it("u2 query u4's operations ( an normal user query another user which is his sub user.)", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/users/4/operations')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.operations.length, 5)
                                done();
                            })
                    })
            });


            it("u3's operations ( not an administrator, query its self )", function (done) {
                request.post('/signin')
                    .send({ username: 'u3', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/users/3/operations')
                            .expect(403, done)
                    })
            });
        })

        describe("/authorizations/organizations", function () {
            it("u1 query organizations ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/organizations')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.organizations.length, 13)
                                done();
                            })
                    })
            });


            it("u2 query organizations ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/organizations')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.organizations.length, 5)
                                done();
                            })
                    })
            });
        })

        describe("/authorizations/positions", function () {
            it("u1 query positions ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/positions')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.positions.length, 13)
                                done();
                            })
                    })
            });


            it("u2 query positions ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/positions')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.positions.length, 5)
                                done();
                            })
                    })
            });
        })

        describe("/authorizations/organizations/:organizationId/users/:id?", function () {
            it("u1 query organization user ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/organizations/2/users')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.users.length, 1)
                                done();
                            })
                    })
            });

            it("u2 query organization user ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/organizations/2/users')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.users.length, 0)
                                done();
                            })
                    })
            });

            it("u2 query organization user ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/organizations/2.3/users')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.users.length, 1)
                                done();
                            })
                    })
            });
        })

        describe("/authorizations/positions/:positionId/users/:id?", function () {
            it("u1 query position user ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/positions/3/users')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.users.length, 1)
                                done();
                            })
                    })
            });

            it("u2 query position user ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/positions/2/users')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.users.length, 0)
                                done();
                            })
                    })
            });

            it("u2 query position user ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/positions/2.3/users')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.users.length, 1)
                                done();
                            })
                    })
            });
        })

        describe("/authorizations/users", function () {
            it("u1 query user ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/users')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.users.length, 4)
                                done();
                            })
                    })
            });

            it("u2 query user ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/users')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.users.length, 2)
                                done();
                            })
                    })
            });
        })

        describe("/authorizations/positions/:positionId/roles/:id?", function () {
            it("u1 query roles assigned to position ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/positions/3/roles')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.roles.length, 1)
                                done();
                            })
                    })
            });

            it("u4 query roles assigned to position ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u4', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/positions/2.3/roles')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.roles.length, 2)
                                done();
                            })
                    })
            });
        })

        describe("/authorizations/organizations/:organizationsId/roles/:id?", function () {
            it("u1 query roles assigned to organization ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/organizations/3/roles')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.roles.length, 1)
                                done();
                            })
                    })
            });

            it("u4 query roles assigned to organization ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u4', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/organizations/2.3/roles')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.roles.length, 2)
                                done();
                            })
                    })
            });
        })

        describe("/authorizations/roles", function () {
            it("u1 query roles ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/roles')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.roles.length, 5)
                                done();
                            })
                    })
            });

            it("u4 query roles ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u4', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/roles')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.roles.length, 2)
                                done();
                            })
                    })
            });

            it("u1 query role's menus ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/roles/2/menus')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.menus.length, 5)
                                done();
                            })
                    })
            });

            it("u2 query role's menus ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/roles/2/menus')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.menus.length, 5)
                                done();
                            })
                    })
            });
        })

        describe("/authorizations/roles/:roleId/organizations/:id?", function () {
            it("u1 query organizations in role ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/roles/1/organizations')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.organizations.length, 2)
                                done();
                            })
                    })
            });

            it("u4 query organizations in role ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u4', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/roles/4/organizations')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.organizations.length, 3)
                                done();
                            })
                    })
            });
        })

        describe("/authorizations/roles/:roleId/positions/:id?", function () {
            it("u1 query positions in role ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/roles/4/positions')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.positions.length, 3)
                                done();
                            })
                    })
            });

            it("u4 query positions in role ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u4', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/roles/4/positions')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.positions.length, 3)
                                done();
                            })
                    })
            });
        })

        describe("/authorizations/roles/:roleId/users/:id?", function () {
            it("u1 query users in role ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/roles/1/users')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.users.length, 1)
                                done();
                            })
                    })
            });

            it("u2 query users in role ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/roles/2/users')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.users.length, 2)
                                done();
                            })
                    })
            });
        })

        describe("/authorizations/users/:userId/roles/:id?", function () {
            it("u1 query roles bind to user ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/users/3/roles')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.roles.length, 2)
                                done();
                            })
                    })
            });

            it("u2 query roles bind to user ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/users/4/roles')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.roles.length, 1)
                                done();
                            })
                    })
            });
        })

        describe("/authorizations/users/:userId/organization/:id?", function () {
            it("u1 query organizations bind to user ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/users/2/organizations')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.organizations.length, 1)
                                done();
                            })
                    })
            });

            it("u2 query organizations bind to user ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/users/4/organizations')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.organizations.length, 1)
                                done();
                            })
                    })
            });
        })

        describe("/authorizations/users/:userId/positions/:id?", function () {
            it("u1 query positions bind to user ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/users/3/positions')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.positions.length, 1)
                                done();
                            })
                    })
            });

            it("u2 query positions bind to user ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/users/4/positions')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.positions.length, 1)
                                done();
                            })
                    })
            });
        })

        describe("/authorizations/users/:userId/positions/:id?", function () {
            it("u1 query user not in organization ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/organizations/3/not_in/users')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.users.length, 4)
                                done();
                            })
                    })
            });

            it("u2 query user not in organization ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/organizations/2/not_in/users')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.users.length, 2)
                                done();
                            })
                    })
            });

            it("u1 query user not in position ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/positions/3/not_in/users')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.users.length, 3)
                                done();
                            })
                    })
            });

            it("u2 query user not in position ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/positions/2/not_in/users')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.users.length, 2)
                                done();
                            })
                    })
            });

            it("u1 query user not in role ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/roles/3/not_bind/users')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.users.length, 3)
                                done();
                            })
                    })
            });

            it("u2 query user not in role ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/roles/2/not_bind/users')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.users.length, 0)
                                done();
                            })
                    })
            });

            it("u1 query role not assigned to organization ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/organizations/3/not_assigned/roles')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.roles.length, 4)
                                done();
                            })
                    })
            });

            it("u2 query role not assigned to organization ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/organizations/2/not_assigned/roles')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.roles.length, 2)
                                done();
                            })
                    })
            });

            it("u1 query role not assigned to position ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/positions/3/not_assigned/roles')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.roles.length, 4)
                                done();
                            })
                    })
            });

            it("u2 query role not assigned to position ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/positions/2/not_assigned/roles')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.roles.length, 2)
                                done();
                            })
                    })
            });

            it("u1 query position not bind to role ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/roles/1/not_bind/positions')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.positions.length, 12)
                                done();
                            })
                    })
            });

            it("u2 query position not bind to role ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/roles/2/not_bind/positions')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.positions.length, 4)
                                done();
                            })
                    })
            });

            it("u1 query organization not bind to role ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/roles/1/not_bind/organizations')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.organizations.length, 12)
                                done();
                            })
                    })
            });

            it("u2 query organization not bind to role ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/roles/2/not_bind/organizations')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.organizations.length, 3)
                                done();
                            })
                    })
            });

            it("u1 query role not assign to user ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/users/2/not_assigned/roles')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.roles.length, 5)
                                done();
                            })
                    })
            });

            it("u2 query role not assign to user ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/users/4/not_assigned/roles')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.roles.length, 2)
                                done();
                            })
                    })
            });

            it("u1 query organization not assign to user ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/users/2/not_assigned/organizations')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.organizations.length, 12)
                                done();
                            })
                    })
            });

            it("u2 query organization not assign to user ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/users/4/not_assigned/organizations')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.organizations.length, 3)
                                done();
                            })
                    })
            });

            it("u1 query position not assign to user ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/users/2/not_assigned/positions')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.positions.length, 13)
                                done();
                            })
                    })
            });

            it("u2 query position not assign to user ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/users/4/not_assigned/positions')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.positions.length, 3)
                                done();
                            })
                    })
            });
        })

        describe("/authorizations/organizations post", function () {
            it("u1 create organization ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.post('/authorizations/organizations')
                            .send({
                                name: 'c1',
                                id: 'c1'
                            })
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.id, 'c1')
                                done();
                            })
                    })
            });

            it("u2 create organization ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.post('/authorizations/organizations')
                            .send({
                                name: 'c2',
                                id: 'c2'
                            })
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.id, 'c2')
                                done();
                            })
                    })
            });

            it("u2 create organization ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.post('/authorizations/organizations')
                            .send({
                                name: 'c3',
                                id: 'c3',
                                parentId: 'c1'
                            })
                            .expect(403, done)
                    })
            });

            it("u2 create organization ( not an administrator )", function (done) {
                models.UserOrganization.create({ userId: '2', organizationId: 'c1' }).then(() => {
                    request.post('/signin')
                        .send({ username: 'u2', password: '123456' })
                        .expect(200, function (err, res) {
                            if (err) {
                                return done(err);
                            }
                            request.post('/authorizations/organizations')
                                .send({
                                    name: 'c3',
                                    id: 'c3',
                                    parentId: 'c1'
                                })
                                .expect(200, function (err, res) {
                                    if (err) {
                                        return done(err);
                                    }
                                    assert.equal(res.body.id, 'c3')
                                    done();
                                })
                        })
                })
            });
        })

        describe("/authorizations/organizations put", function () {
            it("u1 update organization ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.put('/authorizations/organizations/c1')
                            .send({
                                name: 'c1',
                                desc: 'c1'
                            })
                            .expect(204, done)
                    })
            });

            it("u2 update organization ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.put('/authorizations/organizations/c2')
                            .send({
                                name: 'c2',
                                desc: 'c2'
                            })
                            .expect(204, done)
                    })
            });

            it("u2 update organization ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.put('/authorizations/organizations/c1')
                            .send({
                                name: 'c1',
                                desc: 'c11'
                            })
                            .expect(403, done)
                    })
            });
        })

        describe("/authorizations/positions post", function () {
            it("u1 create position ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.post('/authorizations/positions')
                            .send({
                                name: 'p1',
                                id: 'p1'
                            })
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.id, 'p1')
                                done();
                            })
                    })
            });

            it("u2 create position ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.post('/authorizations/positions')
                            .send({
                                name: 'p2',
                                id: 'p2'
                            })
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.id, 'p2')
                                done();
                            })
                    })
            });

            it("u2 create position ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.post('/authorizations/positions')
                            .send({
                                name: 'p3',
                                id: 'p3',
                                parentId: 'p1'
                            })
                            .expect(403, done)
                    })
            });

            it("u2 create position ( not an administrator )", function (done) {
                models.UserPosition.create({ userId: '2', positionId: 'p1' }).then(() => {
                    request.post('/signin')
                        .send({ username: 'u2', password: '123456' })
                        .expect(200, function (err, res) {
                            if (err) {
                                return done(err);
                            }
                            request.post('/authorizations/positions')
                                .send({
                                    name: 'p3',
                                    id: 'p3',
                                    parentId: 'p1'
                                })
                                .expect(200, function (err, res) {
                                    if (err) {
                                        return done(err);
                                    }
                                    assert.equal(res.body.id, 'p3')
                                    done();
                                })
                        })
                })
            });
        })

        describe("/authorizations/positions put", function () {
            it("u1 update position ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.put('/authorizations/positions/p1')
                            .send({
                                name: 'p1',
                                desc: 'p1'
                            })
                            .expect(204, done)
                    })
            });

            it("u2 update position ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.put('/authorizations/positions/p2')
                            .send({
                                name: 'p2',
                                desc: 'p2'
                            })
                            .expect(204, done)
                    })
            });

            it("u2 update position ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.put('/authorizations/positions/p1')
                            .send({
                                name: 'p1',
                                desc: 'p11'
                            })
                            .expect(403, done)
                    })
            });
        })

        describe("/authorizations/roles post", function () {
            it("u1 create role ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.post('/authorizations/roles')
                            .send({
                                name: 'r1',
                                id: 'r1'
                            })
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.id, 'r1')
                                done();
                            })
                    })
            });

            it("u2 create role ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.post('/authorizations/roles')
                            .send({
                                name: 'r2',
                                id: 'r2'
                            })
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.id, 'r2')
                                done();
                            })
                    })
            });
        })

        describe("/authorizations/roles put", function () {
            it("u1 update role ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.put('/authorizations/roles/r1')
                            .send({
                                name: 'r1',
                                desc: 'r1'
                            })
                            .expect(204, done)
                    })
            });

            it("u2 update role ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.put('/authorizations/roles/r2')
                            .send({
                                name: 'r2',
                                desc: 'r2'
                            })
                            .expect(204, done)
                    })
            });

            it("u2 update role ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.put('/authorizations/roles/r1')
                            .send({
                                name: 'r1',
                                desc: 'r11'
                            })
                            .expect(403, done)
                    })
            });
        })

        describe("/authorizations/organizations/:organizationId/roles bind unbind", function () {
            it("u1 bind position ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.post('/authorizations/positions/p1/roles')
                            .send({
                                ids: ['r1', 'r2']
                            })
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.length, 2)
                                done()
                            })
                    })
            });

            it("u1 bind position ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.delete('/authorizations/positions/p1/roles?ids=r1,r2')
                            .expect(204, done)
                    })
            });

            it("u2 update position ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.post('/authorizations/positions/p1/roles')
                            .send({
                                ids: ['r1']
                            })
                            .expect(403, done)
                    })
            });

            it("u2 update position ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.post('/authorizations/positions/p2/roles')
                            .send({
                                ids: ['r2']
                            })
                            .expect(200, done)
                    })
            });

            it("u2 update position ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.delete('/authorizations/positions/p2/roles?ids=r2')
                            .expect(204, done)
                    })
            });

        })

        describe("/authorizations/roles assign / remove menus", function () {
            it("u1 assign role ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.post('/authorizations/roles/r1/menus')
                            .send({
                                ids: ['3', '3.1', '3.2']
                            })
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err)
                                }
                                assert.equal(res.body.length, 3)
                                done();
                            })
                    })
            });

            it("u2 assign role ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.post('/authorizations/roles/r2/menus')
                            .send({
                                ids: ['2']
                            })
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err)
                                }
                                assert.equal(res.body.length, 1)
                                done();
                            })
                    })
            });
        })

        describe("/authorizations/roles assign / remove operations", function () {
            it("u1 assign role ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.post('/authorizations/roles/r1/operations')
                            .send({
                                ids: ['3', '3.1', '3.2']
                            })
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err)
                                }
                                assert.equal(res.body.length, 3)
                                done();
                            })
                    })
            });

            it("u1 remove  ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.delete('/authorizations/roles/r1/operations?ids=3,3.1,3.2')
                            .expect(204, done)
                    })
            });

            it("u2 assign role ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.post('/authorizations/roles/r2/operations')
                            .send({
                                ids: ['2']
                            })
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err)
                                }
                                assert.equal(res.body.length, 1)
                                done();
                            })
                    })
            });

            it("u2 remove ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.delete('/authorizations/roles/r2/operations?ids=2,2.1')
                            .expect(204, done)
                    })
            });

            it("u2 remove ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.delete('/authorizations/roles/r2/operations?ids=2')
                            .expect(204, done)
                    })
            });
        })

        describe("/authorizations/roles assign / remove organization", function () {
            it("u1 assign role ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.post('/authorizations/roles/r1/organizations')
                            .send({
                                ids: ['3', '3.1', '3.2']
                            })
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err)
                                }
                                assert.equal(res.body.length, 3)
                                done();
                            })
                    })
            });

            it("u1 remove  ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.delete('/authorizations/roles/r1/organizations?ids=3,3.1,3.2')
                            .expect(204, done)
                    })
            });

            it("u2 assign role ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.post('/authorizations/roles/r2/organizations')
                            .send({
                                ids: ['2', '2.1', '2.2']
                            })
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err)
                                }
                                assert.equal(res.body.length, 3)
                                done();
                            })
                    })
            });

            it("u2 remove ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.delete('/authorizations/roles/r2/organizations?ids=2,3.1')
                            .expect(403, done)
                    })
            });

            it("u2 remove ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.delete('/authorizations/roles/r2/operations?ids=2')
                            .expect(204, done)
                    })
            });
        })

        describe("/authorizations/roles assign / remove position", function () {
            it("u1 assign role ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.post('/authorizations/roles/r1/positions')
                            .send({
                                ids: ['3', '3.1', '3.2']
                            })
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err)
                                }
                                assert.equal(res.body.length, 3)
                                done();
                            })
                    })
            });

            it("u1 remove  ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.delete('/authorizations/roles/r1/positions?ids=3,3.1,3.2')
                            .expect(204, done)
                    })
            });

            it("u2 assign role ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.post('/authorizations/roles/r2/positions')
                            .send({
                                ids: ['2', '2.1', '2.2']
                            })
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err)
                                }
                                assert.equal(res.body.length, 3)
                                done();
                            })
                    })
            });

            it("u2 remove ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.delete('/authorizations/roles/r2/positions?ids=2,3.1')
                            .expect(403, done)
                    })
            });

            it("u2 remove ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.delete('/authorizations/roles/r2/positions?ids=2')
                            .expect(204, done)
                    })
            });
        })

        describe("/authorizations/users post / put", function () {
            it("u1 create user ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.post('/authorizations/users')
                            .send({
                                username: 'su1',
                                id: 'su1',
                                password: '123456',
                                mobile: '11111111111',
                                email: '111@2.com',
                                type: models.User.UserTypes.Sub
                            })
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.id, 'su1')
                                done();
                            })
                    })
            });
        })

        describe("/authorizations/organizations delete", function () {
            it("u2 delete organization ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.delete('/authorizations/organizations?ids=c1,c2')
                            .expect(403, done)
                    })
            });

            it("u2 delete organization ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.delete('/authorizations/organizations/c2')
                            .expect(204, done)
                    })
            });

            it("u1 delete organization ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.delete('/authorizations/organizations/c1')
                            .expect(204, done)
                    })
            });

            it("u2 query organization ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/organizations')
                            .expect(200, function (err, res) {
                                if (err) {
                                    done(err)
                                }
                                assert.equal(res.body.organizations.length, 5)
                                done()
                            })
                    })
            });
        })

        describe("/authorizations/positions delete", function () {
            it("u2 delete position ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.delete('/authorizations/positions?ids=p1,p2')
                            .expect(403, done)
                    })
            });

            it("u2 delete position ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.delete('/authorizations/positions/p2')
                            .expect(204, done)
                    })
            });

            it("u1 delete position ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.delete('/authorizations/positions/p1')
                            .expect(204, done)
                    })
            });

            it("u2 query position ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.get('/authorizations/positions')
                            .expect(200, function (err, res) {
                                if (err) {
                                    done(err)
                                }
                                assert.equal(res.body.positions.length, 5)
                                done()
                            })
                    })
            });
        })

        describe("/authorizations/roles delete", function () {
            it("u2 delete role ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.delete('/authorizations/roles/r1')
                            .expect(403, done)
                    })
            });

            it("u2 delete role ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.delete('/authorizations/roles?ids=r2')
                            .expect(204, done)
                    })
            });

            it("u1 delete role ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.delete('/authorizations/roles/r1')
                            .expect(204, done)
                    })
            });
        })

        describe("/authorizations/users update", function () {
            it("u2 update user ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.put('/authorizations/users/u1')
                            .send({
                                email: '1@ddd2.com'
                            })
                            .expect(403, done)
                    })
            });

            it("u2 update user ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.put('/authorizations/users/3')
                            .send({
                                email: '1@ddd2.com'
                            })
                            .expect(403, done)
                    })
            });

            it("u2 update user ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.put('/authorizations/users/4')
                            .send({
                                email: '1@ddd2.com'
                            })
                            .expect(204, done)
                    })
            });

            it("u1 update user ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.put('/authorizations/users/2')
                            .send({
                                email: '2@ddd2.com'
                            })
                            .expect(204, done)
                    })
            });
        })

        describe("/authorizations/users enable/disable", function () {
            it("u2 enable user ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.post('/authorizations/users/enable/1')
                            .expect(403, done)
                    })
            });

            it("u2 enable user ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.post('/authorizations/users/enable/3')
                            .expect(403, done)
                    })
            });

            it("u2 enable user ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.post('/authorizations/users/enable/4')
                            .expect(204, done)
                    })
            });

            it("u1 enable user ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.post('/authorizations/users/enable/2')
                            .expect(204, done)
                    })
            });
            it("u2 disable user ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.post('/authorizations/users/disable/1')
                            .expect(403, done)
                    })
            });

            it("u2 disable user ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.post('/authorizations/users/disable/3')
                            .expect(403, done)
                    })
            });

            it("u2 disable user ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.post('/authorizations/users/disable/4')
                            .expect(204, done)
                    })
            });

            it("u1 disable user ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.post('/authorizations/users/disable/2')
                            .expect(204, done)
                    })
            });
        })

        describe("/authorizations/users delete", function () {
            it("u2 delete user ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.delete('/authorizations/users/u1')
                            .expect(403, done)
                    })
            });

            it("u2 delete user ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.delete('/authorizations/users/3')
                            .expect(403, done)
                    })
            });

            it("u2 delete user ( not an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u2', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.delete('/authorizations/users/4')
                            .expect(204, done)
                    })
            });

            it("u1 delete user ( an administrator )", function (done) {
                request.post('/signin')
                    .send({ username: 'u1', password: '123456' })
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        request.delete('/authorizations/users/2')
                            .expect(204, done)
                    })
            });
        })
    });
});