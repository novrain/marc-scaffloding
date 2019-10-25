/**
 * Created by rain on 2017/2/17.
 */
export default function (dc) {
    let Role = dc.orm.define('Role', {
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
        tableName: 'Role'
    });

    dc.models.Role = Role;
    return Role;
};