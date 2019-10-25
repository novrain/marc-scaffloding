import chai, {assert} from 'chai';
const should = chai.should();
import Cache from '../src/cache.js';
const cache = new Cache();

describe('cache test', function () {
    it('add', function () {
        return cache.add('testName', 'testxx').then((result) => {
            assert.equal(result, 'OK');
        });
    });

    it('get', function () {
        return cache.get('testName').then((result) => {
            assert.equal(result, 'testxx');
        });
    });

    it('set', function () {
        return cache.set('testName', 'testyy').then((result) => {
            return cache.get('testName').then((result) => {
                assert.equal(result, 'testyy');
            });
        });
    });

    it('delete', function () {
        return cache.delete('testName').then((result) => {
            return cache.get('testName').then((result) => {
                assert.equal(result, null);
            });
        });
    });
});