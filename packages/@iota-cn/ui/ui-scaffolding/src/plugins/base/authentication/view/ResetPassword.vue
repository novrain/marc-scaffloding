<template>
    <a-form :form="form"
        class="ii-auth-form"
        @submit="handleSubmit">
        <span class="mark"></span>
        <h3>{{t('resetPwd')}}</h3>
        <ii-reset-password-form type='simple'
            :form='form' />
        <a-form-item>
            <a-button type="primary"
                html-type="submit"
                class="button">
                {{t("reset")}}
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
    data() {
        return {
            id: undefined
        }
    },
    mounted() {
        if (this.$route.query && this.$route.query.id) {
            this.id = this.$route.query.id
        } else {
            this.$router.push({ path: '/app/reset/password/error' })
        }
    },
    methods: {
        handleSubmit(e) {
            e.preventDefault()
            this.form.validateFields((err, values) => {
                if (!err) {
                    this.$axios.silentPost('/v1/api/accounts/password/reset', { id: this.id, password: values.newPassword }, true)
                        .then(() => {
                            this.$router.push({ path: '/app/reset/password/success' })
                        }).catch(() => {
                            this.$router.push({ path: '/app/reset/password/error' })
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