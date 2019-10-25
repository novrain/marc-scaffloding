<template>
    <div class="ii-layout-sigle-page"
        :style="{ background: 'url(' + background + ') no-repeat center center' }">
        <div class="head">
            <img class="logo"
                :src="logo"
                v-if="!!logo" />
        </div>
        <router-view />
        <span class="copyright"
            v-if="!!copyright">{{copyright}}</span>
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

<style lang="stylus">
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
        }
    }

    .copyright {
        margin-bottom: 20px;
    }
}
</style>
