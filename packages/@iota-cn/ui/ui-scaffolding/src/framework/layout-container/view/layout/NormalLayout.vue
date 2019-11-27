<template>
    <div class="ii-layout-normal">
        <div class="header">
        </div>
        <transition>
            <router-view />
        </transition>
    </div>
</template>

<script>

export default {
    props: {
        define: Object
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
.layout-normal {
    .header {
        background: #3860f4;
        color: white;
        margin-bottom: 10px;
        display: flex;
        user-select: none;

        h1 {
            margin: 5px 40px;
            display: inline-block;
        }

        .menu {
            border: none;
        }
    }
}
</style>
