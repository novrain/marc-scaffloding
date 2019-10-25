/**
 * 规则引擎的单点 consumer
 */
class RuleEngine {
    static ID = 'rules-mc-consumer';
    static KEEP_ALIVE_TIME = 15000;
    static DOMAIN = 'console/rules';
    constructor(opts, messageCenter, messageServer, dc, logger) {
        this.opts = opts;
        this.messageCenter = messageCenter;
        this.messageServer = messageServer;
        this.dc = dc;
        this.logger = logger;
        this.retainedMessage = [];
    }

    async onMessage(domain, message, next) {
        switch (message.payloadType) {
            case 'subscribe':
                if (message.payload.type) {
                    this.onSubscribe(message);
                }
                break;
            default: //其他所有消息
                if (message.receiver === 'rules-mc-consumer') {
                    this.onNotice(message);
                } else {
                    await next();
                }
        }
    }

    onSubscribe = (message) => {
        var re = new RegExp("^" + message.payload.type.replace(/([\[\]\?\(\)\\\\$\^\*\.|])/g, "\\$1").replace(/\+/g, "[^/]+").replace(/\/#$/, "(\/.*)?") + "$");
        for (let t in this.retainedMessage) {
            if (re.test(t)) {
                let m = Object.assign({}, this.retainedMessage[t]);
                m.receiver = message.sender;
                this.messageCenter.unicastSkipMw(RuleEngine.DOMAIN, { serverId: this.messageServer.id(), message: m });
            }
        }
    }

    onNotice = (message) => {
        if (message.payloadType && message.retain) {
            this.retainedMessage[message.payloadType] = message;
        } else {
            delete this.retainedMessage[message.payloadType];
        }
        if (message.belongTo) {
            let m = Object.assign({}, message);
            m.receiver = message.belongTo;
            this.messageCenter.unicastSkipMw(RuleEngine.DOMAIN, { serverId: this.messageServer.id(), message: m });
        } else {
            this.messageCenter.broadcastSkipMw(RuleEngine.DOMAIN, { serverId: this.messageServer.id(), message: message });
        }
    }
}

export default RuleEngine;