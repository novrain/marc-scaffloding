export default function (dc) {
    let UserNotice = dc.orm.define('UserNotice', {
        id: {
            type: dc.ORM.STRING,
            primaryKey: true,
            defaultValue: dc.ORM.UUIDV4,
            allowNull: false
        },
    }, {
            tableName: 'UserNotice'
        });
    dc.models.UserNotice = UserNotice;
    let User = dc.models.User;
    let Notice = dc.models.Notice;

    UserNotice.belongsTo(User, {
        as: 'user',
        foreignKey: {
            name: 'userId',
            allowNull: false
        },
        onDelete: 'cascade',
        hooks: true
    });
    UserNotice.belongsTo(Notice, {
        as: 'notice',
        foreignKey: {
            name: 'noticeId',
            allowNull: false
        },
        onDelete: 'cascade',
        hooks: true
    });
    Notice.hasMany(UserNotice, {
        as: 'userNotices',
        foreignKey: {
            name: 'noticeId',
            allowNull: false
        },
        onDelete: 'cascade',
        hooks: true
    });

    return UserNotice;
};
