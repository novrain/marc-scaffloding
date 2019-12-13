'use strict';

import path from 'path';
import os from 'os';

const dev = process.env.DEBUG || true;
const product = {
    port: 80,
    cors: {
        credentials: true,
        origin: '*'
    },
    eventRecordLog: {
        _id: 'undefined',
        username: 'undefined',
        userId: 'undefined',
        method: 'undefined',
        host: 'undefined',
        url: 'undefined',
        status: null,
        description: null,
        exception_detail: 'undefined',
        log_type: 'undefined',
        request_ip: 'undefined',
        time: 'undefined',
        browser: 'undefined',
        _v: '1.0.0',
    },
    mws: [],
    dc: {
        orm: {
            url: "postgres://postgres:ROOT@localhost:5433/iOTA_ut",
            opts: {
                pool: {
                    max: 20,
                    min: 10,
                    idle: 10000
                }
            }
        },
        cache: {
            host: "127.0.0.1",
            port: "6379"
        },
        models: []
    },
    cookie: {
        prefix: ''
    },
    bodyParser: { jsonLimit: '80mb', formLimit: '80mb' },
    session: {
        key: 'iota',
        db: {
            host: "127.0.0.1",
            port: '6379'
        }
    },
    logger: {
        level: 'debug',
        json: false,
        filename: path.join(__dirname, 'log', 'runtime.txt'),
        colorize: false,
        maxsize: 1024 * 1024 * 5,
        rotationFormat: false,
        zippedArchive: true,
        maxFiles: 10,
        prettyPrint: false,
        label: '',
        timestamp: true,
        eol: os.EOL,
        tailable: true,
        depth: null,
        showLevel: true,
        maxRetries: 1
    }
};

const development = {
    port: 4000,
    cors: product.cors,
    mws: [],
    dc: {
        orm: {
            url: "postgres://postgres:Iota123_@10.8.25.8:30432/iOTA_ut",
            opts: {}
        },
        cache: product.cache,
        models: []
    },
    cookie: product.cookie,
    session: product.session,
    logger: product.logger,
    bodyParser: product.bodyParser
};
development.logger.filename = path.join(__dirname, 'log', 'development.txt');

export default (dev ? development : product);