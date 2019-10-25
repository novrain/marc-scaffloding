/**
 * Created by rain on 2016/10/27.
 */
import Cache from '../src/cache';
import chai, {assert} from 'chai';
import mqtt from 'mqtt';

const should = chai.should();

describe("Mqtt Test", function () {
    this.timeout(500000);
    it("test connect/disconnect.", function (done) {
        var client = mqtt.connect('mqtt://test.mosquitto.org:1883', {reconnectPeriod: 10000});
        client.on('connect', function () {
            console.log('server connected');
            client.publish('cm/notify', 'test msg');
            client.publish('cm/notify', 'test msg', {}, function () {
                client.end(true, function () {
                    done();
                });
            });
        });
        client.on('offline', function () {
            console.log('client offline');
            done();
        });
        client.on('reconnect', function () {
            console.log('client reconnect');
            done();
        });
        client.on('error', function (error) {
            console.log('client error', error);
            done();
        });
    });
});
