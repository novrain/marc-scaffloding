export default function (dc) {
    let Role = dc.orm.define('Role',
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
            tableName: 'Role'
        }
    );
    dc.models.Role = Role;
    return Role;
}