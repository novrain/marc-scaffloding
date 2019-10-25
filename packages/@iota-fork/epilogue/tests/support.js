'use strict';

var Promise = require('bluebird'),
    Sequelize = require('sequelize'),
    http = require('http'),
    Koa = require('koa'),
    Router = require('koa-66'),
    convert = require('koa-convert'),
    bodyParser = require('koa-bodyparser'),
    chai = require('chai');

var TestFixture = {
    models: {},
    Sequelize: Sequelize,

    initializeDatabase: function () {
        return TestFixture.db.sync({force: true});
    },

    initializeServer: function () {
        TestFixture.app = new Koa();
        TestFixture.app.use(convert(bodyParser()));
        TestFixture.router = new Router();

        return new Promise(function (resolve, reject) {
            TestFixture.server = TestFixture.app.listen(0, '127.0.0.1', function () {
                TestFixture.baseUrl =
                    'http://' + TestFixture.server.address().address + ':' + TestFixture.server.address().port;
                resolve();
            });
        });
    },

    clearDatabase: function () {
        return TestFixture.db
            .getQueryInterface()
            .dropAllTables();
    },

    closeServer: function () {
        return new Promise(function (resolve, reject) {
            TestFixture.server.close(function (err) {
                if (!!err) return reject(err);
                resolve();
            });
        });
    }
};

before(function () {
    TestFixture.db = new Sequelize('main', null, null, {
        dialect: 'sqlite',
        storage: ':memory:',
        logging: (process.env.SEQ_LOG ? console.log : false)
    });
});

// always print stack traces when an error occurs
chai.config.includeStack = true;

module.exports = TestFixture;
