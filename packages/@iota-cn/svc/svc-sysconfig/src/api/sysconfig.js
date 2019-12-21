/**
 * 更新系统配置
 */
let updateSysconfig = async function (ctx, next) {
    const models = ctx.iota.dc.models

    // @todo 增加where 条件
    let config = await fetchSysconfig(ctx)
    if (ctx.status != 200) {
        return;
    }
    await models.Sysconfig.update(ctx.request.body, { where: { title: ctx.body.title } })
    ctx.status = 204
}

/**
 * 获取系统配置
 */
let fetchSysconfig = async function (ctx, next) {
    const models = ctx.iota.dc.models

    let sysconfig = await models.Sysconfig.findOne({})
    if (sysconfig) {
        ctx.status = 200
        ctx.body = sysconfig
    } else {
        ctx.status = 200
        ctx.body = {}
    }
}

export {
    fetchSysconfig,
    updateSysconfig
}