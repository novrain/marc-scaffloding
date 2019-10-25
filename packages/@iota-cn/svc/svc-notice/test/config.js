import path from 'path';
import os from 'os';
import { entry as userEntry, models as userModels } from '@iota-cn/svc-user';
import { entry as authenticationEntry, models as authenticationModels } from '@iota-cn/svc-authentication';
import { entry as notice, models as noticeModels } from '../src';

export default {
    port: 4000,
    mws: [
        { entry: userEntry, opts: {} },
        {
            entry: authenticationEntry,
            opts: {
                exclude: [
                    { p: '/oauth2/third_parties/wechat', o: 'GET' },
                    { p: '/oauth2/third_parties/wechat/signin', o: 'POST' },
                    { p: '/oauth2/third_parties/wechat/signup', o: 'POST' },
                    { p: '/oauth2/token', o: 'POST' }
                ],
                remMaxAge: 30
            }
        },
        { entry: notice, opts: {} }
    ],
    dc: {
        orm: {
            url: "postgres://postgres:ROOT@localhost:5433/iOTA_ut",
            opts: { logging: true }
        },
        cache: {
            host: '127.0.0.1',
            port: '6379'
        },
        models: [userModels, authenticationModels, noticeModels]
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