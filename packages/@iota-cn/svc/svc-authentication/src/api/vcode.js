import uuid from "uuid";
import vcode from 'trek-captcha';

export default async (ctx, next) => {
    let img;
    let error = true;
    try {
        let captcha = await vcode({ size: 6 });
        if (captcha) {
            let txt = (captcha.token + '').toLowerCase();
            img = `data:image/gif;base64,${captcha.buffer.toString('base64')}`;
            let exp = 3600000;//1小时->3600000*1
            let cv = ctx.cookies.get('iota_r');
            if (cv) {
                await ctx.iota.dc.cache.extra(`vcode=${cv}`, txt, 'PX', exp);
            } else {
                let id = uuid.v4();
                await ctx.cookies.set('iota_r', id, { maxAge: exp });
                await ctx.iota.dc.cache.extra(`vcode=${id}`, txt, 'PX', exp);
            }
            error = false;
        } else {
            throw new Error(`captcha maybe have a problem `);
        }
    } catch (e) {
        ctx.status = 500;
        ctx.body = {
            name: 'server error',
            message: 'an unexpected condition was encountered in the server and no more specific message is suitable.'
        };
        ctx.iota.logger.error(`path: ${ctx.path},error: ${e}`);
        return false;
    }

    if (error) {
        ctx.status = 400;
        ctx.body = {
            name: 'validation error',
            message: 'invalid request message framing, malformed request syntax,or deceptive request routing.',
            detail: 'can not create graph captcha correctly'
        };
    } else {
        ctx.type = '*/*;charset:utf-8;';
        ctx.body = img;
        ctx.status = 200;
    }
}
