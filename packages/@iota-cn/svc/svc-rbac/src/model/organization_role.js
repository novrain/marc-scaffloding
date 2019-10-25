export default function (dc) {
    let OrganizationRole = dc.orm.define('OrganizationRole',
        {
            id: {
                type: dc.ORM.STRING,
                primaryKey: true,
                defaultValue: dc.ORM.UUIDV4,
                allowNull: false
            },
        },
        {
            tableName: 'OrganizationRole'
        }
    );
    dc.models.OrganizationRole = OrganizationRole;

    let Organization = dc.models.Organization;
    let Role = dc.models.Role;

    Organization.belongsToMany(Role, { through: OrganizationRole, as: 'roles', foreignKey: 'organizationId', onDelete: 'cascade', hooks: true });
    Role.belongsToMany(Organization, { through: OrganizationRole, as: 'organizations', foreignKey: 'roleId', onDelete: 'cascade', hooks: true });
    OrganizationRole.belongsTo(Organization, { as: 'organization', foreignKey: 'organizationId' });
    OrganizationRole.belongsTo(Role, { as: 'role', foreignKey: 'roleId' });

    return OrganizationRole;
};