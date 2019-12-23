import {
    createMiddleware
} from '@iota-cn/svc-util';
import * as Record from './record'

export default function (app, router, opts) {
    router.get('/records', createMiddleware(Record.findAllRecord));
}