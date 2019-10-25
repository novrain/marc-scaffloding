export default function (dc) {
    let OperationPreDepends = dc.orm.define('OperationPreDepends',
        {
            id: {
                type: dc.ORM.STRING,
                primaryKey: true,
                defaultValue: dc.ORM.UUIDV4,
                allowNull: false
            }
        },
        {
            tableName: 'OperationPreDepends'
        }
    );
    dc.models.OperationPreDepends = OperationPreDepends;
    let Operation = dc.models.Operation;
    Operation.belongsToMany(Operation, { through: OperationPreDepends, as: 'operations', foreignKey: 'operationId', onDelete: 'cascade', hooks: true });
    Operation.belongsToMany(Operation, { through: OperationPreDepends, as: 'depends', foreignKey: 'dependOperationId', onDelete: 'cascade', hooks: true });
    return OperationPreDepends;
}