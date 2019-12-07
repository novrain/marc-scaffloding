export default function (dc) {
    let ResourceOperationType = dc.orm.define('ResourceOperationType', {
        name: {
            type: dc.ORM.STRING,
            allowNull: false
        },
        desc: {
            allowNull: true,
            type: dc.ORM.STRING
        },
        type: {
            allowNull: false,
            type: dc.ORM.STRING,
            primaryKey: true
        }
    }, {
        tableName: 'ResourceOperationType'
    });

    dc.models.ResourceOperationType = ResourceOperationType;
    const ResourceType = dc.models.ResourceType;
    ResourceType.hasMany(ResourceOperationType, {
        as: 'operationTypes',
        foreignKey: 'resourceTypeKey',
        onDelete: 'cascade',
        hooks: true
    });
    ResourceOperationType.belongsTo(ResourceType, {
        as: 'resourceType',
        foreignKey: 'resourceTypeKey',
        onDelete: 'cascade',
        hooks: true
    });
    return ResourceOperationType;
}