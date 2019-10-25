/**
 * Created by rain on 2016/9/13.
 */
class Validator {
    static nameHelp = '支持1-40位非空格字符'
    static commonStrHelp = '支持1-40位非空格字符'
    static versionHelp = "支持1-40位非空格字符"
    static descHelp = "描述不符合要求(最长140个字符)"
    static precisioHelp = "精度不符合要求(支持1-6位整型、浮点型数据)"
    static intHelp = "最多支持32位整型数据"
    static positiveIntHelp = "数据不符合要求(支持0和1-6位的正整数)"
    static floatHelp = "最多支持小数点前后32位浮点型数据"
    static stringHelp = "数据不符合要求(最长140个字符)"
    static userNameHelp = '支持2-24位中文、英文、数字、“-”、“_”'
    static cardIdHelp = "身份证不符合要求(请输入正确有效的身份证号)"

    static isUserName(value) {
        const regex = /^([\u4E00-\u9fa5]|\w|[-]){2,24}$/
        return regex.test(value)
    }

    static isRoleName(value) {
        const regex = /^([\u2E80-\u9FFF]|\w| ){2,16}$/
        return regex.test(value)
    }

    static isRoleDesc(value) {
        const regex = /^.{3,50}$/
        return regex.test(value)
    }

    static isPassword(value) {
        const regex = /^\w{6,16}$/
        return regex.test(value)
    }

    static isPhone(value) {
        const regex = /^1\d{10}$/
        return regex.test(value)
    }

    static isEmail(value) {
        //regex which from html5 email type input.
        const regex = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
        return regex.test(value)
    }

    static isAppName(value) {
        const regex = /^([\u2E80-\u9FFF]|\w| ){2,11}$/
        return regex.test(value)
    }

    static isCommonName(value) {
        const regex = /^[^\s]+(\s*[^\s]+)*$/
        // const regex = /^\S{1,20}$/
        return regex.test(value) && (value !== undefined ? value.length <= 40 : true)
    }

    static isCommonVersion(value) {
        const regex = /^[^\s]+(\s*[^\s]+)*$/
        // const regex = /^\S{1,20}$/
        return regex.test(value) && (value !== undefined ? value.length <= 40 : true)
    }

    static isCommonDesc(value) {
        const regex = /^(.|\n){0,140}$/
        return regex.test(value)
    }

    static isCommonPrecision(value) {
        const regex = /^\d{1,6}$/
        return regex.test(value)
    }

    static isCommonInt(value) {
        const regex = /^[+-]?([1-9]{1,1}[0-9]{0,31}|0)$/
        return regex.test(value)
    }

    static isCommonFloat(value) {
        const regex = /^([+-]?([1-9]{1,1}[0-9]{0,31}|0))(\.\d{1,32})?$/
        return regex.test(value)
    }

    static isCommonString(value) {
        const regex = /^.{0,140}$/
        return regex.test(value)
    }

    static isCardId(value) {
        const regex = /(^\d{15}$)|(^\d{17}([0-9]|X)$)/
        return regex.test(value)
    }

}

export default Validator;
