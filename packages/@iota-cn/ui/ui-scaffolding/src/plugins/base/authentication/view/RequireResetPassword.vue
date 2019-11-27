<template>
    <a-form :form="form"
        class="ii-auth-form"
        @submit="handleSubmit">
        <span class="mark"></span>
        <h3>{{t('resetPwd')}}</h3>
        <a-form-item>
            <a-input v-decorator="['email', {
                rules: [
                    { required: true, message: t('requireEmail') },                    
                    { validator: this.checkEmail }
                    ],
                validateFirst: true
                }]"
                :placeholder="t('email')">
                <a-icon slot="prefix"
                    type="mail"
                    style="color: rgba(0,0,0,.25)" />
            </a-input>
        </a-form-item>
        <a-form-item>
            <a class="float-right"
                href="/app/signin">
                {{t('rememberPwd')}}
            </a>
            <a-button type="primary"
                html-type="submit"
                class="button">
                {{t("sentResetPwdEmail")}}
            </a-button>
        </a-form-item>
    </a-form>
</template>

<script>
import { Validator } from '@iota-cn/util-validation'

export default {
    beforeCreate() {
        this.form = this.$form.createForm(this, { name: 'reset_pwd' });
    },
    props: {
        redirect: String
    },
    methods: {
        handleSubmit(e) {
            e.preventDefault()
            this.form.validateFields((err, values) => {
                if (!err) {
                    this.$axios.silentPost('/v1/api/accounts/password/forget', { email: values.email }, true)
                        .then(() => {
                            this.$router.push({ path: '/app/reset/send/email/success' })
                        }).catch(() => {
                            this.$router.push({ path: '/app/reset/send/email/error' })
                        })
                }
            });
        },
        checkEmail(rule, value, callback) {
            if (Validator.isEmail(value)) {
                callback()
            }
            else {
                callback(this.t('invalidEmail'))
            }
        },
        t(message, params) {
            return this.$t(`iota.global.authentication.${message}`, params)
        }
    }
}
</script>

<style lang="stylus" scoped>
@import './style';
</style>