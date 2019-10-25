'use strict';

Object.defineProperty(exports, "__esModule", {
    value: true
});

var _path = require('path');

var _path2 = _interopRequireDefault(_path);

var _os = require('os');

var _os2 = _interopRequireDefault(_os);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const dev = process.env.DEBUG || true;
const product = {
    port: 80,
    cors: {
        credentials: true,
        origin: '*'
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
        filename: _path2.default.join(__dirname, 'log', 'runtime.txt'),
        colorize: false,
        maxsize: 1024 * 1024 * 5,
        rotationFormat: false,
        zippedArchive: true,
        maxFiles: 10,
        prettyPrint: false,
        label: '',
        timestamp: true,
        eol: _os2.default.EOL,
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
    logger: product.logger
};
development.logger.filename = _path2.default.join(__dirname, 'log', 'development.txt');

exports.default = dev ? development : product;