import ncformCommon from '@ncform/ncform-common'

class RegExpRule extends ncformCommon.ValidationRule {
    constructor(props) {
        super(props)
        this.name = 'iiregexp'
    }

    validateLogic(val, ruleVal) {
        let reg = new RegExp(ruleVal)
        return reg.test(val)
    }
}

export default {
    iiregexp: RegExpRule
}