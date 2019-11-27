<template>
    <div>
        <a-form-item :label="t('password')"
            v-if='isChange'
            :label-col="labelCol"
            :wrapper-col="wrapperCol">
            <a-input v-decorator="['password', {
                            rules: [
                                { required: true, message: t('emptyWhat', {what:t('password')}) },
                                { validator: passwordValidator },
                            ],
                            validateFirst: true
                        }]"
                type='password'
                :placeholder="t('password')">
                <a-icon slot="prefix"
                    v-if="isSimple"
                    type="lock"
                    style="color: rgba(0,0,0,.25)" />
            </a-input>
        </a-form-item>
        <a-form-item :label="isSimple? undefined : t('newPassword')"
            :label-col="labelCol"
            :wrapper-col="wrapperCol">
            <a-input v-decorator="['newPassword', {
                            rules: [
                                { required: true, message: t('emptyWhat', {what:t('newPassword')}) },
                                { validator: newPasswordValidator },
                            ],
                            validateFirst: true
                        }]"
                type='password'
                :placeholder="t('newPassword')">
                <a-icon slot="prefix"
                    v-if="isSimple"
                    type="lock"
                    style="color: rgba(0,0,0,.25)" />
            </a-input>
        </a-form-item>
        <a-form-item :label="isSimple? undefined : t('repeatPassword')"
            :label-col="labelCol"
            :wrapper-col="wrapperCol">
            <a-input v-decorator="['repeatPassword', {
                            rules: [
                                { required: true, message: t('emptyWhat', {what:t('repeatPassword')}) },
                                { validator: repeatPasswordValidator },
                            ],
                            validateFirst: true
                        }]"
                type='password'
                :placeholder="t('repeatPassword')">
                <a-icon slot="prefix"
                    v-if="isSimple"
                    type="lock"
                    style="color: rgba(0,0,0,.25)" />
            </a-input>
        </a-form-item>
    </div>
</template>

<script>
import { Validator } from '@iota-cn/util-validation'

export default {
    props: ['isChange', 'type', 'form'],
    data() {
        if (this.type === 'simple') {
            return {
                labelCol: {},
                wrapperCol: {},
            }
        }
        return {
            labelCol: { span: 7 },
            wrapperCol: { span: 16 }
        }
    },
    computed: {
        isSimple() {
            return this.type === 'simple'
        }
    },
    methods: {
        t(message, params) {
            return this.$t(`iota.global.authentication.${message}`, params)
        },
        // eslint-disable-next-line
        passwordValidator(rule, value, callback) {
            if (!Validator.isPassword(value)) {
                callback(this.t('invalidPassword'))
                return
            }
            const newPassword = this.form.getFieldValue('newPassword')
            if (value === newPassword) {
                let samePasswordError = { message: this.t('samePassword'), field: 'newPassword' };
                this.form.setFields({ 'newPassword': { value: newPassword, errors: [samePasswordError] } })
            } else {
                this.form.setFields({ 'newPassword': { value: newPassword, errors: undefined } })
            }
            callback()
        },
        // eslint-disable-next-line
        newPasswordValidator(rule, value, callback) {
            if (!Validator.isPassword(value)) {
                callback(this.t('invalidPassword'))
                return
            }
            if (this.isChange) {
                const password = this.form.getFieldValue('password')
                if (value === password) {
                    callback(this.t('samePassword'))
                    return
                }
            }
            const repeatPassword = this.form.getFieldValue('repeatPassword')
            if (Validator.isPassword(repeatPassword)) {
                if (value !== repeatPassword && Validator.isPassword(repeatPassword)) {
                    let repeatPasswordError = { message: this.t('diffRepeatPassword'), field: 'repeatPassword' };
                    this.form.setFields({ 'repeatPassword': { value: repeatPassword, errors: repeatPasswordError } })
                } else {
                    this.form.setFields({ 'repeatPassword': { value: repeatPassword, errors: undefined } })
                }
            }
            callback()
        },
        // eslint-disable-next-line
        repeatPasswordValidator(rule, value, callback) {
            if (!Validator.isPassword(value)) {
                callback(this.t('invalidPassword'))
                return
            }
            const newPassword = this.form.getFieldValue('newPassword')
            if (value !== newPassword) {
                callback(this.t('diffRepeatPassword'))
                return
            }
            callback()
        },
    }
}
</script>
