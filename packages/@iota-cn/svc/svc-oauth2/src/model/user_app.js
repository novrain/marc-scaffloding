import { AppPlatArray } from './appplat';

export default function (dc) {
    let User = dc.models.User;
    let UserApp = dc.orm.define('UserApp', {
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
        key: {
            type: dc.ORM.STRING,
            allowNull: false,
            defaultValue: User.createAppKey
        },
        secret: {
            type: dc.ORM.STRING,
            allowNull: false,
            defaultValue: User.createAppSecret
        },
        platform: {
            type: dc.ORM.ENUM(...AppPlatArray),
            allowNull: false
        },
        extInfo: {
            type: dc.ORM.STRING
        }
    }, {
        tableName: 'UserApp'
    });
    dc.models.UserApp = UserApp;
    // User has different Application
    User.hasMany(UserApp, { as: 'apps', foreignKey: 'userId' });
    return UserApp;
};
