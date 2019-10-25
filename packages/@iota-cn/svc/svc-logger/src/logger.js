/**
 * Created by rain on 2015/8/15.
 */
/*jslint node:true */
/*jslint nomen:true */
'use strict';
import winston from 'winston';
import fs from 'fs-extra';
import path from 'path';

export default function (app, options) {
    options.level = options.level || 'error';
    options.filename = options.filename || path.join(process.cwd(), "log", "runtime.log");
    let dir = path.dirname(options.filename);
    let logger = {};
    try {
        fs.mkdirsSync(dir);
        logger = new (winston.Logger)({
            level: options.level,
            transports: [
                new (winston.transports.Console)({
                    colorize: 'all',
                    timestamp: options.timestamp || true
                }),
                new (winston.transports.File)(options)
            ],
            exitOnError: false
        });
    } catch (err) {
        logger = new (winston.Logger)({
            level: options.level,
            transports: [
                new (winston.transports.Console)({
                    colorize: 'all',
                    timestamp: options.timestamp || true
                })
            ],
            exitOnError: false
        });
    }
    app.iota = app.iota || {};
    app.iota.logger = logger;
    logger.log('debug', "[iOTA-LOGGER]", "Init.");
    return async function (ctx, next) {
        ctx.iota = ctx.iota || {};
        ctx.iota.logger = logger;
        await next();
    }
};