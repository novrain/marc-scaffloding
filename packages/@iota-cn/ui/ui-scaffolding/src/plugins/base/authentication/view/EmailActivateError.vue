<template>
    <a-form :form="form"
        class="ii-auth-form"
        @submit="handleSubmit">
        <span class="mark error-mark"></span>
        <h3>{{t('emailActivateError')}}</h3>
        <a-form-item>
            <p class="hint">{{t('emailActivateErrorExplain')}}</p>
        </a-form-item>
        <a-form-item>
            <a-button type="primary"
                html-type="submit"
                class="button">
                {{t("signin")}}
            </a-button>
        </a-form-item>
    </a-form>
</template>

<script>
export default {
    props: {
        redirect: String
    },
    methods: {
        handleSubmit(e) {
            e.preventDefault()
            this.$router.push({ path: '/app/signin' })
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