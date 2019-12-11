import moment from 'moment'
// const emptyRender = (text) => {
//     return text || ''
// }

const dateRender = (time) => {
    return time ? moment(time * 1).format('YYYY-MM-DD') : ''
}

export default {
    simplified({ formData }) {
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
    query({ basic, conditions }) {
        if (conditions) {
            if (conditions.fuzzyQuery) {
                basic.orVariables = basic.orVariables || []
                basic.orVariables.push({
                    name: "projectNumber",
                    value: `%${conditions.fuzzyQuery}%`,
                    operation: "like",
                    type: "string"
                })
                basic.orVariables.push({
                    name: "projectName",
                    value: `%${conditions.fuzzyQuery}%`,
                    operation: "like",
                    type: "string"
                })
                basic.orVariables.push({
                    name: "projectDescribe",
                    value: `%${conditions.fuzzyQuery}%`,
                    operation: "like",
                    type: "string"
                })
            }
        }
        return basic
    },
    queryPlaceHolder: '项目名称、编号、描述',
    //创建扩展
    create(opts) {
        const { process } = opts
        process.variables.push({ name: "contact_TaskAssignee", value: '' })
        process.variables.push({ name: 'construction_TaskAssignee', value: '', })
        process.variables.push({ name: 'finalReport_TaskAssignee', value: '' })
        process.variables.push({ name: 'payment_TaskAssignee', value: '' })
        return process
    },
    columns() {
        const columns = [
            {
                title: '年度',
                dataIndex: 'formData.projectYear',
                key: 'formData.projectYear',
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
                title: '施工费用',
                dataIndex: 'formData.constructionCost',
                key: 'formData.constructionCost',
                width: '10%',
            },
            {
                title: '设备费用',
                dataIndex: 'formData.deviceCost',
                key: 'formData.deviceCost',
                width: '10%',
            },
            // {
            //     title: '描述',
            //     dataIndex: 'formData.projectDescribe',
            //     key: 'formData.projectDescribe',
            //     customRender: emptyRender,
            //     width: '10%',
            // },
        ]
        return columns
    },
    columnsForWidage() {
        let columns = [
            {
                title: '名称',
                dataIndex: 'formData.projectName',
                key: 'formData.projectName',
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
            }
        ]
        return columns
    },
    layout: 'table'
}