/**
 * Created by rain on 2016/6/15.
 */
import Cache from './cache';
import Sequelize from '@iota-fork/sequelize';
import mqtt from 'mqtt';
import Transaction from '@iota-fork/sequelize/lib/transaction';
import { isPlainObject } from '@iota-cn/svc-util';

import MMw from '@iota-cn/svc-mmw';

const Op = Sequelize.Op;
const operatorsAliases = {
    $eq: Op.eq,
    $ne: Op.ne,
    $gte: Op.gte,
    $gt: Op.gt,
    $lte: Op.lte,
    $lt: Op.lt,
    $not: Op.not,
    $in: Op.in,
    $notIn: Op.notIn,
    $is: Op.is,
    $like: Op.like,
    $notLike: Op.notLike,
    $iLike: Op.iLike,
    $notILike: Op.notILike,
    $regexp: Op.regexp,
    $notRegexp: Op.notRegexp,
    $iRegexp: Op.iRegexp,
    $notIRegexp: Op.notIRegexp,
    $between: Op.between,
    $notBetween: Op.notBetween,
    $overlap: Op.overlap,
    $contains: Op.contains,
    $contained: Op.contained,
    $adjacent: Op.adjacent,
    $strictLeft: Op.strictLeft,
    $strictRight: Op.strictRight,
    $noExtendRight: Op.noExtendRight,
    $noExtendLeft: Op.noExtendLeft,
    $and: Op.and,
    $or: Op.or,
    $any: Op.any,
    $all: Op.all,
    $values: Op.values,
    $col: Op.col
};

class Mqtt {
    static DEFAULT_BROKE = 'mqtt://127.0.0.1:1883';
    static DEFAULT_CM_NOTIFY_TOPIC = 'cm/notify';

    constructor(app, options) {
        let logger = this.logger = app.iota.logger || console;
        this.client = mqtt.connect(options ? options.broker || Mqtt.DEFAULT_BROKE : Mqtt.DEFAULT_BROKE, options);
        let client = this.client;
        this.cmNotifyTopic = options ? options.cmNotifyTopic || Mqtt.DEFAULT_CM_NOTIFY_TOPIC : Mqtt.DEFAULT_CM_NOTIFY_TOPIC
        this.client.on('connect', function () {
            logger.log('info', '[IOTA-DC-MQTT]', 'mqtt connected.');
        });
        this.client.on('offline', function () {
            logger.log('error', '[IOTA-DC-MQTT]', 'mqtt offline.');
        });
        this.client.on('reconnect', function () {
            logger.log('info', '[IOTA-DC-MQTT]', 'mqtt reconnecting.');
        });
        this.client.on('error', function (error) {
            logger.log('error', '[IOTA-DC-MQTT]', 'mqtt error.', error);
        });
    }

    notifyCm(msg) {
        this.client.publish(this.cmNotifyTopic, msg, { qos: 1 });
    }
}

//Orm and cache wrapper.
class DataCenter {
    constructor(options) {
        this.options = options;
        this.models = {};
        let ormOptions = options.orm;
        //@Todo add check and throw
        this.orm = new Sequelize(ormOptions.url, Object.assign(ormOptions.opts, { dialect: 'postgres', operatorsAliases }));
        //change default function behave
        let oldTransaction = Sequelize.prototype.transaction;
        let oldCommit = Transaction.prototype.commit;
        this.orm.transaction = async function (options, autoCallback) {
            if (typeof options === 'function') {
                autoCallback = options;
                options = undefined;
            }
            oldTransaction = oldTransaction.bind(this);
            let mmw = new MMw();
            if (autoCallback) {
                return oldTransaction(options, function (t) {
                    // Ensure sequelize didn't add this functionality themselves already:
                    if (!t.mmw)
                        t.mmw = mmw;
                    return autoCallback(t);
                }).then(async function (result) {
                    await mmw.callMw();
                });
            } else {
                let t = await oldTransaction(options);
                // Ensure sequelize didn't add this functionality themselves already:
                if (!t.mmw)
                    t.mmw = mmw;
                t.commit = function () {
                    let origin = oldCommit.bind(this);
                    return origin().then(async function () {
                        await mmw.callMw();
                    })
                };
                return t;
            }
        };
        this.ORM = Sequelize;
        this.orm.Error = Sequelize.Error
        if (options.cache) {
            this.cache = new Cache(options.cache);
        }
        let self = this;
        if (Array.isArray(options.models)) {
            options.models.forEach(function (e) {
                //is function?
                //@Todo add cache registry api.
                if (typeof e === 'function') {
                    e(self);
                }
            });
        }
    };
}

