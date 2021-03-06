export default function (dc) {
    let Account = dc.orm.define('Account', {
        userId: {
            type: dc.ORM.STRING,
            primaryKey: true,
            allowNull: false
        },
        balance: {
            type: dc.ORM.INTEGER,
            allowNull: true
        }
    }, {
        tableName: 'Account'
    });
    dc.models.Account = Account;
    let User = dc.models.User;
    Account.belongsTo(User, { as: 'user', foreignKey: 'userId', onDelete: 'cascade', hooks: true });
    User.hasOne(Account, { as: 'account', foreignKey: 'userId', onDelete: 'cascade', hooks: true });
    return Account;
}
