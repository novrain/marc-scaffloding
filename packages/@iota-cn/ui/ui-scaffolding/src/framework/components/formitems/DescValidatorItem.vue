<script>
import { Validator } from '@iota-cn/util-validation'
import { Form as AForm, Input as AInput } from 'ant-design-vue'
export default {
    name: 'IiDescValidatorItem',
    props: ['data', 'formOptions', 'form'],

    methods: {
        checkDesc(rule, value, callback) {
            if (!Validator.isCommonDesc(value)) {
                callback(Validator.descHelp)
            } else {
                callback()
            }
        }
    },

    render() {
        const formOptions = this.formOptions ? this.formOptions : {
            props: {
                labelCol: { span: 5 },
                wrapperCol: { span: 18 }
            }
        }
        const { getFieldDecorator } = this.form
        let desc = this.data ? this.data : ''
        let autosize = this.autosize ? this.autosize : { minRows: 1, maxRows: 3 }
        return (
            <AForm.Item
                {...formOptions}
                hasFeedback
                label={this.$t('iota.frame.components.common.desc')}
            >
                {getFieldDecorator('desc', {
                    rules: [{
                        validator: this.checkDesc
                    }],
                    initialValue: desc
                })(
                    <AInput.TextArea rows="3" autosize={autosize} />
                )}
            </AForm.Item>
        )
    }
}
</script>

<style>
</style>