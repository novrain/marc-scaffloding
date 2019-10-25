/**
 * Created by rain on 2017/2/21.
 */
import client from 'supertest';
import chai, { assert, expect } from 'chai';

import scaffold from '@iota-cn/svc-scaffolding';

import options from './config';

const should = chai.should();

describe("iota authorization user group test", function () {
    this.timeout(10000);
    options.port = 2221;
    let app = scaffold(options);
    let cli = client.agent(app.server);
    let dc = app.iota.dc;
    let models = dc.models;
    let parentUser, subUser1, subUser2, subUser3, invitedUser1, invitedUser2;
    let group1Id, group2Id;
    let groupUser1Id;
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
    });

    after(function () {
        app.server.close();
    });

    it('signin', function (done) {
        cli
            .post('/signin')
            .send({
                username: 'abc',
                password: '123456'
            })
            .expect(200, done)
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
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                group1Id = res.body.id;
                assert.equal(res.body.name, 'group1');
                cli.get(`/user_groups/${group1Id}/users?limit=20`)
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        assert.equal(res.body.users[0].username, '');
                        assert.equal(res.body.users.length, 3);
                        done();
                    });
            })
    })

    it('update user group', function (done) {
        cli.put(`/user_groups/${group1Id}`)
            .send({
                name: 'changeNameGroup1',
                desc: 'changeDescGroup1',
            })
            .expect(204, function (err) {
                if (err) {
                    return done(err);
                }
                cli.get(`/user_groups?limit=20`)
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        assert.equal(res.body.userGroups[0].name, 'changeNameGroup1');
                        assert.equal(res.body.userGroups[0].desc, 'changeDescGroup1');
                        done();
                    });
            })
    })

    it('update one item(name) user group', function (done) {
        cli.put(`/user_groups/${group1Id}`)
            .send({
                name: 'chgagain',
            })
            .expect(204, function (err) {
                if (err) {
                    return done(err);
                }
                cli.get('/user_groups?limit=20')
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        assert.equal(res.body.userGroups[0].name, 'chgagain');
                        done();
                    });
            })
    })

    it('update user group when id is wrong', function (done) {
        cli.put(`/user_groups/48f0ad36-bf0d-4e15-a122-b348da053530`)
            .send({
                name: 'changeNameGroup1',
            })
            .expect(404, function (err) {
                if (err) {
                    return done(err);
                }
                cli.get('/user_groups/48f0ad36-bf0d-4e15-a122-b348da053530')
                    .expect(404, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        cli.get('/user_groups')
                            .expect(200, function (err, res) {
                                if (err) {
                                    return done(err);
                                }
                                assert.equal(res.body.userGroups[0].name, 'chgagain');
                                done();
                            });
                    });
            })
    })

    it('delete user group when id is wrong', function (done) {
        cli.delete(`/user_groups/48f0ad36-bf0d-4e15-a122-b348da053530`)
            .expect(404, function (err) {
                if (err) {
                    return done(err);
                }
                cli.get('/user_groups?limit=20')
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        assert.equal(res.body.total, 1);
                        done();
                    });
            })
    })

    it('delete user group1', function (done) {
        cli.delete(`/user_groups/${group1Id}`)
            .expect(204, function (err) {
                if (err) {
                    return done(err);
                }
                cli.get('/user_groups?limit=20')
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        assert.equal(res.body.total, 0);
                        done();
                    });
            })
    })

    it('create another user group with some users', function (done) {
        cli.post('/user_groups')
            .send({
                name: 'group2',
                desc: 'group2',
                users: [
                    {
                        type: 'Sub',
                        key: subUser3.id
                    },
                    {
                        type: 'Invited',
                        key: 'wang.liang@free-sun.com.cn'
                    }
                ]
            })
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                group2Id = res.body.id;
                cli.get(`/user_groups/${group2Id}/users?limit=20`)
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        assert.equal(res.body.users[1].userId, subUser3.id);
                        assert.equal(res.body.users[0].email, 'wang.liang@free-sun.com.cn');
                        done();
                    });
            })
    })

    it('create user in group1(not exist) ', function (done) {
        cli.post(`/user_groups/${group1Id}/users`)
            .send({
                users: {
                    type: 'Sub',
                    key: 'xxx'
                }
            })
            .expect(404, function (err) {
                if (err) {
                    return done(err);
                }
                done()
            })
    })

    it('create user in group2(exist) ', function (done) {
        cli.post(`/user_groups/${group2Id}/users`)
            .send({
                users: [{
                    type: 'Sub',
                    key: subUser1.id
                }]
            })
            .expect(200, function (err, res) {
                if (err) {
                    return done(err);
                }
                cli.get(`/user_groups/${group2Id}/users?limit=20`)
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        console.log(res.body.users)
                        groupUser1Id = res.body.users[0].id;
                        assert.equal(res.body.users.length, 3);
                        done();
                    });
            })
    });

    it('disable user in group2(exist)', function (done) {
        cli.post(`/user_groups/${group2Id}/users/disable`)
            .send({
                ids: [groupUser1Id]
            })
            .expect(204, function (err, res) {
                if (err) {
                    return done(err);
                }
                cli.get(`/user_groups/${group2Id}/users/${groupUser1Id}?limit=20`)
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        assert.equal(res.body.enable, false);
                        done();
                    });
            })
    })

    it('enable user in group2(exist)', function (done) {
        cli.post(`/user_groups/${group2Id}/users/enable`)
            .send({
                ids: [groupUser1Id]
            })
            .expect(204, function (err, res) {
                if (err) {
                    return done(err);
                }
                cli.get(`/user_groups/${group2Id}/users?limit=20`)
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        console.log(groupUser1Id)
                        console.log(res.body)
                        assert.equal(res.body.users[0].enable, true);
                        done();
                    });
            })
    })

    it('delete user in group2(exist) ', function (done) {
        cli.delete(`/user_groups/${group2Id}/users/${groupUser1Id}`)
            .expect(204, function (err, res) {
                if (err) {
                    return done(err);
                }
                cli.get(`/user_groups/${group2Id}/users?limit=20`)
                    .expect(200, function (err, res) {
                        if (err) {
                            return done(err);
                        }
                        assert.equal(res.body.users.length, 2);
                        done();
                    });
            })
    });

    it('delete user in group1(no exist) ', function (done) {
        cli.delete(`/user_groups/${group1Id}/users?ids=${groupUser1Id}`)
            .expect(404, function (err, res) {
                if (err) {
                    return done(err);
                }
                done()
            })
    });
    it('validate email already in group', function (done) {
        cli.get('/user_groups/' + group2Id + '/emails/validate?email=wang.liang@free-sun.com.cn').expect(400, done);
    });

    it('validate email in group', function (done) {
        cli.get('/user_groups/' + group2Id + '/emails/validate?email=wang.liang@theiota.cn').expect(204, done);
    });

    it('validate email(valid and exist)', function (done) {
        cli.get('/user_groups/emails/validate?email=wang.liang@free-sun.com.cn').expect(204, done);
    });

    it('validate email(valid but not exist)', function (done) {
        cli.get('/user_groups/emails/validate?email=wang.liang1@free-sun.com.cn').expect(400, done);
    });

    it('validate email(invalid)', function (done) {
        cli.get('/user_groups/' + group2Id + '/emails/validate?email=wang.liangtheiota.cn').expect(400, done);
    });

    it('find sub user not in group', function (done) {
        cli.get('/user_groups/' + group2Id + '/not_in_group/users?limit=20')
            .expect(200, function (err, res) {
                if (err) {
                    return done(err)
                }
                let usersNotInGroup = res.body.users;
                assert.equal(usersNotInGroup.length, 2);
                done();
            });
    });

});