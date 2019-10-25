export default function (dc) {
    let Position = dc.orm.define('Position',
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
            belongTo: {
                type: dc.ORM.STRING,
                allowNull: true
            }
        },
        {
            tableName: 'Position'
        }
    );
    dc.models.Position = Position;
    Position.hasOne(Position, {
        as: 'parent',
        foreignKey: {
            name: 'parentId',
            allowNull: true
        },
        onDelete: 'cascade',
        hooks: true
    });
    return Position;
}