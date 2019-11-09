import path from 'path';
import os from 'os';
import { entry as userEntry, models as userModels } from '../src';

export default {
    port: 4000,
    mws: [
        { entry: userEntry, opts: {} },
    ],
    dc: {
        orm: {
            url: "postgres://postgres:ROOT@localhost:5433/iOTA_ut",
            opts: {}
        },
        cache: {
            host: '127.0.0.1',
            port: '6379'
        },
        models: [userModels]
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