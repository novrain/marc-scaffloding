import path from 'path';
import Redis from "ioredis";
import socketIo from 'socket.io';
import Mmw from '@iota-cn/svc-mmw';
import uuid from 'uuid';

/**
 * web socket server
 */
class MessageServer {
    constructor(opts, messageCenter, dc, logger) {
        this.messageCenter = messageCenter;
        this.socketServer = socketIo();
        this.socketServer.listen(opts.port || 3222);
        this.dc = dc;
        this.logger = logger || console;
        this.redises = {};
        opts.consumers = opts.consumers || [];
        this.consumers = [];
        //使用中间件串起
        this.broadcastMmw = new Mmw();
        this.unicastMmw = new Mmw();
        this._id = uuid.v4();
        //根据配置Load 消息处理类，消息处理类是不区分domain的，需要在自己的逻辑里区分哪些需要处理，包括哪些需要继续处理
        //@TODO,变成可插拔的安装包
        opts.consumers.forEach((consumer) => {
            try {
                const C = require(path.join(__dirname, 'consumers', consumer.type)).default;
                const newC = new C(consumer, messageCenter, this, dc, logger);
                if (typeof newC.onMessage === 'function') {
                    let mw = newC.onMessage.bind(newC);
                    this.broadcastMmw.use(mw);
                    this.unicastMmw.use(mw);
                    this.consumers.push(newC);
                } else {
                    this.logger.error('[IOTA-NOTICE-SERVER]', 'invalid consumer', consumer);
                }
            } catch (err) {
                this.logger.error('[IOTA-NOTICE-SERVER]', 'invalid consumer', consumer, err);
            }
        })
        opts.namespaces = opts.namespaces || [];
        opts.namespaces.forEach((namespace) => {
            if (namespace.requireAuth) {
                this.redises[namespace.nsp] = new Redis(namespace.redis);
            }
            this.socketServer.of(namespace.nsp).on('connection', this.onConnection(namespace));
        });
        this.broadcastMmw.use((domain, message) => {
            this.socketServer.of(domain).emit('message', message);
        });
        this.unicastMmw.use((domain, message) => {
            this.socketServer.of(domain).in(message.receiver).emit('message', message);
        });
    }

    onConnection = (namespace) => {
        let messageServer = this;
        return (socket) => {
            //broadcastMmw
            let broadcastMmw = new Mmw();
            this.consumers.forEach(c => {
                broadcastMmw.use(c.onMessage.bind(c));
            })
            broadcastMmw.use((domain, message) => {
                socket.broadcast.emit(message.event || 'message', message);
            });

            //unicastMmw
            let unicastMmw = new Mmw();
            this.consumers.forEach(c => {
                unicastMmw.use(c.onMessage.bind(c));
            })
            unicastMmw.use((domain, message) => {
                socket.broadcast.in(message.receiver).emit(message.event || 'message', message);
            });

            let broadcast = async (message) => {
                let mmw;
                if (namespace.nsp === message.targetDomain) {
                    //send to all client of this server except sender;
                    mmw = broadcastMmw;
                } else {
                    mmw = this.broadcastMmw;
                }
                mmw.callMw(message.targetDomain, message).then(() => {
                    //broadcast message to the same domain of other server in center
                    messageServer.onBroadcast(message);
                }).catch(err => {
                    this.logger.error(err);
                });
            };
            let unicast = async (message) => {
                let mmw;
                if (namespace.nsp === message.targetDomain) {
                    //send to all client with recevier id of this server except sender;
                    mmw = unicastMmw;
                } else {
                    mmw = this.unicastMmw;
                }
                mmw.callMw(message.targetDomain, message).then(() => {
                    //unicast message to the same domain of other server in center
                    messageServer.onUnicast(message);
                }).catch(err => {
                    this.logger.error(err);
                });
            }
            messageServer.logger.info('new connection from:', socket.conn.remoteAddress, 'domain:', namespace.nsp);
            if (namespace.requireAuth) {
                let cookieKey = namespace.cookieKey || 'iota';
                let cookiePrefix = namespace.cookiePrefix || '';
                let cookie = socket.request.headers.cookie;
                if (cookie) {
                    let sessionKey = messageServer.getCookie(cookie, `${cookiePrefix}${cookieKey}`);
                    if (sessionKey) {
                        messageServer.redises[namespace.nsp].get(`${cookieKey}=${sessionKey}`).then((res) => {
                            let session = messageServer.decode(res);
                            if (session && session.user) {
                                let userId = session.user.id;
                                socket.join(userId, function () {
                                    messageServer.logger.info(`a client of user{${userId}} connected`);
                                    socket.on('broadcast', broadcast);
                                    socket.on('unicast', unicast);
                                    socket.on('join', (room) => {
                                        socket.join(room.id);
                                    });
                                    socket.on('leave', (room) => {
                                        socket.leave(room.id);
                                    });
                                });
                            } else {
                                messageServer.logger.error(`a client of unknown user will be closed`, socket.conn.remoteAddress);
                                socket.disconnect(true);
                            }
                        })
                            .catch((err) => {
                                messageServer.logger.error(err, socket.conn.remoteAddress);
                                socket.disconnect(true);
                            });
                    }
                } else {
                    messageServer.logger.error(`a client of unknown user will be closed`, socket.conn.remoteAddress);
                    socket.disconnect(true);
                }
            } else {
                socket.on('broadcast', broadcast);
                socket.on('unicast', unicast);
                socket.on('join', (room) => {
                    socket.join(room.id);
                });
                socket.on('leave', (room) => {
                    socket.leave(room.id);
                });
            }
        }
    }

    onBroadcast = (message) => {
        //envelope message with server id.
        this.messageCenter.broadcast(message.targetDomain, { serverId: this._id, message: message });
    }

    onUnicast = (message) => {
        //envelope message with server id.
        this.messageCenter.unicast(message.targetDomain, { serverId: this._id, message: message });
    }

    /**
     * message form same domain in message center
     */
    broadcast = (domain, message) => {
        this.broadcastMmw.callMw(domain, message).catch(err => {
            this.logger.error(err);
        });
    }

    /**
     * message form same domain in message center
     */
    unicast = (domain, message) => {
        this.unicastMmw.callMw(domain, message).catch(err => {
            this.logger.error(err);
        });
    }

    /**
     * message form same domain in message center
     * the method will skip all message comsumer of middlewar.
     */
    broadcastSkipMw = (domain, message) => {
        this.socketServer.of(domain).emit(message.event || 'message', message);
    }

    /**
     * message form same domain in message center
     * the method will skip all message comsumer of middlewar.
     */
    unicastSkipMw = (domain, message) => {
        this.socketServer.of(domain).in(message.receiver).emit(message.event || 'message', message);
    }

    id = () => {
        return this._id;
    }

    getCookie = (cookie, name) => {
        let result = null;
        let myCookie = cookie + ";";
        let searchName = name + "=";
        let startOfCookie = myCookie.indexOf(searchName);
        let endOfCookie;
        if (startOfCookie != -1) {
            startOfCookie += searchName.length;
            endOfCookie = myCookie.indexOf(";", startOfCookie);
            result = (myCookie.substring(startOfCookie, endOfCookie));
        }
        return result;
    }

    decode = (session) => {
        if (!session) return '';
        let decoded = "";
        try {
            decoded = new Buffer(session, "base64").toString();
            return JSON.parse(decoded);
        } catch (e) {
            this.logger.error(e);
            return '';
        }
    }
}

export default MessageServer;