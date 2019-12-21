export default function (dc) {
    let Sysconfig = dc.orm.define('Sysconfig',
        {
            index: {
                type: dc.ORM.INTEGER,
                allowNull: false
            },
            category: {
                type: dc.ORM.STRING
            },
            key: {
                type: dc.ORM.STRING,
                primaryKey: true,
                allowNull: false
            },
            name: {
                type: dc.ORM.STRING,
                allowNull: false
            },
            desc: {
                type: dc.ORM.STRING
            },
            value: {
                type: dc.ORM.STRING,
            },
            defaultValue: {
                type: dc.ORM.STRING,
            },
            type: {
                type: dc.ORM.STRING,
                allowNull: false
            },
            widgetSettings: {
                type: dc.ORM.STRING
            }
        },
        {
            tableName: 'Sysconfig', createdAt: false, updatedAt: false
        }
    );
    Sysconfig.removeAttribute('id');
    dc.models.Sysconfig = Sysconfig;
    return Sysconfig;
}