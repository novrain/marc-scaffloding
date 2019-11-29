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
                basic.orActive = true
                basic.variables = basic.variables || []
                basic.variables.push({
                    name: "projectNumber",
                    value: `%${conditions.fuzzyQuery}%`,
                    operation: "like",
                    type: "string"
                })
                basic.variables.push({
                    name: "projectName",
                    value: `%${conditions.fuzzyQuery}%`,
                    operation: "like",
                    type: "string"
                })
                basic.variables.push({
                    name: "projectDescribe",
                    value: `%${conditions.fuzzyQuery}%`,
                    operation: "like",
                    type: "string"
                })
            }
        }
        return basic
    },
    queryPlaceHolder: '项目名称、编号、描述'
}