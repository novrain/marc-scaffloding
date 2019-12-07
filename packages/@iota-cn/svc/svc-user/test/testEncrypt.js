import { encrypt } from '../src/model/user'
import client from 'supertest';

import chai, { assert, expect } from 'chai';

describe('encrypt test >', function () {
    it('test null', function () {
        assert.equal(null, encrypt(null));
    });

    it('test undefined', function () {
        assert.equal(undefined, encrypt(undefined))
    });

    it('test empty string', function () {
        assert.equal('7eb11ce6670c46013a6fadaf8bd2a3a4882bf448', encrypt(''))
    });

    it('test empty value', function () {
        assert.equal('f3d30e336d4e55698dc90f8e5309a1975d84f611', encrypt('123123'))
    })
});