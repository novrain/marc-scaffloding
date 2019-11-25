export default function (dc) {
    let CommunistPartyProcessCategory = dc.orm.define('CommunistPartyProcessCategory',
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
            desc: {
                type: dc.ORM.STRING
            },
            index: {
                type: dc.ORM.INTEGER,
            },
            // key: {
            //     type: dc.ORM.STRING,
            //     allowNull: false,
            //     unique: true
            // },
            belongTo: {
                type: dc.ORM.STRING,
                allowNull: true
            }
        },
        {
            tableName: 'CommunistPartyProcessCategory'
        }
    );
    dc.models.CommunistPartyProcessCategory = CommunistPartyProcessCategory;
    CommunistPartyProcessCategory.hasOne(CommunistPartyProcessCategory, {
        as: 'parent',
        foreignKey: {
            name: 'parentId',
            allowNull: true
        },
        onDelete: 'cascade',
        hooks: true
    });
    return CommunistPartyProcessCategory;
}