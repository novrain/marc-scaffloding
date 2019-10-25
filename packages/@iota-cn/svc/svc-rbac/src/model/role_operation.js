export default function (dc) {
    let RoleOperation = dc.orm.define('RoleOperation',
        {
            id: {
                type: dc.ORM.STRING,
                primaryKey: true,
                defaultValue: dc.ORM.UUIDV4,
                allowNull: false
            }
        },
        {
            tableName: 'RoleOperation'
        }
    );
    dc.models.RoleOperation = RoleOperation;

    let Role = dc.models.Role;
    let Operation = dc.models.Operation;

    Operation.belongsToMany(Role, { through: RoleOperation, as: 'roles', foreignKey: 'operationId', onDelete: 'cascade', hooks: true });
    Role.belongsToMany(Operation, { through: RoleOperation, as: 'operations', foreignKey: 'roleId', onDelete: 'cascade', hooks: true });
    RoleOperation.belongsTo(Role, { as: 'role', foreignKey: 'roleId' });
    RoleOperation.belongsTo(Operation, { as: 'operation', foreignKey: 'operationId' });
    Operation.hasMany(RoleOperation, { as: 'groups', foreignKey: 'operationId' })
    Role.hasMany(RoleOperation, { as: 'operationMembers', foreignKey: 'roleId' })
    return RoleOperation;
}