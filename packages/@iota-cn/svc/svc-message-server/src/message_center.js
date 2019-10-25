import path from 'path';
import socketIo from 'socket.io';
import config from './config';
import MessageServer from './servers/MessageServer';

/**
 * Message center
 * Center
 *      server1
 *          ns1
 *          ns2
 *      server2
 *          ns1
 *          ns2
 *      server1.send from ns1 to ns2 :
 *          server1.ns2
 *          server2.ns2
 *
 *      consumer from kafka
 *          send to console.user
 */
class MessageCenter {
    constructor(opts, dc, logger) {
        this.servers = [];
        this.users = [];
        this.logger = logger || console;
        this.dc = dc;
        let messageCenter = this;
        if (Array.isArray(opts.servers)) {
            opts.servers.forEach((server) => {
                messageCenter.servers.push(new MessageServer(server, messageCenter, dc, logger));
            })
        }
        if (Array.isArray(opts.users)) {
            opts.users.forEach((user) => {
                try {
                    const C = require(path.join(__dirname, 'users', user.type)).default;
                    messageCenter.users.push(new C(user, messageCenter, dc, logger));
                } catch (err) {
                    this.logger.error('[IOTA-NOTICE-SERVER]', 'invalid center user', user);
                }
            })
        }
    }

    /**
     * broadcast message to all server in center, except the source server.
     */
    broadcast = async(domain, envelope) => {
        this.servers.forEach((server) => {
            if (server.id() !== envelope.serverId) {
                server.broadcast(domain, envelope.message);
            }
        })
    }

    /**
     * unicast message to all server in center, except the source server.
     */
    unicast = async(domain, envelope) => {
        this.servers.forEach((server) => {
            if (server.id() !== envelope.serverId) {
                server.unicast(domain, envelope.message);
            }
        })
    }

    /**
     * broadcast message to all server in center, except the source server.
     * btw, skip all message consumer of server.
     */
    broadcastSkipMw = async(domain, envelope) => {
        this.servers.forEach((server) => {
            if (server.id() !== envelope.serverId) {
                server.broadcastSkipMw(domain, envelope.message);
            }
        })
    }

    /**
     * unicast message to all server in center, except the source server.
     * btw, skip all message consumer of server.
     */
    unicastSkipMw = async(domain, envelope) => {
        this.servers.forEach((server) => {
            if (server.id() !== envelope.serverId) {
                server.unicastSkipMw(domain, envelope.message);
            }
        })
    }
}

export default function(app, opts) {
    opts = opts ? opts : {};
    opts.servers = Array.isArray(opts.servers) ? opts.servers : [
        ...config
    ];
    app.iota.message = app.iota.message || {};
    app.iota.message.center = new MessageCenter(opts, app.iota.dc, app.iota.logger);
}