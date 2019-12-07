import chai, { assert, expect } from 'chai';

import { valBetween } from '../src/index';

describe('iota util test>', function () {
    it('test between', () => {
        assert.equal(20, valBetween(undefined, 20, 1000));
        assert.equal(20, valBetween(NaN, 20, 1000));
        assert.equal(20, valBetween('xqawed', 20, 1000));
        assert.equal(20, valBetween({}, 20, 1000));
        assert.equal(20, valBetween(() => { }, 20, 1000));
        assert.equal(20, valBetween(20, 20, 1000));
        assert.equal(21, valBetween(21, 20, 1000));
        assert.equal(40, valBetween(40, 20, 1000));
        assert.equal(20, valBetween(13, 20, 1000));
        assert.equal(1000, valBetween(1000, 20, 1000));
        assert.equal(1000, valBetween(2000, 20, 1000));
        assert.equal(999, valBetween(999, 20, 1000));
        assert.equal(21, valBetween(1, 20, 1000, 21));
        assert.equal(1, valBetween(NaN, 1, 1000));
        assert.equal(21, valBetween(NaN, 1, 1000, 21));
    })
});