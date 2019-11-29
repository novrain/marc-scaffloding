<template>
    <div>
        <a-form-item :label="t('fullname')"
            :label-col="labelCol"
            :wrapper-col="wrapperCol">
            <a-input v-decorator="['fullname', {
                            rules: [
                                { validator: fullNameValidator },
                            ],
                            validateFirst: true
                        }]"
                :placeholder="t('fullname')">
                <a-icon slot="prefix"
                    v-if="isSimple"
                    type="user"
                    style="color: rgba(0,0,0,.25)" />
            </a-input>
        </a-form-item>
        <a-form-item :label="t('sex')"
            :label-col="labelCol"
            :wrapper-col="wrapperCol">
            <a-radio-group name="sex">
                <a-radio :value="male">男</a-radio>
                <a-radio :value="female">女</a-radio>
            </a-radio-group>
        </a-form-item>
        <a-form-item :label="t('birthday')"
            :label-col="labelCol"
            :wrapper-col="wrapperCol">
            <a-date-picker v-decorator="['date-picker', {}]" />
        </a-form-item>
        <a-form-item :label="t('education')"
            :label-col="labelCol"
            :wrapper-col="wrapperCol">
            <a-select>
            </a-select>
        </a-form-item>
        <a-form-item :label="t('telephone')"
            :label-col="labelCol"
            :wrapper-col="wrapperCol">
            <a-input v-decorator="['telephone', {
                            rules: [
                                { validator: telephoneValidator },
                            ],
                            validateFirst: true
                        }]"
                :placeholder="t('telephone')">
                <a-icon slot="prefix"
                    v-if="isSimple"
                    type="phone"
                    style="color: rgba(0,0,0,.25)" />
            </a-input>
        </a-form-item>
</template>

<script>
export default {
    props: ['form', 'isSimple', 'user'],
    data() {
        return {
            labelCol: { span: 7 },
            wrapperCol: { span: 16 }
        }
    },
    mounted() {
        // 查询字典
        // 查询用户扩展信息
    },
    methods: {
        t(message, params) {
            return this.$t(`iota.global.authentication.${message}`, params)
        },
        fullNameValidator(rule, value, callback) {
            callback()
        },
        telephoneValidator(rule, value, callback) {
            callback()
        }
    }
}
</script>

<style>
</style>