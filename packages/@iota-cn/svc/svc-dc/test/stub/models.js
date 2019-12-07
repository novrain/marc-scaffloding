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
    dc.models.Role.notify = {
        c: true,
        d: true
    };
    dc.models.User = dc.orm.define('user', {
        username: {
            type: dc.ORM.STRING,
            field: 'username'
        },
        password: {
            type: dc.ORM.STRING,
            field: 'password'
        },
        phone: {
            type: dc.ORM.STRING,
            field: 'phone'
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
};