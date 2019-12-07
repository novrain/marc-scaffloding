export default function (dc) {
    const UserGroupUser = dc.orm.define('UserGroupUser', {
        id: {
            type: dc.ORM.STRING,
            primaryKey: true,
            defaultValue: dc.ORM.UUIDV4,
            allowNull: false
        },
        type: {
            type: dc.ORM.STRING,
            allowNull: false
        },
        accept: {
            type: dc.ORM.BOOLEAN,
            defaultValue: false
        },
        invitedCode: {
            type: dc.ORM.STRING,
            allowNull: true
        },
        enable: {
            type: dc.ORM.BOOLEAN,
            defaultValue: true
        }
    }, {
        tableName: 'UserGroupUser'
    });
    dc.models.UserGroupUser = UserGroupUser;

    const UserGroup = dc.models.UserGroup;
    const User = dc.models.User;

    User.belongsToMany(UserGroup, { through: UserGroupUser, as: 'userGroups', foreignKey: 'userId' });
    User.hasMany(UserGroupUser, { as: 'groups', foreignKey: 'userId' });
    //conflict with UserGroup.hasMany...
    UserGroup.belongsToMany(User, { through: UserGroupUser, as: 'members', foreignKey: 'userGroupId' });
    UserGroup.hasMany(UserGroupUser, { as: 'users', foreignKey: 'userGroupId' });
    UserGroupUser.belongsTo(User, { as: 'user', foreignKey: 'userId' });
    UserGroupUser.belongsTo(UserGroup, { as: 'userGroup', foreignKey: 'userGroupId' });

    return UserGroupUser;
};