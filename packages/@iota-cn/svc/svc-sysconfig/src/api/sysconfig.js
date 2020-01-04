/**
 * 更新系统配置
 */
let updateSysconfig = async function (ctx, next) {
    const models = ctx.iota.dc.models
    const key = ctx.params.key
    await models.Sysconfig.update({ value: ctx.request.body.value }, { where: { key: key } })
    ctx.status = 204
}

/**
 * 获取系统配置
 */
let fetchSysconfig = async function (ctx, next) {
    const models = ctx.iota.dc.models
    const orderBy = ctx.query.orderBy || 'index';
    const orderDirection = ctx.query.orderDirection || 'ASC';

    let settings = await models.Sysconfig.findAll({
        order: [[orderBy, orderDirection]]
    })
    if (settings) {
        ctx.status = 200
        ctx.body = { settings: settings }
    } else {
        ctx.status = 200
        ctx.body = { settings: [] }
    }
}

export {
    fetchSysconfig,
    updateSysconfig
}