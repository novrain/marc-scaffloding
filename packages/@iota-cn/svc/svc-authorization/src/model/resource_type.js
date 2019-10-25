/**
 * Created by rain on 2017/2/17.
 */
import RSKeys, { RSKeyArray } from './resource_keys';

export default function (dc) {
    let ResourceType = dc.orm.define('ResourceType', {
        name: {
            type: dc.ORM.STRING,
            allowNull: false
        },
        type: {
            type: dc.ORM.STRING,
            allowNull: false,
            primaryKey: true
        },
        desc: {
            allowNull: false,
            type: dc.ORM.STRING
        },
        model: {
            allowNull: false,
            type: dc.ORM.STRING
        },
        nameField: {
            type: dc.ORM.STRING,
            defaultValue: 'name'
        },
        idField: {
            type: dc.ORM.STRING,
            defaultValue: 'id'
        },
        descField: {
            type: dc.ORM.STRING,
            defaultValue: 'desc'
        },
        key: {
            allowNull: false,
            type: dc.ORM.STRING
        },
        url: {
            allowNull: false,
            type: dc.ORM.STRING
        },
        shareable: {
            type: dc.ORM.BOOLEAN,
            defaultValue: true
        }
    }, {
            tableName: 'ResourceType'
        });

    ResourceType.RSkeys = RSKeys;
    dc.models.ResourceType = ResourceType;
    return ResourceType;
};

