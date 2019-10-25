/**
 * 通知消息的处理
 * 理论上只有console/background domain会产生Notice，其他的 domain ...
 */
class Notice {
    constructor(opts, messageCenter, messageServer, dc, logger) {
        this.opts = opts;
        this.messageCenter = messageCenter;
        this.messageServer = messageServer;
        this.dc = dc;
        this.logger = logger;
    }

    async onMessage(domain, message, next) {
        if (message.payloadType === 'notice') {
            let notice = Object.assign({}, message.payload);
            notice.sender = message.sender;
            notice.receiver = message.receiver;
            let models = this.dc.instances[message.targetDomain] ?
                this.dc.instances[message.targetDomain].models :
                this.dc.models;
            try {
                let newNotice = await models.Notice.create(notice);
                message.payload.id = newNotice.id;
            } catch (err) {
                this.logger.error(err);
            }
        }
        await next();
    }
}

export default Notice;