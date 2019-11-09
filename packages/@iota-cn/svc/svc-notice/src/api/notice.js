import { valBetween } from '@iota-cn/svc-util';

export default class Notice {

    constructor() {

    }

    async findAll(ctx, next) {
        let models = ctx.iota.dc.models;
        let limit = valBetween(ctx.query.limit, 1, 200, 20);
        let offset = parseInt(ctx.query.offset) || 0;
        let orderBy = ctx.query.orderBy || 'createdAt';
        let orderDirection = ctx.query.orderDirection || 'DESC';
        let userId = ctx.session.user.id;
        let noticeType = ctx.query.noticeType;
        let read;
        let readCondition = {
            where: {
                userId: userId
            }
        }
        let condition = {
            where: {
                receiver: { $in: [userId, '-1'] },
                expireDate: { $gt: new Date() }
            },
            limit: limit,
            offset: offset,
            order: [
                [
                    { model: models.UserNotice, as: 'userNotices' },
                    'userId', 'DESC'
                ],
                [orderBy, orderDirection]
            ],
            distinct: true,
            include: [
                {
                    where: {
                        userId: userId
                    },
                    required: false,
                    model: models.UserNotice,
                    as: "userNotices"
                }
            ]
        }
        if (noticeType) {
            condition.where = Object.assign({ type: noticeType }, condition.where);
            let userNotices = await models.UserNotice.findAndCountAll(readCondition);
            let noticeIds = [];
            userNotices.rows.map((v, i) => {
                noticeIds.push(v.get({ plain: true }).noticeId)
            })
            read = await models.Notice.count({ where: { id: { $in: noticeIds }, type: noticeType } });
        } else {
            read = await models.UserNotice.count(readCondition);
        }
        let notices = await models.Notice.findAndCountAll(condition);
        ctx.status = 200;
        ctx.body = {
            count: notices.count,
            notices: notices.rows
        }
        if (ctx.iota.restful && typeof ctx.iota.restful.createNormalizer === 'function') {
            ctx.iota.restful.createNormalizer('notices')(ctx);
        }
        ctx.body.unread = notices.count - read;
    }

    async findOne(ctx, next) {
        let id = ctx.params.id;
        let models = ctx.iota.dc.models;
        let limit = valBetween(ctx.query.limit, 1, 200, 20);
        let offset = parseInt(ctx.query.offset) || 0;
        let orderBy = ctx.query.orderBy || 'createdAt';
        let orderDirection = ctx.query.orderDirection || 'DESC';
        let userId = ctx.session.user.id;
        let condition = {
            where: {
                receiver: { $in: [userId, '-1'] },
                expireDate: { $gt: new Date() }
            },
            limit: limit,
            offset: offset,
            order: [
                [
                    { model: models.UserNotice, as: 'userNotices' },
                    'userId', 'DESC'
                ],
                [orderBy, orderDirection]
            ],
            distinct: true,
            include: [
                {
                    where: {
                        userId: userId
                    },
                    required: false,
                    model: models.UserNotice,
                    as: "userNotices"
                }
            ]
        }
        if (id) {
            condition.where.id = id + '';
            let notices = await models.Notice.findAndCountAll(condition);
            ctx.status = 200;
            ctx.body = {
                count: notices.count,
                notices: notices.rows
            }
            if (ctx.iota.restful && typeof ctx.iota.restful.createNormalizer === 'function') {
                ctx.iota.restful.createNormalizer('notices')(ctx);
            }
        } else {
            ctx.status = 404;
            ctx.body = {
                name: 'not found',
                message: 'notice dose not exist.'
            };
        }
    }

