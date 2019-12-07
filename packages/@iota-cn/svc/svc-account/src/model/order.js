export default function (dc) {
    let Order = dc.orm.define('Order', {
        id: {
            type: dc.ORM.STRING,
            primaryKey: true,
            defaultValue: dc.ORM.UUIDV4,
            allowNull: false
        },
        out_trade_no: {
            type: dc.ORM.STRING
        },
        service_name: {
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
        time_start: {//交易创建时间
            type: dc.ORM.DATE
        },
        time_end: {//订单付款完成时间
            type: dc.ORM.DATE,
            allowNull: true
        },
        payChannel: {
            type: dc.ORM.STRING
        },
        paymentState: {
            type: dc.ORM.ENUM,
            values: ['prepaid', 'failure', 'unpaid'],
            defaultValue: 'unpaid'
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
        standard: {
            type: dc.ORM.STRING
        },
        product_id: {
            type: dc.ORM.STRING
        },
        beginTime: {//服务开始时间
            type: dc.ORM.DATE
        },
        endTime: {//服务结束
            type: dc.ORM.DATE,
            allowNull: true
        }
    }, {
        tableName: 'Order'
    });
    dc.models.Order = Order;
    let Account = dc.models.Account;
    Account.hasMany(Order, { as: 'orders', foreignKey: 'accountId', onDelete: 'cascade', hooks: true });
    Order.belongsTo(Account, { as: 'account', foreignKey: 'accountId', onDelete: 'cascade', hooks: true });
    let ServicePackage = dc.models.ServicePackage;
    ServicePackage.hasMany(Order, { as: 'orders', foreignKey: 'servicePackageId', onDelete: 'cascade', hooks: true });
    Order.belongsTo(ServicePackage, { as: 'service', foreignKey: 'servicePackageId', onDelete: 'cascade', hooks: true });
    return Order
}