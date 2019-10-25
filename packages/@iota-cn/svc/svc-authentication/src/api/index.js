import Authentication from './authentication';
import authenticator from './authenticator';
import vcode from './vcode';
import Message from './message';
import Email from './email';
import { createMiddleware } from '@iota-cn/svc-util';

export default function(app, router, opts) {
    router.use(authenticator(opts));
    router.get('/validations/codes/validate', Authentication.verifyVCode);
    router.get('/validations/smses/validate', Authentication.verifyCaptchaSMS);
    router.get('/validations/codes', vcode);
    router.post('/validations/smses', opts.dev ? Message.fakeSMS : Message.sendCaptchaSMS(opts)); //for testing

    router.post('/signin', Authentication.signIn(opts));
    router.post('/signout', Authentication.signOut);
    if (!opts.notAllowRegistry) {
        router.post('/signup', Authentication.signUp);
    }
    router.post('/accounts/password/change', createMiddleware(Authentication.changePassword));


    router.post('/accounts/password/forget', Email.sendVerificationEmail(opts, 'password'));
    router.post('/accounts/email/active', Email.sendVerificationEmail(opts, 'activation'));
    router.get('/accounts/password/forget', Email.findPasswordByEmail(opts));
    router.post('/accounts/password/reset', Email.changePasswordByEmail(opts));
    router.get('/accounts/email/active', Email.activeEmail(opts));

    //@TODO 是否合适(路由/放置模块等)
    router.get('/accounts/profile', createMiddleware(Authentication.current));
    router.put('/accounts/profile', createMiddleware(Authentication.updateCurrent));
}


let signUp = Authentication.signUp;
let signIn = Authentication.signIn;

export {
    signUp,
    signIn
}