    async markRead(ctx, next) {
        const models = ctx.iota.dc.models;
        let data = ctx.request.body;
        let t = ctx.iota.session ? ctx.iota.session.transaction : undefined;
        //是否内部事务？
        let isLocalTransaction = !t;
        if (
            data &&
            data.id &&
            Array.isArray(data.id) &&
            data.id.length > 0
        ) {
            t = isLocalTransaction ? await ctx.iota.dc.orm.transaction() : t;
            let ids = data.id;
            try {
                for (let id of ids) {
                    let data = {
                        noticeId: id,
                        userId: ctx.session.user.id
                    }
                    let un = await models.UserNotice.findOne({
                        where: data
                    });
                    if (!un) {
                        await models.UserNotice.create(
                            data,
                            { transaction: t }
                        );
                    }
                }
                if (isLocalTransaction) {
                    await t.commit();
                }
                ctx.status = 204;
                ctx.body = {};
            } catch (e) {
                if (isLocalTransaction && t) {
                    await t.rollback();
                }
                ctx.status = 500;
                ctx.body = {
                    name: 'Server error',
                    message: 'An unexpected condition was encountered in the server and no more specific message is suitable.'
                };
                ctx.iota.logger.error(`path: ${ctx.path}, error: ${e}`);
            }
        } else {
            ctx.status = 400;
            ctx.body = {
                name: 'validation error',
                message: 'invalid request message framing, malformed request syntax,or deceptive request routing.',
                detail: 'lack of necessary parameters.'
            };
        }
    }

    async unread(ctx, next) {
        let models = ctx.iota.dc.models;
        let limit = valBetween(ctx.query.limit, 1, 200, 20);
        let offset = parseInt(ctx.query.offset) || 0;
        let orderBy = ctx.query.orderBy || 'createdAt';
        let orderDirection = ctx.query.orderDirection || 'DESC';
        let noticeType = ctx.query.noticeType;

        try {
            let userId = ctx.session.user.id;
            let readCondition = {
                where: {
                    userId: userId
                },
                raw: true
            }
            let read = await models.UserNotice.findAll(readCondition);

            let ids = read.map((v) => {
                return v.noticeId;
            });

            let condition = {
                where: {
                    receiver: { $in: [userId, '-1'] },
                    expireDate: { $gt: new Date() }
                },
                limit: limit,
                offset: offset,
                order: [[orderBy, orderDirection]]
            }
            if (ids.length > 0) {
                condition.where.id = { $notIn: ids }
            }
            if (noticeType) {
                condition.where = Object.assign({ type: noticeType }, condition.where);
            }
            let notices = await models.Notice.findAndCountAll(condition);

            ctx.status = 200;
            ctx.body = {
                count: notices.count,
                notices: notices.rows
            }
            if (ctx.iota.restful && typeof ctx.iota.restful.createNormalizer === 'function') {
                ctx.iota.restful.createNormalizer('notices')(ctx);
            }
        } catch (e) {
            ctx.status = 500;
            ctx.body = {
                name: 'Server error',
                message: 'An unexpected condition was encountered in the server and no more specific message is suitable.'
            };
            ctx.iota.logger.error(`path: ${ctx.path}, error: ${e}`);
        }
    }

    async read(ctx, next) {
        let models = ctx.iota.dc.models;
        let limit = valBetween(ctx.query.limit, 1, 200, 20);
        let offset = parseInt(ctx.query.offset) || 0;
        let orderBy = ctx.query.orderBy || 'createdAt';
        let orderDirection = ctx.query.orderDirection || 'DESC';
        let userId = ctx.session.user.id;
        let noticeType = ctx.query.noticeType;

        let condition = {
            where: {
                receiver: { $in: [userId, '-1'] },
                expireDate: { $gt: new Date() }
            },
            limit: limit,
            offset: offset,
            order: [[orderBy, orderDirection]],
            distinct: true,
            include: [
                {
                    where: {
                        userId: userId
                    },
                    model: models.UserNotice,
                    as: "userNotices"
                }
            ]
        }
        if (noticeType) {
            condition.where = Object.assign({ type: noticeType }, condition.where);
        }
        let notices = await models.Notice.findAndCountAll(condition);

        ctx.status = 200;
        ctx.body = {
            count: notices.count,
            notices: notices.rows
        }
        if (ctx.iota.restful && typeof ctx.iota.restful.createNormalizer === 'function') {
            ctx.iota.restful.createNormalizer('notices')(ctx);
        }
    }

}
