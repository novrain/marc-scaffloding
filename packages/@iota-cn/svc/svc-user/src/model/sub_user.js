export default function (dc) {
    let SubUser = dc.orm.define('SubUser', {
        userId: {
            type: dc.ORM.STRING,
            primaryKey: true,
            allowNull: false
        },
        dependent: {
            type: dc.ORM.BOOLEAN,
            defaultValue: true
        },
        enable: {
            type: dc.ORM.BOOLEAN,
            defaultValue: true
        }
    },
        {
            tableName: 'SubUser'
        }
    );
    dc.models.SubUser = SubUser;
    let User = dc.models.User;

    SubUser.belongsTo(User, { as: 'parent', foreignKey: 'parentId', onDelete: 'cascade', hooks: true });
    SubUser.belongsTo(User, { as: 'user', foreignKey: 'userId', onDelete: 'cascade', hooks: true });
    User.hasOne(SubUser, { as: 'subExt', foreignKey: 'userId', onDelete: 'cascade', hooks: true });
    return SubUser;
}