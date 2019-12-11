import moment from 'moment'

const dateRender = (time) => {
    return time ? moment(time * 1).format('YYYY-MM-DD') : ''
}

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
        return {
            name: `category_L${level--}_Id`,
            value: category.id
        }
    })
}

export default {
    simplified({
        formData
    }) {
        let process = ''
        if (formData.process) {
            process = `进度：${formData.process}%`
        }
        return {
            name: formData.projectName,
            summary: `编号：${formData.projectNumber} ${process}`,
            desc: formData.projectDescribe,
        }
    },
    //查询条件扩展
    query(opts) {
        const {
            basic,
            categories
        } = opts
        if (Array.isArray(categories) && categories.length > 0) {
            basic.variables = (basic.variables || []).concat(convertCategoriesToQueryVariables(categories))
        }
        return basic
    },
    //创建扩展
    create(opts) {
        const {
            process,
            categories
        } = opts
        if (Array.isArray(categories) && categories.length > 0) {
            process.variables = (process.variables || []).concat(convertCategoriesToCreateVariables(categories))
        }
        return process
    },
    queryPlaceHolder: '项目名称、编号、描述',
    columns() {
        const columns = [{
                title: '年度',
                dataIndex: 'formData.projectYear',
                key: 'formData.projectYear',
                width: '5%',
            },
            {
                title: '月份',
                dataIndex: 'formData.projectMonth',
                key: 'formData.projectMonth',
                width: '5%',
            },
            {
                title: '名称',
                dataIndex: 'formData.projectName',
                key: 'formData.projectName',
            },
            {
                title: '编号',
                dataIndex: 'formData.projectNumber',
                key: 'formData.projectNumber',
                width: '10%',
            },
            {
                title: '开始时间',
                dataIndex: 'formData.startTime',
                key: 'formData.startTime',
                width: '10%',
                customRender: dateRender
            },
            {
                title: '结束时间',
                dataIndex: 'formData.finishTime',
                key: 'formData.finishTime',
                width: '10%',
                customRender: dateRender
            },
            {
                title: '发起人',
                dataIndex: 'formData.initiatorName',
                key: 'formData.initiatorName',
                width: '5%',
            },
        ]
        return columns
    },
    columnsForWidage() {
        let columns = [{
                title: '名称',
                dataIndex: 'formData.projectName',
                key: 'formData.projectName',
            },
            {
                title: '发起人',
                dataIndex: 'formData.initiatorName',
                key: 'formData.initiatorName',
                width: '10%',
            },
            {
                title: '编号',
                dataIndex: 'formData.projectNumber',
                key: 'formData.projectNumber',
                width: '20%',
            },
            {
                title: '进度',
                dataIndex: 'formData.process',
                key: 'formData.process',
                width: '20%',
            },
        ]
        return columns
    },
    layout: 'table'
}