import crypto from 'crypto';
import { Validator } from '@iota-cn/util-validation';
import UserTypes, { UserTypesArray } from './user_types';

function encrypt(plaintext) {
    try {
        return crypto.pbkdf2Sync(plaintext, 'IOTASALT', 10, 20, 'sha512').toString('hex');
    } catch (err) {
        return plaintext;
    }
}

function sha1() {
    const buf = crypto.randomBytes(256);
    let sha1hash = crypto.createHash('sha1');
    return sha1hash.update(buf).digest('hex');
}

function createAppKey() {
    return sha1();
}

function createAppSecret() {
    return sha1();
}

export default function (dc) {
    let User = dc.orm.define('User',
        {
            id: {
                type: dc.ORM.STRING,
                primaryKey: true,
                defaultValue: dc.ORM.UUIDV4,
                allowNull: false
            },
            username: {
                type: dc.ORM.STRING,
                allowNull: false,
                validate: { checkName: checkName }
            },
            password: {
                type: dc.ORM.STRING,
                allowNull: false,
                set: function (val) {
                    checkPassword(val);
                    this.setDataValue('password', encrypt(val));
                }
            },
            type: {
                type: dc.ORM.ENUM(...UserTypesArray),
                defaultValue: UserTypes.Master
            },
            email: {
                type: dc.ORM.STRING,
                validate: { checkEmail: checkEmail }
            },
            mobile: {
                type: dc.ORM.STRING,
                validate: { checkMobile: checkMobile }
            },
            actEmail: {
                type: dc.ORM.BOOLEAN,
                defaultValue: false
            },
            gravatar: {
                type: dc.ORM.STRING
            },
            //inner key and secret
            key: {
                type: dc.ORM.STRING,
                defaultValue: createAppKey
            },
            secret: {
                type: dc.ORM.STRING,
                defaultValue: createAppSecret
            },
            isAdmin: {
                type: dc.ORM.BOOLEAN,
                defaultValue: false
            }
        },
        {
            tableName: 'User',
            paranoid: true
        }
    );
    //trick
    User.createAppKey = createAppKey;
    User.createAppSecret = createAppSecret;
    User.UserTypes = UserTypes;
    dc.models.User = User;
    return User;
}

function checkName(value) {
    if (!Validator.isUserName(value)) {
        throw new Error(`wrong name : ${value}`)
    }
}

function checkPassword(value) {
    if (!Validator.isPassword(value)) {
        throw new Error(`wrong password : ${value}`)
    }
}

function checkMobile(value) {
    if (value && !Validator.isPhone(value)) {
        throw new Error(`wrong mobile : ${value}`)
    }
}

function checkEmail(value) {
    if (value && !Validator.isEmail(value)) {
        throw new Error(`wrong email : ${value}`)
    }
}

export {
    encrypt
}
