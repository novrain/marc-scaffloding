import ServiceType from './service_type';

export default function (dc) {
    let ServicePackage = dc.orm.define('ServicePackage', {
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
        //@SEE ServiceType
        serviceType: {
            type: dc.ORM.STRING
        },
        desc: {
            type: dc.ORM.STRING,
            allowNull: false
        },
        specification: {
            type: dc.ORM.TEXT,
            allowNull: false
        },
        price: {
            type: dc.ORM.INTEGER,
            allowNull: false
        }
    }, {
        tableName: "ServicePackage"
    });
    ServicePackage.ServiceType = ServiceType;
    dc.models.ServicePackage = ServicePackage;
    return ServicePackage;
}