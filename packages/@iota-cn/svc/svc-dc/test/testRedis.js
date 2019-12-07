import redis from 'redis';
import chai, { assert, expect } from 'chai';

const should = chai.should();

describe("Redis Test", function () {
    this.timeout(5000);

    it("test invalid options.", function (done) {
        let client = redis.createClient({ xxxx: 'redis' });
        client.on('error', function (err) {
            done();
        });
        client.on('connect', function (err) {
            done();
        });
    });

});