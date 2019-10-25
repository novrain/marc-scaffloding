/**
 * Created by guan on 2017/2/16.
 */
export default function (dc) {
    let Recharge = dc.orm.define('Recharge', {
        id: {
            type: dc.ORM.STRING,
            primaryKey: true,
            defaultValue: dc.ORM.UUIDV4,
            allowNull: false
        },
        out_trade_no: {
            type: dc.ORM.STRING
        },
        fee: {
            type: dc.ORM.INTEGER
        },
        oldBalance: {
            type: dc.ORM.INTEGER,
            defaultValue: 0
        },
        newBalance: {
            type: dc.ORM.INTEGER,
            defaultValue: 0
        },
        time_start: {
            type: dc.ORM.DATE
        },
        time_end: {
            type: dc.ORM.DATE,
            allowNull: true
        },
        payChannel: {
            type: dc.ORM.STRING
        },
        paymentState: {
            type: dc.ORM.ENUM,
            allowNull: false,
            defaultValue: 'unpaid',
            values: ['prepaid', 'failure', 'unpaid']
        },
        transaction_id: {
            type: dc.ORM.STRING
        },
        bank_type: {
            type: dc.ORM.STRING
        },
        openid: {
            type: dc.ORM.STRING
        },
        product_id: {
            type: dc.ORM.STRING
        }
    }, {
            tableName: 'Recharge'
        });
    dc.models.Recharge = Recharge;
    let Account = dc.models.Account;
    Account.hasMany(Recharge, { as: 'recharges', foreignKey: 'accountId' });
    Recharge.belongsTo(Account, { as: 'account', foreignKey: 'accountId' });
    return Recharge
}