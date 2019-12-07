export default function (dc) {
    dc.models.Role = dc.orm.define('role', {
        name: {
            type: dc.ORM.STRING,
            field: 'name'
        },
        desc: {
            type: dc.ORM.STRING,
            field: 'desc'
        }
    });
    dc.models.User = dc.orm.define('user', {
        name: {
            type: dc.ORM.STRING,
            field: 'name'
        },
        password: {
            type: dc.ORM.STRING,
            field: 'password'
        },
        mobile: {
            type: dc.ORM.STRING,
            field: 'mobile'
        },
        email: {
            type: dc.ORM.STRING,
            field: 'email'
        },
        apikey: {
            type: dc.ORM.STRING,
            field: 'apikey'
        },
        enable: {
            type: dc.ORM.BOOLEAN,
            field: 'enable'
        },
        creator: {
            type: dc.ORM.INTEGER,
            field: 'creator'
        }
    });
    var UserRole = dc.orm.define('UserRole', {}, {
        tableName: 'UserRole'
    });
    dc.models.UserRole = UserRole;
    dc.models.UserRole.needNotify = true;

    var User = dc.models.User;
    var Role = dc.models.Role;

    User.belongsToMany(Role, { through: UserRole, as: 'roles', foreignKey: 'userId' });
    Role.belongsToMany(User, { through: UserRole, as: 'users', foreignKey: 'roleId' });
};