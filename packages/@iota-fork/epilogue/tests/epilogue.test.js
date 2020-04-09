'use strict';

var Sequelize = require('@iota-fork/sequelize'),
    epilogue = require('../lib'),
    expect = require('chai').expect;

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


describe('Epilogue', function () {
    it('should throw an exception when initialized without arguments', function (done) {
        expect(epilogue.initialize).to.throw('please specify an app');
        done();
    });

    it('should throw an exception when initialized without a sequelize instance', function (done) {
        expect(epilogue.initialize.bind(epilogue, {
            app: {}
        })).to.throw('please specify a sequelize instance');
        done();
    });

    it('should throw an exception when initialized with an invalid sequelize instance', function (done) {
        expect(epilogue.initialize.bind(epilogue, {
            app: {},
            sequelize: {},
        })).to.throw('invalid sequelize instance');
        done();
    });

    it('should throw an exception with an invalid updateMethod', function (done) {
        expect(epilogue.initialize.bind(epilogue, {
            app: {},
            sequelize: { version: 0, STRING: 0, TEXT: 0, and: 0, or: 0 },
            updateMethod: 'dogs'
        })).to.throw('updateMethod must be one of PUT, POST, or PATCH');
        done();
    });

    it('should allow the user to pass in a sequelize instance rather than prototype', function () {
        var db = new Sequelize('main', null, null, {
            dialect: 'sqlite',
            storage: ':memory:',
            logging: true,
            operatorsAliases
        });

        epilogue.initialize({
            app: {},
            sequelize: db
        });

        // required sequelize parameters for the list searching
        expect(epilogue.sequelize.STRING).to.exist;
        expect(epilogue.sequelize.TEXT).to.exist;
        expect(epilogue.sequelize.and).to.exist;
        expect(epilogue.sequelize.or).to.exist;
    });
});
