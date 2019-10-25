export default function (dc) {
    let Dashboard = dc.orm.define('Dashboard', {
        id: {
            type: dc.ORM.STRING,
            primaryKey: true,
            defaultValue: dc.ORM.UUIDV4,
            allowNull: false
        },
        colspan: {
            type: dc.ORM.STRING
        },
        height: {
            type: dc.ORM.STRING
        },
        type: {
            type: dc.ORM.STRING
        },
        source: {
            type: dc.ORM.TEXT
        },
        option: {
            type: dc.ORM.TEXT
        }
    }, {
            tableName: 'Dashboard'
        });
    dc.models.Dashboard = Dashboard;
    let User = dc.models.User;
    Dashboard.belongsTo(User, { as: 'user', foreignKey: 'userId', onDelete: 'cascade', hooks: true });
    User.hasMany(Dashboard, { as: 'dashboards', foreignKey: 'userId', onDelete: 'cascade', hooks: true });
    return Dashboard;
}