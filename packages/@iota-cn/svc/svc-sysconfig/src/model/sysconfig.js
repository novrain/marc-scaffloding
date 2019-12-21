export default function (dc) {
    let Sysconfig = dc.orm.define('Sysconfig',
        {
            title: {
                type: dc.ORM.STRING,
            },
            copyright: {
                type: dc.ORM.STRING,
            },
            logo: {
                type: dc.ORM.STRING,
            },
            collapsedLogo: {
                type: dc.ORM.STRING,
            },
            processInfoEditDisable: {
                type: dc.ORM.BOOLEAN,
            },
            userNameEditDisable: {
                type: dc.ORM.BOOLEAN,
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