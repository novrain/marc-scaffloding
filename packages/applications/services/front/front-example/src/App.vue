<template>
    <a-config-provider :autoInsertSpaceInButton="false">
        <router-view class="ii-main-page" />
    </a-config-provider>
</template>

<script>
export default {
    data() {
        return {
        };
    }
}
</script>

<style lang="stylus">
@import '~@iota-cn/ui-scaffolding/src/styles/imports';

html, body, #app {
    height: 100%;
}

#app {
    v-box();
}

.ii-main-page {
    flex: 100% 1 1 !important;
}
</style>
