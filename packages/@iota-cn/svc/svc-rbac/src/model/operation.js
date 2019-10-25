export default function (dc) {
    let Operation = dc.orm.define('Operation',
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
            key: {
                type: dc.ORM.STRING,
                allowNull: false
            },
            method: {
                type: dc.ORM.STRING,
                defaultValue: 'GET'
            },
            verify: {
                type: dc.ORM.STRING,
                defaultValue: true
            },
            desc: {
                type: dc.ORM.STRING
            }
        },
        {
            tableName: 'Operation'
        }
    );
    dc.models.Operation = Operation;
    Operation.hasOne(Operation, {
        as: 'parent',
        foreignKey: {
            name: 'parentId',
            allowNull: true
        },
        onDelete: 'cascade',
        hooks: true
    });
    return Operation;
}