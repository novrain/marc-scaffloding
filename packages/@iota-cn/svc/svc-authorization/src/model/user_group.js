export default function (dc) {
    let UserGroup = dc.orm.define('UserGroup', {
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
        tableName: 'UserGroup'
    });

    dc.models.UserGroup = UserGroup;
    return UserGroup;
};