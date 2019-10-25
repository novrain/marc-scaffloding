/**
 * Created by rain on 2017/2/17.
 */

export default function (dc) {
    let Permission = dc.orm.define('Permission', {
        id: {
            type: dc.ORM.STRING,
            primaryKey: true,
            defaultValue: dc.ORM.UUIDV4,
            allowNull: false
        }
    }, {
        tableName: 'Permission'
    });

    dc.models.Permission = Permission;
    const ResourceType = dc.models.ResourceType;
    const ResourceOperationType = dc.models.ResourceOperationType;
    const Role = dc.models.Role;
    Role.hasMany(Permission, {as: 'permissions', foreignKey: 'roleId', onDelete: 'cascade', hooks: true});
    Permission.belongsTo(ResourceType, {
        as: 'resourceType',
        foreignKey: 'resourceTypeKey',
        onDelete: 'cascade',
        hooks: true
    });
    Permission.belongsTo(ResourceOperationType, {
        as: 'operationType',
        foreignKey: 'operationTypeKey',
        onDelete: 'cascade',
        hooks: true
    });
    return Permission;
};