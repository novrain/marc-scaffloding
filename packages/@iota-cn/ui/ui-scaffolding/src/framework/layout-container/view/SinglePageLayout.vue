<template>
    <div class="ii-layout-sigle-page"
        :style="{ background: 'url(' + background + ') no-repeat center center' }">
        <div class="head">
            <img class="logo"
                :src="$settings.logo || logo"
                v-if="!!($settings.logo || logo)" />
        </div>
        <router-view />
        <span class="copyright">{{$settings.copyright || copyright}}</span>
    </div>
</template>

<script>

export default {
    props: {
        logo: [String, Object],
        background: [String],
        copyright: [String],
    },

    data() {
        return {
        }
    },

    mounted() {
    }
}

</script>

<style lang="stylus" scoped>
@import '../../../styles/imports';

.ii-layout-sigle-page {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    align-items: center;
    width: 100%;
    height: 100%;
    overflow: hidden;

    .head {
        display: flex;
        align-items: center;
        justify-content: space-between;
        width: 100%;
        height: 56px;
        padding: 0 200px;
        border-bottom: 1px solid $ii-gray-200;

        .logo {
            height: 42px;
        }
    }

    .copyright {
        margin-bottom: 20px;
    }
}
</style>
