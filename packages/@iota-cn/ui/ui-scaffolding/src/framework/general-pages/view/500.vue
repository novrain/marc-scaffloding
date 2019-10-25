<template>
    <error img="/assets/imgs/500.png"
        :message="$t('iota.general-page.500.message')"
        :detail="$t('iota.general-page.500.detail')"
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