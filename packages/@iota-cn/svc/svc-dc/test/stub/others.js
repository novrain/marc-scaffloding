export default function (dc) {
    dc.models.A = dc.orm.define('a', {
        name: {
            type: dc.ORM.STRING,
            field: 'name'
        },
        desc: {
            type: dc.ORM.STRING,
            field: 'desc'
        }
    });
    dc.models.A.needNotify = true;
    dc.models.B = dc.orm.define('b', {
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