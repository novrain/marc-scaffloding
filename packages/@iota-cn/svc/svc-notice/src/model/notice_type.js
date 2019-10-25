export default function (dc) {
    let NoticeType = dc.orm.define('NoticeType', {
        id: {
            type: dc.ORM.STRING,
            allowNull: false,
            primaryKey: true
        },
        name: {
            type: dc.ORM.STRING,
            allowNull: false
        },
        desc: {
            type: dc.ORM.STRING
        }
    }, {
            tableName: 'NoticeType'
        });
    dc.models.NoticeType = NoticeType;
    return NoticeType;
};