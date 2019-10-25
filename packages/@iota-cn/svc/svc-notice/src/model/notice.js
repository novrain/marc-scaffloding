import moment from 'moment';

function getExpireDate() {
    return moment(new Date()).add(90, 'd').format('YYYY-MM-DD HH:mm:ss');
}

export default function (dc) {
    let Notice = dc.orm.define('Notice', {
        id: {
            type: dc.ORM.STRING,
            primaryKey: true,
            defaultValue: dc.ORM.UUIDV4,
            allowNull: false
        },
        receiver: {
            type: dc.ORM.STRING,
            allowNull: false
        },
        sender: {
            type: dc.ORM.STRING,
            defaultValue: '-1'
        },
        title: {
            type: dc.ORM.STRING,
            allowNull: false
        },
        content: {
            type: dc.ORM.TEXT,
            allowNull: false
        },
        expireDate: {
            type: dc.ORM.DATE,
            defaultValue: getExpireDate
        }
    }, {
            tableName: 'Notice'
        });
    let NoticeType = dc.models.NoticeType;
    Notice.belongsTo(NoticeType, {
        as: 'noticeType',
        foreignKey: {
            name: 'type',
            allowNull: false
        },
    });
    dc.models.Notice = Notice;
    return Notice;
};
