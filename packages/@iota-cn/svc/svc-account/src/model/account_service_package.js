/**
 * Created by kadven on 2017/2/17.
 */
export default function (dc) {
    let AccountServicePackage = dc.orm.define('AccountServicePackage', {
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
        price: {
            type: dc.ORM.STRING,
            allowNull: false
        },
        specification: {
            type: dc.ORM.TEXT,
            allowNull: false
        },
        initialSpecification: {
            type: dc.ORM.TEXT,
            allowNull: false
        },
        beginTime: {
            type: dc.ORM.DATE,
        },
        endTime: {
            type: dc.ORM.DATE,
        }
    }, {
            tableName: 'AccountServicePackage'
        });

    let Account = dc.models.Account;
    let ServicePackage = dc.models.ServicePackage;
    AccountServicePackage.belongsTo(Account, {
        as: 'account',
        foreignKey: 'accountId',
        onDelete: 'cascade',
        hooks: true
    });
    AccountServicePackage.belongsTo(ServicePackage, {
        as: 'servicePackage',
        foreignKey: 'servicePackageId',
        onDelete: 'cascade',
        hooks: true
    });
    Account.hasOne(AccountServicePackage, { as: 'service', foreignKey: 'accountId', onDelete: 'cascade', hooks: true });
    dc.models.AccountServicePackage = AccountServicePackage;
    return AccountServicePackage;
}