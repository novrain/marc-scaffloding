<script>
import { Validator } from '@iota-cn/util-validation'
import { Form as AForm, Input as AInput } from 'ant-design-vue'
export default {
    name: 'IiNameValidatorItem',
    props: ['data', 'formOptions', 'autoFocus', 'label', 'required', 'form'],

    methods: {
        checkName(rule, value, callback) {
            if (value === '') {
                callback();
            }
            if (!Validator.isCommonName(value)) {
                callback(this.$t('iota.frame.validator.commonStrHelp'))
            } else {
                callback();
            }
        }
    },

    render() {
        const formOptions = this.formOptions ? this.formOptions : {
            props: {
                labelCol: { span: 8 },
                wrapperCol: { span: 16 }
            }
        };
        const { getFieldDecorator } = this.form;
        let value = this.data;
        let field = this.field ? this.field : 'name';
        let label = this.label ? this.label : this.$t('iota.frame.components.common.name');
        return (
            <AForm.Item
                {...formOptions}
                hasFeedback
                label={label}
            >
                {getFieldDecorator(field, {
                    rules: [{
                        required: this.required,
                        message: this.$t('iota.frame.components.common.enterWhat', { what: label })
                    }, {
                        validator: this.checkName
                    }],
                    initialValue: value
                })(
                    <AInput
                        type="text"
                        placeholder={`${label}(${this.$t('iota.frame.validator.commonStrHelp')})`}
                        maxLength="20"
                        autoFocus={this.autoFocus}
                    />
                )}
            </AForm.Item>
        )
    }
}
</script>

<style>
</style>