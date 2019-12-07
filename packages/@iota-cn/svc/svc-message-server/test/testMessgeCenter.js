import client from 'supertest';
import chai, { assert, expect } from 'chai';

import scaffold from '@iota-cn/svc-scaffolding';
import config from './config';
import io from 'socket.io-client';

const should = chai.should();

describe('iota message center test >', function () {
    this.timeout(20000);
    config.port = 17607;
    const app = scaffold(config);
    const request = client.agent(app.server);
    const models = app.iota.dc.models;

    before(async function (done) {
        done();
    });

    it('send a notice', function (done) {
        let consumer = io('http://localhost:3223/background');
        consumer.on('message', function (message) {
            done();
        })
        consumer.on('connect', function () {
            let message = {};
            message.method = 'broadcast';
            message.receiver = '-1';
            message.sender = 'test';
            message.targetDomain = 'background';
            message.sourceDomain = 'console';
            message.payloadType = 'notice';
            message.payload = {
                type: 'WorkOrder',
                title: '收到一条新的工单',
                //通知内容
                content: '您提及的工单已有工作人员处理，请至工单页面查看。',
                //extend info 通知框架本身不处理
                payload: {}
            };
            app.iota.message.send(message);
        });
    });
});