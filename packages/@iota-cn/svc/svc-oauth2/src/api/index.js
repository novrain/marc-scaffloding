/**
 * Created by rain on 2016/7/28.
 */
import {
    signin,
    binding,
    signUp,
    bindingCurrentUser,
    queryBindingStatus,
    unbindCurrentUser
} from './wechat';
import {
    accessToken,
    refreshToken,
    invalidateToken
} from './token';
import {
    find,
    create,
    _delete
} from './application';
import { createMiddleware } from '@iota-cn/svc-util'
export default function(app, router, opts) {
    //wechat
    router.get('/oauth2/third_parties/wechat', signin(opts));
    router.post('/oauth2/third_parties/wechat/signin', binding);
    if (!opts.notAllowRegistry) {
        router.post('/oauth2/third_parties/wechat/signup', signUp);
    }
    router.get('/accounts/wechat/binding', bindingCurrentUser(opts));
    router.post('/accounts/wechat/unbind', unbindCurrentUser);
    router.get('/accounts/wechat/binding/status', queryBindingStatus);
    //app token
    router.post('/oauth2/token', accessToken);
    router.post('/oauth2/token/refresh', refreshToken);
    router.post('/oauth2/token/invalidate', invalidateToken);

    //UserApp
    router.get('/oauth2/apps/:id?', createMiddleware(find));
    router.post('/oauth2/apps', createMiddleware(create));
    router.delete('/oauth2/apps/:id', createMiddleware(_delete));
}