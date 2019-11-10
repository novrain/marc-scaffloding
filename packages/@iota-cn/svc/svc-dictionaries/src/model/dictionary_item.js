export default function (dc) {
    let DictionaryItem = dc.orm.define('DictionaryItem',
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
            }
        },
        {
            tableName: 'DictionaryItem'
        }
    )
    dc.models.DictionaryItem = DictionaryItem
    let Dictionary = dc.models.Dictionary

    // DictionaryItem.belongsTo(Dictionary, {
    //     as: 'dictionary',
    //     foreignKey: 'dictionaryId',
    //     onDelete: 'cascade',
    //     hooks: true
    // })
    Dictionary.hasMany(DictionaryItem, {
        as: 'items',
        foreignKey: { name: 'dictionaryId', allowNull: false },
        onDelete: 'cascade',
        hooks: true
    })
    return DictionaryItem
}