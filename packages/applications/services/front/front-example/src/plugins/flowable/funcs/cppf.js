const convertCategoriesToQueryVariables = function (categories) {
    let level = categories.length
    return categories.map((category) => {
        return {
            name: `category_L${level--}_Id`,
            value: category.id,
            operation: "equals",
            type: "string"
        }
    })
}

const convertCategoriesToCreateVariables = function (categories) {
    let level = categories.length
    return categories.map(category => {
        return { name: `category_L${level--}_Id`, value: category.id }
    })
}

export default {
    infoOfFlow() {
        return {
            name: '从变量中获取的名字',
            desc: '从变量中获取的描述',
            summary: '从变量中获取的Summary'
        }
    },
    //查询条件扩展
    query(opts) {
        const { query, categories } = opts
        if (Array.isArray(categories) && categories.length > 0) {
            query.variables = (query.variables || []).concat(convertCategoriesToQueryVariables(categories))
        }
        return query
    },
    //创建扩展
    create(opts) {
        const { process, categories } = opts
        if (Array.isArray(categories) && categories.length > 0) {
            process.variables = (process.variables || []).concat(convertCategoriesToCreateVariables(categories))
        }
        return process
    }
}