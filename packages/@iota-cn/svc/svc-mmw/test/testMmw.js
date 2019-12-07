'use strict';

import MMw from '../src/index';
import chai, { assert } from 'chai';
import path from 'path';
const should = chai.should();

describe('Mmw test', function () {
    it('empty middleware', function (done) {
        let mmw = new MMw();
        mmw.callMw(1)
            .then(() => {
                assert.equal(1, 1, "callMw finished.");
                done();
            })
            .catch((err) => {
            });
    });

    it('invalid use middleware', function (done) {
        let mmw = new MMw();
        try {
            mmw.use(null);
        } catch (err) {
            assert.equal(1, 1, err.message);
            done();
        }
    });

    it('invalid compose middleware: not array', function (done) {
        let mmw = new MMw();
        try {
            mmw.compose(1);
        } catch (err) {
            assert.equal(1, 1, err.message);
            done();
        }
    });

    it('invalid compose middleware: not function', function (done) {
        let mmw = new MMw();
        try {
            mmw.compose([1]);
        } catch (err) {
            assert.equal(1, 1, err.message);
            done();
        }
    });

    it('middleware really called', function (done) {
        let mmw = new MMw();
        mmw.use(async function () {
            assert.equal(1, 1, "middleware function really be called.");
            done();
        });
        mmw.callMw()
            .then(() => {
                assert.equal(1, 1, "callMw finished.");
            })
            .catch((err) => {
                done();
            });
    });

    it('multi middleware', function (done) {
        let mmw = new MMw();
        mmw.use(async function (next) {
            await next();
        });
        mmw.use(async function () {
            assert.equal(1, 1, "middleware function really be called.");
            done();
        });
        mmw.callMw()
            .then(() => {
                assert.equal(1, 1, "callMw finished.");
            })
            .catch((err) => {
                done();
            });
    });


    it('multi middleware with arguments', function (done) {
        let mmw = new MMw();
        let index = 0;
        mmw.use(async function (value, next, notExist) {
            index++;
            assert.equal(index, 1);
            assert.equal(value, 1, "first middleware function get the arguments.");
            assert.notEqual(next, undefined);
            assert.equal(notExist, undefined);
            await next();
        });
        mmw.use(async function (value, next) {
            index++;
            assert.equal(index, 2);
            assert.notEqual(next, undefined);
            assert.equal(value, 1, "second middleware function get the arguments.");
            done();
        });
        let value = 1;
        mmw.callMw(value)
            .then(() => {
                assert.equal(1, 1, "callMw finished.");
            })
            .catch((err) => {
                done(err);
            });
    });

    it('multi middleware with try/catch', function (done) {
        let mmw = new MMw();
        mmw.use(async function (value, next, notExist) {
            await next();
        });
        mmw.use(async function (value, next) {
            throw new Error('I am a error');
        });
        let value = 1;
        mmw.callMw(value)
            .then(() => {
                assert.equal(1, 1, "callMw finished.");
            })
            .catch((err) => {
                assert.equal(err.message, 'I am a error');
                assert.equal(1, 1, err.message);
                done();
            });
    });


});