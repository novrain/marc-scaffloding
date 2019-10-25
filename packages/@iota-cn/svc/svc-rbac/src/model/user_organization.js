export default function (dc) {
    let UserOrganization = dc.orm.define('UserOrganization',
        {
            id: {
                type: dc.ORM.STRING,
                primaryKey: true,
                defaultValue: dc.ORM.UUIDV4,
                allowNull: false
            },
        },
        {
            tableName: 'UserOrganization'
        }
    );
    dc.models.UserOrganization = UserOrganization;

    let User = dc.models.User;
    let Organization = dc.models.Organization;

    User.belongsToMany(Organization, { through: UserOrganization, as: 'organizations', foreignKey: 'userId', onDelete: 'cascade', hooks: true });
    Organization.belongsToMany(User, { through: UserOrganization, as: 'users', foreignKey: 'organizationId', onDelete: 'cascade', hooks: true });
    UserOrganization.belongsTo(Organization, { as: 'organization', foreignKey: 'organizationId' });
    UserOrganization.belongsTo(User, { as: 'user', foreignKey: 'userId' });
    Organization.hasMany(UserOrganization, { as: 'members', foreignKey: 'organizationId' })

    return UserOrganization;
};