import { OAuth2PlatArray } from './oauth2plat';

export default function (dc) {
    let UserOAuth2 = dc.orm.define('userOAuth2', {
        id: {
            type: dc.ORM.STRING,
            primaryKey: true,
            defaultValue: dc.ORM.UUIDV4,
            allowNull: false
        },
        platform: {
            type: dc.ORM.ENUM(...OAuth2PlatArray),
            allowNull: false
        },
        openId: {
            type: dc.ORM.STRING,
            allowNull: false
        }
    }, {
        tableName: 'UserOAuth2'
    });
    dc.models.UserOAuth2 = UserOAuth2;

    let User = dc.models.User;
    // User has different AUTH2 platform
    User.hasMany(UserOAuth2, { as: 'oauth2s', foreignKey: 'userId' });
    return UserOAuth2;
};
