/**
 * Created by rain on 2016/6/15.
 */
import redis, { RedisClient } from 'redis';

export default class Cache {
    constructor(options) {
        this.options = options;
        this.init(options);
    }

    init(options) {
        if (!options) {
            //default
            this.options = {
                host: "127.0.0.1",
                port: "6379",
                password: "",
                db: 2
            };
        }
        this.cache = redis.createClient(this.options);
    }

    get(key) {
        const self = this;
        return new Promise(function (resolve, reject) {
            self.cache.get(key, function (err, value) {
                if (err !== null) return reject(err);
                resolve(value);
            });
        });
    }

    add(key, value) {
        const self = this;
        return new Promise(function (resolve, reject) {
            self.cache.set(key, value, function (err, data) {
                if (err !== null) return reject(err);
                resolve(data);
            });
        });
    };

    set(key, value) {
        const self = this;
        return new Promise(function (resolve, reject) {
            self.cache.set(key, value, function (err, data) {
                if (err !== null) return reject(err);
                resolve(data);
            });
        });
    };

    delete(key) {
        const self = this;
        return new Promise(function (resolve, reject) {
            self.cache.del(key, function (err, data) {
                if (err !== null) return reject(err);
                resolve(data);
            });
        });
    };

    extra(key, value, extype, exvalue) {
        const self = this;
        return new Promise(function (resolve, reject) {
            self.cache.set(key, value, extype, exvalue, function (err, data) {
                if (err !== null) return reject(err);
                resolve(data);
            });
        });
    };

    clear() {

    }
}