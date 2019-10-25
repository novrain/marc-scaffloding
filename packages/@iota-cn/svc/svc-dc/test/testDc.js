/**
 * Created by rain on 2016/6/17.
 */
'use strict';

import dc from '../src/index';
import chai from 'chai';
import path from 'path';
chai.should();


describe('Dc test', function () {
    this.timeout(10000);
    let app = {};
    let options = {
        orm: {
            url: "postgres://postgres:ROOT@localhost:5433/iOTA_ut",
            opts: {}
        },
        mqtt: {
            broker: 'mqtt://127.0.0.1:1883',
            cmNotifyTopic: 'cm/notify'
        }
        /*
         ,
         cache:{

         }*/,
        models: [require(path.join(__dirname, 'stub/models')).default],
        instances: {
            'console': {
                orm: {
                    url: "postgres://postgres:ROOT@localhost:5433/iOTA_ut",
                    opts: {}
                },
                mqtt: {
                    broker: 'mqtt://127.0.0.1:1883',
                    cmNotifyTopic: 'cm/notify'
                }
                /*
                 ,
                 cache:{

                 }*/,
                models: [require(path.join(__dirname, 'stub/others')).default]
            }
        }
    };
    dc(app, options);

    it('dc init', function (done) {
        app.iota.should.be.a('object');
        app.iota.dc.should.be.a('object');
        app.iota.dc.orm.should.be.a('object');
        app.iota.dc.instances['console'].should.be.a('object');
        app.iota.dc.instances['console'].orm.should.be.a('object');
        app.iota.dc.instances['default'].should.be.a('object');
        app.iota.dc.instances['default'].orm.should.be.a('object');
        done();
    });


    it('dc create model', function (done) {
        let models = app.iota.dc.models;
        models.User.sync({ force: true }).then(function () {
            // Table created
            models.User.create({
                username: 'John',
                password: 'Hancock'
            }).then(function () {
                done();
            });
        });
    });

    it('dc create model in default instances', function (done) {
        let models = app.iota.dc.instances['default'].models;
        models.User.sync({ force: true }).then(function () {
            // Table created
            models.User.create({
                username: 'John',
                password: 'Hancock'
            }).then(function () {
                done();
            });
        });
    });

    it('dc create model in console instance', function (done) {
        let models = app.iota.dc.instances['console'].models;
        models.A.sync({ force: true }).then(function () {
            // Table created
            models.A.create({
                username: 'John',
                password: 'Hancock'
            }).then(function () {
                done();
            });
        });
    });

    it('dc create model use auto transaction', function (done) {
        let models = app.iota.dc.models;
        models.User.sync({ force: true }).then(function () {
            app.iota.dc.orm.transaction(function (t) {
                return models.User.create({
                    username: 'John',
                    password: 'Hancock'
                }, { transaction: t });
            }).then(function () {
                done();
            });
        });
    });

    it('dc create model use menu transaction', function (done) {
        let models = app.iota.dc.models;
        models.User.sync({ force: true }).then(async function () {
            let t = await app.iota.dc.orm.transaction();
            await models.User.create({
                username: 'John',
                password: 'Hancock'
            }, { transaction: t });
            await t.commit();
            done();
        });
    })

    it('dc test bulk update', async function () {
        let models = app.iota.dc.models;
        await models.Role.sync({ force: true });
        await models.Role.create({ name: 'bulk', desc: 'bulk' })
        await models.Role.create({ name: 'bulk', desc: 'bulk1' })
        // await models.Role.findAll({
        //     attributes: ['id'],
        //     order: [['createBy'], ['id'], ['updatedAt', 'DESC']]
        // })
        let t = await app.iota.dc.orm.transaction();
        //0
        await models.Role.update({ name: 'bulk' }, { where: { name: 'bukl' }, transaction: t });
        await t.commit();
        t = await app.iota.dc.orm.transaction();
        //2
        await models.Role.update({ name: 'bulk' }, { where: { name: 'bulk' }, transaction: t });
        await t.commit();
        //1
        t = await app.iota.dc.orm.transaction();
        await models.Role.update({ name: 'bulk' }, { where: { desc: 'bulk' }, transaction: t });
        await t.commit();
        // d 0
        await models.Role.destroy({ where: { desc: 'bulkxx' } });

        //bc
        await models.Role.bulkCreate([{ name: 'r1' }, { name: 'r2' }]);
        //c
        let r3 = await models.Role.create({ name: 'r3' });
        //u
        await r3.update({ name: 're' });
        //bu
        await models.Role.update({ name: 're' }, { where: { id: r3.id } });
        //d
        await r3.destroy();
        //bd
        await models.Role.destroy({ where: { id: r3.id } });
    })
});