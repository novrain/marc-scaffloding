import { uniqueArray, valBetween } from '@iota-cn/svc-util'

export const findUsersOfOrganization = async (ctx, next) => {
    const models = ctx.iota.dc.models
    const organizationId = ctx.params.organizationId
    const limit = valBetween(ctx.query.limit, 1, 200, 20)
    const offset = parseInt(ctx.query.offset) || 0
    const orderBy = ctx.query.orderBy || 'createdAt'
    const orderDirection = ctx.query.orderDirection || 'DESC'
    let condition = {
        where: {
            organizationId: organizationId
        },
        include: [
            {
                model: models.User,
                as: 'user',
                attributes: ['id', 'username', 'email', 'type'],
                include: [
                    {
                        model: models.UserExtention,
                        as: 'userExt',
                    }
                ]
            },
        ],
        limit: limit,
        offset: offset,
        distinct: true,
        order: [[orderBy, orderDirection]]
    }
    let orgUsers = await models.UserOrganization.findAndCountAll(condition)
    let users = []
    for (let orgUser of orgUsers.rows) {
        users.push(orgUser.user)
    }
    ctx.status = 200
    ctx.body = { users: users }
}