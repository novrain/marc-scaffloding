import User from './user';

export default function (app, router, opts) {
    //router.post('/accounts/password/change', User.changePassword);
    router.get('/validations/usernames/validate', User.existUsername);
    router.get('/validations/mobiles/validate', User.existMobile);
    router.get('/validations/emails/validate', User.existEmail);
}

let create = User.create;
let update = User.update;
let changePassword = User.changePassword;

export {
    create,
    update,
    changePassword
}
