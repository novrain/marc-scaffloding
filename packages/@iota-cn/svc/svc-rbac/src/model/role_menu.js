export default function (dc) {
    let RoleMenu = dc.orm.define('RoleMenu',
        {
            id: {
                type: dc.ORM.STRING,
                primaryKey: true,
                defaultValue: dc.ORM.UUIDV4,
                allowNull: false
            }
        },
        {
            tableName: 'RoleMenu'
        }
    );
    dc.models.RoleMenu = RoleMenu;

    let Role = dc.models.Role;
    let Menu = dc.models.Menu;

    Menu.belongsToMany(Role, { through: RoleMenu, as: 'roles', foreignKey: 'menuId', onDelete: 'cascade', hooks: true });
    Role.belongsToMany(Menu, { through: RoleMenu, as: 'menus', foreignKey: 'roleId', onDelete: 'cascade', hooks: true });
    RoleMenu.belongsTo(Role, { as: 'role', foreignKey: 'roleId' });
    RoleMenu.belongsTo(Menu, { as: 'menu', foreignKey: 'menuId' });
    Menu.hasMany(RoleMenu, { as: 'groups', foreignKey: 'menuId' })
    Role.hasMany(RoleMenu, { as: 'members', foreignKey: 'roleId' })
    return RoleMenu;
}