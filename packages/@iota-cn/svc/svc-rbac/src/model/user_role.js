export default function (dc) {
    let UserRole = dc.orm.define('UserRole',
        {
            id: {
                type: dc.ORM.STRING,
                primaryKey: true,
                defaultValue: dc.ORM.UUIDV4,
                allowNull: false
            },
        },
        {
            tableName: 'UserRole'
        }
    );
    dc.models.UserRole = UserRole;

    let User = dc.models.User;
    let Role = dc.models.Role;

    User.belongsToMany(Role, { through: UserRole, as: 'roles', foreignKey: 'userId', onDelete: 'cascade', hooks: true });
    Role.belongsToMany(User, { through: UserRole, as: 'users', foreignKey: 'roleId', onDelete: 'cascade', hooks: true });
    UserRole.belongsTo(Role, { as: 'role', foreignKey: 'roleId' });
    UserRole.belongsTo(User, { as: 'user', foreignKey: 'userId' });
    Role.hasMany(UserRole, { as: 'userMembers', foreignKey: 'roleId' })

    return UserRole;
};