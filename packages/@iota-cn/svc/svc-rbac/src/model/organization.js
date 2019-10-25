export default function (dc) {
    let Organization = dc.orm.define('Organization',
        {
            id: {
                type: dc.ORM.STRING,
                primaryKey: true,
                defaultValue: dc.ORM.UUIDV4,
                allowNull: false
            },
            name: {
                type: dc.ORM.STRING,
                allowNull: false
            },
            desc: {
                type: dc.ORM.STRING
            },
            belongTo: {
                type: dc.ORM.STRING,
                allowNull: true
            }
        },
        {
            tableName: 'Organization'
        }
    );
    dc.models.Organization = Organization;
    Organization.hasOne(Organization, {
        as: 'parent',
        foreignKey: {
            name: 'parentId',
            allowNull: true
        },
        onDelete: 'cascade',
        hooks: true
    });
    return Organization;
}