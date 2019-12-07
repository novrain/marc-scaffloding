export default function (dc) {
    let ResourceGroup = dc.orm.define('ResourceGroup', {
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
        createBy: {
            type: dc.ORM.STRING
        }
    }, {
        tableName: 'ResourceGroup'
    });
    dc.models.ResourceGroup = ResourceGroup;
    return ResourceGroup;
};