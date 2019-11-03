<script>
import { Form } from 'ant-design-vue'
// import NameValidatorItem from './formitems/NameValidatorItem'
// import DescValidatorItem from './formitems/DescValidatorItem'

export default Form.create({ name: 'IiSimpleEditor' })({
    name: 'IiSimpleEditor',
    props: ['data', 'detailForm', 'disableName', 'disableDesc'],

    render() {
        let initData = this.data;
        const formOptions = {
            props: {
                labelCol: { span: 6 },
                wrapperCol: { span: 18 }
            }
        };
        const detailFormOptions = {
            props: {
                labelCol: { span: 6 },
                wrapperCol: { span: 18 }
            }
        };
        return (
            <Form class={'editor'}>
                {
                    this.disableName ? null : <IiNameValidatorItem data={initData.name}
                        form={this.form}
                        formOptions={this.detailForm ? detailFormOptions : formOptions}
                        required={true} />
                }
                {
                    this.disableDesc ? null : <IiDescValidatorItem data={initData.desc}
                        form={this.form}
                        formOptions={this.detailForm ? detailFormOptions : formOptions} />
                }
            </Form>
        )
    }
})
</script>

<style lang="stylus" scoped>
.editor {
    position: relative;
    max-width: 500px;
    margin: 0 auto;
}
</style>