<template>
    <div>
        <a-form-item :label="t('fullname')"
            :label-col="labelCol"
            :wrapper-col="wrapperCol">
            <a-input v-decorator="['fullname', {
                            rules: [
                                { validator: fullNameValidator },
                            ],
                            validateFirst: true,
                            initialValue: extention.fullname
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
            <a-radio-group v-decorator="['sex', {initialValue: extention.sex}]">
                <a-radio value="male">男</a-radio>
                <a-radio value="female">女</a-radio>
            </a-radio-group>
        </a-form-item>
        <a-form-item :label="t('birthday')"
            :label-col="labelCol"
            :wrapper-col="wrapperCol">
            <a-date-picker v-decorator="['birthday', {initialValue: extention.birthday}]" />
        </a-form-item>
        <a-form-item :label="t('education')"
            :label-col="labelCol"
            :wrapper-col="wrapperCol">
            <a-select v-decorator="['education', {initialValue: extention.education}]"
                :options='eduOptions'>
            </a-select>
        </a-form-item>
        <a-form-item :label="t('telephone')"
            :label-col="labelCol"
            :wrapper-col="wrapperCol">
            <a-input v-decorator="['telephone', {
                            rules: [
                                { validator: telephoneValidator },
                            ],
                            validateFirst: true,
                            initialValue: extention.telephone
                        }]"
                :placeholder="t('telephone')">
                <a-icon slot="prefix"
                    v-if="isSimple"
                    type="phone"
                    style="color: rgba(0,0,0,.25)" />
            </a-input>
        </a-form-item>
        <slot name="item" />
    </div>
</template>

<script>
import * as U from '../util'

export default {
    props: ['form', 'isSimple', 'extention'],
    data() {
        return {
            labelCol: { span: 7 },
            wrapperCol: { span: 16 },
            //
            eduOptions: []
        }
    },
    mounted() {
        if (U.educationOptions) {
            this.eduOptions = U.educationOptions
        } else {
            this.$axios.silentGet('/v1/api/dictionaries/frame_education', true)
                .then((res) => {
                    this.eduOptions = res.data.items.map(i => {
                        return { label: i.name, value: i.key }
                    })
                    U.setEducationOptions(this.eduOptions)
                }).catch(() => { })
        }
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