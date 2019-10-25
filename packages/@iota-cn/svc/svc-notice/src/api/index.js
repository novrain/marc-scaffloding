import { createMiddleware } from '@iota-cn/svc-util';
import Notice from './notice';
const notice = new Notice();

export default function (app, router, opts) {
    const models = app.iota.dc.models;
    const restful = app.iota.restful;

    let noticeType = restful.resource({
        model: models.NoticeType,
        endpoints: ['/notice_types', '/notice_types/:id'],
        associations: true,
        actions: ['list', 'read']
    });

    if (app && app.iota && app.iota.restful && typeof app.iota.restful.createNormalizerAfter === 'function') {
        noticeType.list.send.after(app.iota.restful.createNormalizerAfter("noticeType"));
    }

    router.get('/notices/unread', createMiddleware(notice.unread));
    router.get('/notices/read', createMiddleware(notice.read));
    router.get('/notices/detail/:id', createMiddleware(notice.findOne));
    router.get('/notices/all', createMiddleware(notice.findAll));

    //router.post('/notices', createMiddleware(notice.create));
    //批量已读
    router.post('/notices/read', createMiddleware(notice.markRead));

    //router.del('/notices', createMiddleware(notice.read));

    return router;
}
