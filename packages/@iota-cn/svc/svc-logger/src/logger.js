/**
 * Created by rain on 2015/8/15.
 */
/*jslint node:true */
/*jslint nomen:true */
'use strict';
import winston, { format } from 'winston';
import fs from 'fs-extra';
import path from 'path';

const { combine, timestamp, label, printf } = format;
const iotaFormat = printf(({ level, message, timestamp }) => {
    return `${timestamp} ${level}: ${message}`;
});

export default function (app, options) {
    options.level = options.level || 'error';
    options.filename = options.filename || path.join(process.cwd(), "log", "runtime.log");
    let dir = path.dirname(options.filename);
    let logger = {};
    try {
        fs.mkdirsSync(dir);
        logger = winston.createLogger({
            level: options.level,
            // format: combine(
            //     timestamp(),
            //     iotaFormat
            // ),
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
        logger = winston.createLogger({
            level: options.level,
            // format: combine(
            //     timestamp(),
            //     iotaFormat
            // ),
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