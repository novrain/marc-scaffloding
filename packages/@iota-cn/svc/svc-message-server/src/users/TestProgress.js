import kafka from '@iota-fork/kafka-node';
import uuid from 'uuid';
const ConsumerGroup = kafka.ConsumerGroup;

/**
 * kafka test progress consumer
 * unicast by taskId
 */
class TestProgress {
    constructor(opts, messageCenter, dc, logger) {
        this.messageCenter = messageCenter;
        this.dc = dc;
        this.logger = logger;
        opts.kafkaHost = opts.kafkaHost || 'localhost:9092';
        opts.topics = opts.topics || ['TestProgress'];
        opts.consumer = opts.consumer || {};
        //@TODO protect: limit of group of kafka.
        //opts.consumer.groupId = opts.consumer.groupId || uuid.v4();
        opts.consumer.groupId = opts.consumer.groupId || 'iota-inline-test-progress-consumer';
        opts.consumer.fromOffset = 'latest';
        this.consumerGroup = new ConsumerGroup(Object.assign({}, opts.consumer, { kafkaHost: opts.kafkaHost }), opts.topics);
        this.consumerGroup.on('error', this.onError);
        this.consumerGroup.on('message', this.onTestProgress);
    }

    onTestProgress = (testProgess) => {
        let progress = undefined;
        try {
            progress = JSON.parse(testProgess.value);
        } catch (err) {
            this.logger.error(err, testProgess.value);
            return;
        }
        let thingId = progress.thingId;
        let taskId = progress.taskId;
        if (thingId && taskId) {
            let message = {};
            message.method = 'unicast';
            message.receiver = [`things/${thingId}/tests/run/${taskId}/progress`];
            message.sender = -1;
            message.targetDomain = 'console';
            message.sourceDomain = 'console';
            message.payloadType = 'testProgress';
            message.payload = testProgess.value;
            this.messageCenter.unicast(message.targetDomain, { message: message });
        }
    }

    onError = (err) => {
        this.logger.error(err);
    }
}

export default TestProgress;