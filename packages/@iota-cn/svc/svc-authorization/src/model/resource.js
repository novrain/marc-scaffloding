export default function (dc) {
    let Resource = dc.orm.define('Resource', {
        id: {
            type: dc.ORM.STRING,
            primaryKey: true,
            defaultValue: dc.ORM.UUIDV4,
            allowNull: false
        },
        name: {
            type: dc.ORM.STRING
        },
        desc: {
            type: dc.ORM.STRING
        },
        type: {
            type: dc.ORM.STRING
        },
        key: {
            type: dc.ORM.STRING
        },
        createBy: {
            type: dc.ORM.STRING
        }
    }, {
        tableName: 'Resource'
    });

    dc.models.Resource = Resource;
    const ResourceGroup = dc.models.ResourceGroup;
    ResourceGroup.hasMany(Resource, { as: 'resources', foreignKey: 'resourceGroupId', onDelete: 'cascade', hooks: true });
    Resource.belongsTo(ResourceGroup, {
        as: 'resourceGroup',
        foreignKey: 'resourceGroupId',
        onDelete: 'cascade',
        hooks: true
    });

    return Resource;
};