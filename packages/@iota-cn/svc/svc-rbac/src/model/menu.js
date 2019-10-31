export default function (dc) {
    let Menu = dc.orm.define('Menu',
        {
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
            key: {
                type: dc.ORM.STRING,
                allowNull: false
            },
            // 新增字段 界面端直接显示
            linktTo: {
                type: dc.ORM.STRING,
            },
            icon: {
                type: dc.ORM.STRING,
            },
            desc: {
                type: dc.ORM.STRING
            }
        },
        {
            tableName: 'Menu'
        }
    );
    dc.models.Menu = Menu;
    Menu.hasOne(Menu, {
        as: 'parent',
        foreignKey: {
            name: 'parentId',
            allowNull: true
        },
        onDelete: 'cascade',
        hooks: true
    });
    return Menu;
}