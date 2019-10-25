export default function (dc) {
    let UserPosition = dc.orm.define('UserPosition',
        {
            id: {
                type: dc.ORM.STRING,
                primaryKey: true,
                defaultValue: dc.ORM.UUIDV4,
                allowNull: false
            },
        },
        {
            tableName: 'UserPosition'
        }
    );
    dc.models.UserPosition = UserPosition;

    let User = dc.models.User;
    let Position = dc.models.Position;

    User.belongsToMany(Position, { through: UserPosition, as: 'positions', foreignKey: 'userId', onDelete: 'cascade', hooks: true });
    Position.belongsToMany(User, { through: UserPosition, as: 'users', foreignKey: 'positionId', onDelete: 'cascade', hooks: true });
    UserPosition.belongsTo(Position, { as: 'position', foreignKey: 'positionId' });
    UserPosition.belongsTo(User, { as: 'user', foreignKey: 'userId' });
    Position.hasMany(UserPosition, { as: 'members', foreignKey: 'positionId' })

    return UserPosition;
};