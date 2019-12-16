export default function (dc) {
    let EventRecord = dc.orm.define('EventRecord', {
        id: {
            type: dc.ORM.STRING,
            primaryKey: true,
            defaultValue: dc.ORM.UUIDV4,
            allowNull: false
        },
        username: {
            type: dc.ORM.STRING,
            allowNull: false
        },
        userId: {
            type: dc.ORM.STRING,
            allowNull: false
        },
        method: {
            type: dc.ORM.STRING,
            allowNull: false
        },
        host: {
            type: dc.ORM.STRING,
            allowNull: false
        },
        url: {
            type: dc.ORM.STRING,
            allowNull: false
        },
        status: {
            type: dc.ORM.STRING,
            allowNull: false
        },
        description: {
            type: dc.ORM.STRING,
            allowNull: false
        },
        exception_detail: {
            type: dc.ORM.STRING,
            allowNull: false
        },
        log_type: {
            type: dc.ORM.STRING,
            allowNull: false
        },
        request_ip: {
            type: dc.ORM.STRING,
            allowNull: false
        },
        time: {
            type: dc.ORM.STRING,
            allowNull: false
        },
        browser: {
            type: dc.ORM.STRING,
            allowNull: false
        },
        _v: {
            type: dc.ORM.STRING,
            allowNull: false
        },
    }, {
            tableName: 'EventRecord',
            updatedAt: false
    })
    dc.models.EventRecord = EventRecord

    return EventRecord
}