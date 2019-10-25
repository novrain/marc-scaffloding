import Attachment from '../mw';
const attachment = new Attachment();

export default function(app, router, opts) {

    router.post('/attachment/:p?', attachment.create(opts));
    // router.put('/attachment', attachment.update(opts));

    return router;
}