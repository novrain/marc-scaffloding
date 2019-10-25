/**
 * Created by rain on 2017/2/17.
 */
export default function (dc) {
    const Authorization = dc.orm.define('Authorization', {
        id: {
            type: dc.ORM.STRING,
            primaryKey: true,
            defaultValue: dc.ORM.UUIDV4,
            allowNull: false
        },
        createBy: {
            type: dc.ORM.STRING
        }
    }, {
        tableName: 'Authorization'
    });
    dc.models.Authorization = Authorization;
    const ResourceGroup = dc.models.ResourceGroup;
    const UserGroup = dc.models.UserGroup;
    const Role = dc.models.Role;
    Authorization.belongsTo(UserGroup, {
        as: 'userGroup',
        foreignKey: 'userGroupId',
        onDelete: 'cascade',
        hooks: true
    });
    Authorization.belongsTo(ResourceGroup, {
        as: 'resourceGroup',
        foreignKey: 'resourceGroupId',
        onDelete: 'cascade',
        hooks: true
    });
    Authorization.belongsTo(Role, {
        as: 'role',
        foreignKey: 'roleId',
        onDelete: 'cascade',
        hooks: true
    });
    UserGroup.hasMany(Authorization, {
        as: 'authorizations',
        foreignKey: 'userGroupId',
        onDelete: 'cascade',
        hooks: true
    });
    ResourceGroup.hasMany(Authorization, {
        as: 'authorizations',
        foreignKey: 'resourceGroupId',
        onDelete: 'cascade',
        hooks: true
    });
    Role.hasMany(Authorization, {
        as: 'authorizations',
        foreignKey: 'roleId',
        onDelete: 'cascade',
        hooks: true
    });
    return Authorization;
};
