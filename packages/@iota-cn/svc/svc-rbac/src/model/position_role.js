export default function (dc) {
    let PositionRole = dc.orm.define('PositionRole',
        {
            id: {
                type: dc.ORM.STRING,
                primaryKey: true,
                defaultValue: dc.ORM.UUIDV4,
                allowNull: false
            },
        },
        {
            tableName: 'PositionRole'
        }
    );
    dc.models.PositionRole = PositionRole;

    let Position = dc.models.Position;
    let Role = dc.models.Role;

    Position.belongsToMany(Role, { through: PositionRole, as: 'roles', foreignKey: 'positionId', onDelete: 'cascade', hooks: true });
    Role.belongsToMany(Position, { through: PositionRole, as: 'positions', foreignKey: 'roleId', onDelete: 'cascade', hooks: true });
    PositionRole.belongsTo(Position, { as: 'position', foreignKey: 'positionId' });
    PositionRole.belongsTo(Role, { as: 'role', foreignKey: 'roleId' });

    return PositionRole;
};