let createDc = (app, options) => {
    let dc = new DataCenter(options);
    let logger = app.iota.logger || console;
    if (options.mqtt) {
        let mqtt = new Mqtt(app, options.mqtt);

        let getKey = function (ins) {
            let key = {};
            if (ins.hasPrimaryKeys) {
                ins.Model.primaryKeyAttributes.map(function (k) {
                    // ins.constructor.primaryKeyAttributes.map(function (k) {
                    key[k] = ins[k];
                })
            }
            return key;
        };
        //common notification creator
        let notify = function (ins, opts, type) {
            let model = ins ?
                (Array.isArray(ins) ? ins[0].Model : ins.Model)
                // (Array.isArray(ins) ? ins[0].constructor : ins.constructor)
                : (opts.model ? opts.model : undefined),
                msg,
                table;
            table = model ? model.name : undefined;
            switch (type) {
                case 'bu':
                case 'bd':
                    msg = JSON.stringify({ o: type, t: table, where: opts.where });
                    break;
                case 'bc':
                    let keys = [];
                    if (Array.isArray(ins)) {
                        keys = ins.map((record) => {
                            return getKey(record);
                        });
                    }
                    msg = JSON.stringify({ o: type, t: table, keys: keys });
                    break;
                case 'c':
                case 'u':
                case 'd':
                    let key = getKey(ins);
                    msg = JSON.stringify({ o: type, t: table, k: key, instance: ins });
                    break;
                default:
                    msg = JSON.stringify({ o: type, t: table });
            }
            if (model && model.notify && model.notify[type]) {
                logger.log('info', '[IOTA-DC-NOTIFY]', msg);
                mqtt.notifyCm(msg);
            } else {
                //ignore notify
                logger.log('debug', '[IOTA-DC-NOTIFY] ignore notify', msg);
            }
        };

        let notifyAfterCommit = function (ins, opts, type) {
            if (opts.transaction) {
                opts.transaction.mmw.use(async function (next) {
                    notify(ins, opts, type);
                    await next();
                })
            } else {
                notify(ins, opts, type)
            }
        };
        //add hook for create update destroy
        dc.orm.addHook('afterCreate', function (ins, opts) {
            notifyAfterCommit(ins, opts, 'c');
        });
        dc.orm.addHook('afterUpdate', function (ins, opts) {
            notifyAfterCommit(ins, opts, 'u');
        });
        dc.orm.addHook('afterDestroy', function (ins, opts) {
            notifyAfterCommit(ins, opts, 'd');
        });

        //add hook for bulk c u d
        dc.orm.addHook('afterBulkCreate', function (inss, opts) {
            notifyAfterCommit(inss, opts, 'bc');
        });
        dc.orm.addHook('afterBulkUpdate', function (opts) {
            notifyAfterCommit(null, opts, 'bu');
        });
        dc.orm.addHook('afterBulkDestroy', function (opts) {
            notifyAfterCommit(null, opts, 'bd');
        });
        dc.notify = mqtt;
    }
    return dc;
};

export default function (app, options) {
    //load orm when start.
    //so insert model when start.
    app.iota = app.iota || {};
    let defaultDc = createDc(app, options);
    app.iota.dc = defaultDc;
    app.iota.dc.instances = {
        'default': defaultDc
    };
    if (options.instances && isPlainObject(options.instances)) {
        for (let key in options.instances) {
            if (options.instances.hasOwnProperty(key)) {
                app.iota.dc.instances[key] = createDc(app, options.instances[key]);
            }
        }
    }

    return async function (ctx, next) {
        //wrap orm
        ctx.iota = ctx.iota || {};
        ctx.iota.dc = app.iota.dc;
        //用来丢一些当前会话中的信息，不能放在dc上，dc上就修改了全局的东西
        ctx.iota.session = ctx.iota.session || {};
        //@Todo read cache if required; break the sequence and return?
        await next();
        //@Todo clear related cache if required;
    };
}