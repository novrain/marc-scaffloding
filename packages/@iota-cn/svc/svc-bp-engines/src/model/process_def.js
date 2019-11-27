export default function (dc) {
    let ProcessDef = dc.orm.define('ProcessDef',
        {
            id: {
                type: dc.ORM.STRING,
                primaryKey: true,
                defaultValue: dc.ORM.UUIDV4,
                allowNull: false
            },
            name: {
                type: dc.ORM.STRING,
                allowNull: false
            },
            flowableInstance: { // 与flowable ACT_RE_PROCDEF.id 一致
                type: dc.ORM.STRING,
                allowNull: false,
                unique: true
            },
            formDef: {          // 存储 ncform 定义的 form，目前实现上，全程使用同一个form，根据流程的环节控制字段
                type: dc.ORM.TEXT,
                allowNull: false
            },
            belongTo: {
                type: dc.ORM.STRING,
                allowNull: true
            }
        },
        {
            tableName: 'ProcessDef'
        }
    );
    dc.models.ProcessDef = ProcessDef;
    return ProcessDef;
}