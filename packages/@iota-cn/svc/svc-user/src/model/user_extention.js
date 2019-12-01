export default function (dc) {
    let UserExtention = dc.orm.define('UserExtention', {
        userId: {
            type: dc.ORM.STRING,
            primaryKey: true,
            allowNull: false
        },
        fullname: {
            type: dc.ORM.STRING
        },
        sex: {
            type: dc.ORM.ENUM('male', 'famale')
        },
        education: {
            type: dc.ORM.STRING
        },
        birthday: {
            type: dc.ORM.DATE
        },
        telephone: {
            type: dc.ORM.STRING
        }
    },
        {
            tableName: 'UserExtention'
        }
    );
    dc.models.UserExtention = UserExtention;
    let User = dc.models.User;

    UserExtention.belongsTo(User, { as: 'user', foreignKey: 'userId', onDelete: 'cascade', hooks: true });
    User.hasOne(UserExtention, { as: 'userExt', foreignKey: 'userId', onDelete: 'cascade', hooks: true });
    return UserExtention;
}