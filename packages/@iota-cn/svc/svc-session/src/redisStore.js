import Redis from "ioredis";
import Store from "./store";

export default class RedisStore extends Store {

    constructor(opts) {
        super();
        this.key = opts.key;
        this.redis = new Redis(opts.db);

    }

    async get(sid) {
        let result = await this.redis.get(`${this.key}=${sid}`);
        return this.decode(result);
    }

    async set(session, opts) {
        if (!opts.sid) {
            opts.sid = this.getID(24);
        }
        let maxAge = 43200000;//3600*1000*12  12 hours
        if (session.maxAge) {
            maxAge = session.maxAge;
        }
        await this.redis.set(`${this.key}=${opts.sid}`, this.encode(JSON.stringify(session)), `PX`, maxAge);
        return opts.sid;
    }

    async destroy(sid) {
        return await this.redis.del(`${this.key}=${sid}`);
    }
}