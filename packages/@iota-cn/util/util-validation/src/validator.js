/**
 * Created by rain on 2016/9/13.
 */
class Validator {
    static nameHelp = '支持1-40位非空格字符'
    static commonStrHelp = '支持1-40位非空格字符'
    static commonNameHelp = '支持1-40位非空格字符'
    static versionHelp = "支持1-40位非空格字符"
    static descHelp = "描述不符合要求(最长140个字符)"
    static precisioHelp = "精度不符合要求(支持1-6位整型、浮点型数据)"
    static intHelp = "最多支持32位整型数据"
    static positiveIntHelp = "数据不符合要求(支持0和1-6位的正整数)"
    static floatHelp = "最多支持小数点前后32位浮点型数据"
    static stringHelp = "数据不符合要求(最长140个字符)"
    static userNameHelp = '支持2-24位中文、英文、数字、“-”、“_”'
    static cardIdHelp = "身份证不符合要求(请输入正确有效的身份证号)"
    static userNameRegex = /^([\u4E00-\u9fa5]|\w|[-]){2,24}$/
    static roleNameRegex = /^([\u2E80-\u9FFF]|\w| ){2,16}$/
    static roleDescRegex = /^.{3,50}$/
    static passwordRegex = /^\w{6,16}$/
    static phoneRegex = /^1\d{10}$/
    static emailRegex = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    static idRegex = /(^\d{15}$)|(^\d{17}([0-9]|X)$)/
    static stringRegex = /^.{0,140}$/
    static floatRegex = /^([+-]?([1-9]{1,1}[0-9]{0,31}|0))(\.\d{1,32})?$/
    static intRegex = /^[+-]?([1-9]{1,1}[0-9]{0,31}|0)$/
    static precisionRegex = /^\d{1,6}$/
    static descRegex = /^(.|\n){0,140}$/
    static versionRegex = /^[^\s]+(\s*[^\s]+)*$/
    static appNameRegex = /^([\u2E80-\u9FFF]|\w| ){2,11}$/
    static commonRegex = /^[^\s]+(\s*[^\s]+)*$/

    static isUserName(value) {
        return Validator.userNameRegex.test(value)
    }

    static isRoleName(value) {
        return Validator.roleNameRegex.test(value)
    }

    static isRoleDesc(value) {
        return Validator.roleDescRegex.test(value)
    }

    static isPassword(value) {
        return Validator.passwordRegex.test(value)
    }

    static isPhone(value) {
        return Validator.phoneRegex.test(value)
    }

    static isEmail(value) {
        //regex which from html5 email type input.
        return Validator.emailRegex.test(value)
    }

    static isAppName(value) {
        return Validator.appNameRegex.test(value)
    }

    static isCommonName(value) {
        // static regex = /^\S{1,20}$/
        return Validator.commonRegex.test(value) && (value !== undefined ? value.length <= 40 : true)
    }

    static isCommonVersion(value) {
        // static regex = /^\S{1,20}$/
        return Validator.versionRegex.test(value) && (value !== undefined ? value.length <= 40 : true)
    }

    static isCommonDesc(value) {
        return Validator.descRegex.test(value)
    }

    static isCommonPrecision(value) {
        return Validator.precisionRegex.test(value)
    }

    static isCommonInt(value) {
        return Validator.intRegex.test(value)
    }

    static isCommonFloat(value) {
        return Validator.floatRegex.test(value)
    }

    static isCommonString(value) {
        return Validator.stringRegex.test(value)
    }

    static isCardId(value) {
        return Validator.idRegex.test(value)
    }

}

export default Validator;
