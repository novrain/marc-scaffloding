import path from 'path';
import os from 'os';
import { entry as userEntry, models as userModels } from '@iota-cn/svc-user';
import { models as authorizationModel } from '@iota-cn/svc-authorization';
import { models as noticeModels } from '@iota-cn/svc-notice';
import { entry as messageClientEntry } from '@iota-cn/svc-message-client';
import { entry as messageServerEntry } from '../src';

export default {
    port: 4000,
    mws: [{
        entry: userEntry,
        opts: {}
    },
    {
        entry: messageServerEntry,
        opts: {
            servers: [{
                port: 3222,
                namespaces: [{
                    nsp: 'console',
                    requireAuth: true,
                    cookiePrefix: 'c',
                    cookieKey: 'iota',
                    redis: {
                        host: "127.0.0.1",
                        port: '6379',
                        db: 0
                    }
                },
                {
                    nsp: 'background',
                    requireAuth: true,
                    cookiePrefix: 'b',
                    cookieKey: 'iota',
                    redis: {
                        host: "127.0.0.1",
                        port: '6379',
                        db: 1
                    }
                }
                ]
            },
            {
                port: 3223,
                consumers: [{
                    type: "Notice"
                }, {
                    type: 'RuleEngine'
                }],
                namespaces: [{
                    nsp: 'console'
                },
                {
                    nsp: 'background'
                },
                {
                    nsp: 'console/rules'
                }
                ]
            }
            ]
        },
        users: [{ type: 'RawData' }, { type: 'TestProgress' }]
    },
    { entry: messageClientEntry, opts: { url: 'http://localhost:3223/console' } }
    ],
    dc: {
        orm: {
            url: "postgres://postgres:ROOT@localhost:5433/iOTA_ut_background",
            opts: { logging: true }
        },
        cache: {
            host: '127.0.0.1',
            port: '6379'
        },
        models: [userModels, noticeModels],
        instances: {
            'console': {
                orm: {
                    url: "postgres://postgres:ROOT@localhost:5433/iOTA_ut",
                    opts: { logging: true }
                },
                cache: {
                    host: '127.0.0.1',
                    port: '6379'
                },
                models: [userModels, authorizationModel, noticeModels]
            }
        }
    },
    logger: {
        koa: true,
        level: 'debug',
        json: false,
        filename: path.join(__dirname, 'log', 'runtime.txt'),
        colorize: true,
        maxsize: 1024 * 1024 * 5,
        rotationFormat: false,
        zippedArchive: true,
        maxFiles: 10,
        prettyPrint: true,
        label: '',
        timestamp: true,
        eol: os.EOL,
        tailable: true,
        depth: null,
        showLevel: true,
        maxRetries: 1
    }
};