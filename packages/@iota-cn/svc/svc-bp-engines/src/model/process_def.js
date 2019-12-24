export default function (dc) {
    let ProcessDef = dc.orm.define('ProcessDef',
        {
            processDefinitionKey: { // 与 flowable processDefinitionKey 一致
                type: dc.ORM.STRING,
                primaryKey: true,
                allowNull: false
            },
            name: {
                type: dc.ORM.STRING,
                allowNull: false
            },
            desc: {
                type: dc.ORM.STRING,
            },
            category: {
                type: dc.ORM.STRING,
            },
            formDef: {          // 存储 ncform 定义的 form，目前实现上，全程使用同一个form，根据流程的环节控制字段
                type: dc.ORM.TEXT,
                allowNull: false
            },
            helperScript: {
                type: dc.ORM.STRING
            },
            widget: {
                type: dc.ORM.STRING
            },
            component: {
                type: dc.ORM.STRING
            },
            belongTo: {
                type: dc.ORM.STRING,
                allowNull: true
            }
        },
        {
            tableName: 'ProcessDef', createdAt: false, updatedAt: false
        }
    );
    dc.models.ProcessDef = ProcessDef;
    return ProcessDef;
}