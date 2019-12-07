import Cache from '../src/cache';
import chai, { assert } from 'chai';

const should = chai.should();

describe("Cache Test", function () {

    it("test set/get.", function (done) {
        let cache = new Cache({ type: 'redis', host: 'localhost', port: '6379' });
        cache.add('key', 'value').then(
            cache.get('key').then(function (value) {
                assert.equal(value, 'value');
                done();
            }, function (err) {
                console.log(err);
                done();
            })
        )
    });


    it("test set/get with chai-as-promise.", function () {
        let cache = new Cache({ type: 'redis', host: 'localhost', port: '6379' });
        return cache.add('key', 'value').then((result) => {
            assert.equal(result, 'OK');
        });
    });


    it("test set/del.", function (done) {
        let cache = new Cache({ type: 'redis', host: 'localhost', port: '6379' });
        cache.add('key', 'value').then(
            cache.delete('key').then(function () {
                cache.get('key').then(function (value) {
                    assert.equal(value, null);
                    done();
                }, function (err) {
                    console.log(err);
                    done();
                })
            }, function (err) {
                console.log(err);
                done();
            })
        )
    });
});