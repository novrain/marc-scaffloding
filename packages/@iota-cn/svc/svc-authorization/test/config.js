import path from 'path';
import os from 'os';
import { entry as userEntry, models as userModels } from '@iota-cn/svc-user';
import { models as deviceModel } from '@iota-cn/svc-device-model';
import { entry as deviceEntry } from '@iota-cn/svc-device';
import { entry as authenticationEntry, models as authenticationModels } from '@iota-cn/svc-authentication';
import { entry as subUser, models as subUserModels } from '../src';

export default {
    port: 4000,
    mws: [
        { entry: userEntry, opts: {} },
        {
            entry: authenticationEntry,
            opts: {
                dev: true,
                remMaxAge: 30,
                signinUrl: "/signin",
                exclude: [],
            }
        },
        { entry: subUser, opts: { disableEmail: true } }
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
        models: [userModels, authenticationModels, subUserModels, deviceModel]
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