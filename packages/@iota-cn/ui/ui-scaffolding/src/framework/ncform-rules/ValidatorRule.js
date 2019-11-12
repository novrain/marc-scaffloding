import ncformCommon from '@ncform/ncform-common'
import { Validator } from '@iota-cn/util-validation'

class ValidatorRule extends ncformCommon.ValidationRule {
    constructor(props) {
        super(props)
        this.name = 'iivalidator'
    }

    validateLogic(val, ruleVal) {
        if (Validator[ruleVal]) {
            return Validator[ruleVal](val)
        }
        return true
    }
}

export default {
    iivalidator: ValidatorRule
}