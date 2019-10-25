import kafka from '@iota-fork/kafka-node';
import uuid from 'uuid';
const ConsumerGroup = kafka.ConsumerGroup;

/**
 * kafka data consumer
 * unicast raw data to the owner and each user who is shared this thing;
 */
class RawData {
    constructor(opts, messageCenter, dc, logger) {
        this.messageCenter = messageCenter;
        this.dc = dc;
        this.logger = logger;
        opts.kafkaHost = opts.kafkaHost || 'localhost:9092';
        opts.topics = opts.topics || ['RawData'];
        opts.consumer = opts.consumer || {};
        //@TODO protect: limit of group of kafka.
        //opts.consumer.groupId = opts.consumer.groupId || uuid.v4();
        opts.consumer.groupId = opts.consumer.groupId || 'iota-inline-raw-data-consumer';
        opts.consumer.fromOffset = 'latest';
        this.consumerGroup = new ConsumerGroup(Object.assign({}, opts.consumer, { kafkaHost: opts.kafkaHost }), opts.topics);
        this.consumerGroup.on('error', this.onError);
        this.consumerGroup.on('message', this.onRawData);
    }

    onRawData = (rawData) => {
        let raw = undefined;
        try {
            raw = JSON.parse(rawData.value);
        } catch (err) {
            this.logger.error(err, rawData.value);
            return;
        }
        let thingId = raw.thingId;
        if (thingId) {
            let message = {};
            message.method = 'unicast';
            message.receiver = [`things/${thingId}`];
            message.sender = -1;
            message.targetDomain = 'console';
            message.sourceDomain = 'console';
            message.payloadType = 'rawData';
            message.payload = rawData.value;
            this.messageCenter.unicast(message.targetDomain, { message: message });
            // get all shared user; slow? and every message?
            // async
            // let models = this.dc.models;
            // let that = this;
            // models.UserGroupUser.findAndCountAll({
            //     attributes: ['userId'],
            //     include: [{
            //         model: models.UserGroup,
            //         as: 'userGroup',
            //         include: [{
            //             model: models.Authorization,
            //             as: 'authorizations',
            //             include: [{
            //                 model: models.ResourceGroup,
            //                 as: 'resourceGroup',
            //                 include: [{
            //                     model: models.Resource,
            //                     as: 'resources',
            //                     where: { key: thingId }
            //                 }]
            //             }]
            //         }]
            //     }],
            //     distinct: true
            // }).then((result) => {
            //     if (result.count > 0) {
            //         result.rows.forEach((user) => {
            //             message.receiver = [user.userId];
            //             this.messageCenter.unicast(message.targetDomain, { message: message });
            //         })
            //     }
            // }).catch(err => {
            //     that.logger.error(err)
            // });
        }
    }

    onError = (err) => {
        this.logger.error(err);
    }
}

export default RawData;