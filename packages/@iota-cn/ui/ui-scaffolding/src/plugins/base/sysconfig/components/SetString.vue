<template>
    <a-row type='flex'
        class="item">
        <a-col :span="2">
            <ii-icon :type='item.widgetSettings.icon' />
        </a-col>
        <a-col :span="8">
            <a-row class="title">
                {{ item.name }}
            </a-row>
            <a-row class="hint">
                {{ item.desc }}
            </a-row>
        </a-col>
        <a-col :span="10">
            <a-row class="title">
                {{item.value||item.defaultValue}}
            </a-row>
        </a-col>
        <a-col :span="4">
            <a-row type='flex'
                justify='end'>
                <a-button type='link'
                    @click="onChange"
                    size='small'>修改</a-button>
            </a-row>
        </a-col>
        <!-- Modal -->
        <a-modal :title="`修改${item.name}`"
            :width='520'
            v-model="showModal"
            @ok="onChangeOk">
            <a-form :form="changeForm">
                <a-form-item :label="item.name"
                    :label-col="labelCol"
                    :wrapper-col="wrapperCol">
                    <a-input v-decorator="[item.key, {
                            rules: [
                                { required: true, message: `请输入${item.name}` },
                            ],
                            initialValue: item.value||item.defaultValue
                        }]"
                        :placeholder="`请输入${item.name}`">
                    </a-input>
                </a-form-item>
            </a-form>
        </a-modal>
    </a-row>
</template>
<script>
export default {
    props: ['item'],
    data() {
        return {
            labelCol: { span: 7 },
            wrapperCol: { span: 16 },
            showModal: false,
            changeForm: this.$form.createForm(this, {
                name: 'changeForm',
            }),
        }
    },
    methods: {
        onChange() {
            this.showModal = !this.showModal
            this.changeForm.resetFields()
        },
        onChangeOk() {
            this.changeForm.validateFields((err, values) => {
                if (!err) {
                    if (values[this.item.key] === this.item.value) {
                        this.showModal = false
                        return
                    }
                    this.$axios.silentPut(`/v1/api/sysconfig/${this.item.key}`, { value: values[this.item.key] }, true).then(() => {
                        this.showModal = false
                        this.updateSysconfig(values)
                    }).catch(() => {
                    })
                }
            })
        }
    }
}
</script>

<style>
</style>