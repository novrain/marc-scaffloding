export default function (dc) {
    let Dictionary = dc.orm.define('Dictionary',
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
            belongTo: {
                type: dc.ORM.STRING,
                allowNull: true
            }
        },
        {
            tableName: 'Dictionary'
        }
    );
    dc.models.Dictionary = Dictionary;
    return Dictionary;
}