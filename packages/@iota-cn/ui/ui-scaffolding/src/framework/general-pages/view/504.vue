<template>
    <error img="/assets/imgs/504.png"
        :message="$t('iota.general-page.504.message')"
        :detail="$t('iota.general-page.504.detail')"
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