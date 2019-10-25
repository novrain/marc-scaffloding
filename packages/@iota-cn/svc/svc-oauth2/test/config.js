/**
 * Created by rain on 2016/6/21.
 */
import path from 'path';
import os from 'os';
import {entry as userEntry, models as userModels} from '@iota-cn/svc-user';
import {entry as authenticationEntry, models as authenticationModels} from '@iota-cn/svc-authentication';
import {entry as authorizationEntry, models as authorizationModels} from '@iota-cn/svc-authorization';
import {entry as oauth2Entry, models as oauth2Models} from '../src';

export default {
    global: {
        domain: 'http://localhost'
    },
    port: 4000,
    mws: [
        {entry: userEntry, opts: {}},
        {
            entry: authenticationEntry,
            opts: {
                exclude: [
                    {p: '/oauth2/third_parties/wechat', o: 'GET'},
                    {p: '/oauth2/third_parties/wechat/signin', o: 'POST'},
                    {p: '/oauth2/third_parties/wechat/signup', o: 'POST'},
                    {p: '/oauth2/token', o: 'POST'},
                    {p: '/oauth2/token/refresh', o: 'POST'},
                    {p: '/oauth2/token/invalidate', o: 'POST'}
                ],
                remMaxAge: 30
            }
        },
        {entry: authorizationEntry, opts: {dcInstance: 'console'}},
        {
            entry: oauth2Entry,
            opts: {
                tokenApi: 'https://api.weixin.qq.com/sns/oauth2/access_token?appid=%s&secret=%s&code=%s&grant_type=authorization_code',
                appid: 'wx3574513caf683222',
                secret: '3ddbf62ba215d2ba2a9313fe96b1a043',
                userApi: 'https://api.weixin.qq.com/sns/userinfo?access_token=%s&openid=%s',
                oauth2: {
                    redirect: {
                        wxerror: '/oauth2/third_parties/wechat/error',
                        wxnew: '/oauth2/third_parties/wechat/signup',
                        index: '/console',
                        binding: '/console/user/profile?key=4',
                    }
                }
            }
        }
    ],
    dc: {
        orm: {
            url: "postgres://postgres:ROOT@localhost:5433/iOTA_ut",
            opts: {logging: true}
        },
        cache: {
            host: '127.0.0.1',
            port: '6379'
        },
        models: [userModels, authenticationModels, authorizationModels, oauth2Models]
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