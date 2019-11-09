/**
 * Created by rain on 2015/11/12.
 */
/**
 * Created by nestn on 2015/11/10.
 */
'use strict';

import chai from 'chai';
import path from 'path';
import fs from 'fs';
import os from 'os';

import logger from '../src/logger';

const should = chai.should();

describe('logger test', function () {
    it('logger init', function () {
        let options = {
            level: 'debug',
            filename: path.join(__dirname, 'log', 'test.txt'),
            json: false,
            logstash: false,
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
        };
        try {
            fs.unlinkSync(options.filename);
        }
        catch (ex) {
        }
        let app = {};
        let asyncMV = logger(app, options);
        let ctx = {};
        return asyncMV(ctx, function () {
        }).then(function () {
            ctx.iota.logger.log("debug", "[TEST]", "a log msg.", function () {
                let stat = fs.statSync(options.filename);
                stat.isFile().should.be.true;
                // done();
            });
        }).catch(function (err) {
            throw err
        });
    });
});