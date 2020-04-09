'use strict';
var Promise = require('bluebird'),
    Sequelize = require('@iota-fork/sequelize'),
    http = require('http'),
    Koa = require('koa'),
    Router = require('koa-66'),
    convert = require('koa-convert'),
    bodyParser = require('koa-bodyparser'),
    chai = require('chai');

const Op = Sequelize.Op;
const operatorsAliases = {
    $eq: Op.eq,
    $ne: Op.ne,
    $gte: Op.gte,
    $gt: Op.gt,
    $lte: Op.lte,
    $lt: Op.lt,
    $not: Op.not,
    $in: Op.in,
    $notIn: Op.notIn,
    $is: Op.is,
    $like: Op.like,
    $notLike: Op.notLike,
    $iLike: Op.iLike,
    $notILike: Op.notILike,
    $regexp: Op.regexp,
    $notRegexp: Op.notRegexp,
    $iRegexp: Op.iRegexp,
    $notIRegexp: Op.notIRegexp,
    $between: Op.between,
    $notBetween: Op.notBetween,
    $overlap: Op.overlap,
    $contains: Op.contains,
    $contained: Op.contained,
    $adjacent: Op.adjacent,
    $strictLeft: Op.strictLeft,
    $strictRight: Op.strictRight,
    $noExtendRight: Op.noExtendRight,
    $noExtendLeft: Op.noExtendLeft,
    $and: Op.and,
    $or: Op.or,
    $any: Op.any,
    $all: Op.all,
    $values: Op.values,
    $col: Op.col
};

var TestFixture = {
    models: {},
    Sequelize: Sequelize,

    initializeDatabase: function () {
        return TestFixture.db.sync({ force: true });
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
        logging: true,
        operatorsAliases
    });
});

// always print stack traces when an error occurs
chai.config.includeStack = true;

module.exports = TestFixture;
