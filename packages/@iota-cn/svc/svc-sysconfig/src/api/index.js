import { createMiddleware } from '@iota-cn/svc-util'
import * as Sysconfig from './sysconfig'

export default function (app, router, opts) {
    router.get('/sysconfig', Sysconfig.fetchSysconfig);
    router.put('/sysconfig/:key', createMiddleware(Sysconfig.updateSysconfig));
}