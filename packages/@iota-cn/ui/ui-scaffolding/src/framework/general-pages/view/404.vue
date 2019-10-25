<template>
    <error img="/assets/imgs/404.png"
        :message="$t('iota.general-page.404.message')"
        :detail="$t('iota.general-page.404.detail')"
        :action="$t('iota.general-page.back')"
        :link="link" />
</template>

<script>
import Error from './Error'
export default {
    props: {
        link: String
    },
    components: {
        error: Error
    }
}
</script>

<style lang="stylus" scoped></style>