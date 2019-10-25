export default function (dc) {
    let MenuPreDepends = dc.orm.define('MenuPreDepends',
        {
            id: {
                type: dc.ORM.STRING,
                primaryKey: true,
                defaultValue: dc.ORM.UUIDV4,
                allowNull: false
            }
        },
        {
            tableName: 'MenuPreDepends'
        }
    );
    dc.models.MenuPreDepends = MenuPreDepends;

    let Menu = dc.models.Menu;
    Menu.belongsToMany(Menu, { through: MenuPreDepends, as: 'menus', foreignKey: 'menuId', onDelete: 'cascade', hooks: true });
    Menu.belongsToMany(Menu, { through: MenuPreDepends, as: 'depends', foreignKey: 'dependMenuId', onDelete: 'cascade', hooks: true });
    return MenuPreDepends;
}