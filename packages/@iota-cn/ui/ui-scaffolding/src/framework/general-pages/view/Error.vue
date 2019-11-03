<template>
    <div class="ii-error-page">
        <img class="img"
            :src="img" />
        <div class="content">
            <p class="message">{{message}}</p>
            <p class="detail">{{detail}}</p>
            <a-button type="link"
                @click="onBack">{{action}}</a-button>
            <!-- <router-link :to="link">{{action}}</router-link> -->
        </div>
    </div>
</template>

<script>
export default {
    props: {
        img: [String, Object],
        message: String,
        detail: String,
        action: String,
        link: String
    },

    data() {
        return {

        }
    },

    methods: {
        onBack() {
            this.$router.push({ path: this.link })
        }
    }
}
</script>

<style lang="stylus" scoped>
@import '../../../styles/imports';

.ii-error-page {
    display: flex;
    flex-direction: row;
    min-width: 900px;
    margin: 0 auto;
    justify-content: center;
    align-items: center;
    height: 100%;

    .img {
    }

    .content {
        display: flex;
        flex-direction: column;
        justify-content: left;
        margin: 0 20px;

        .message {
            font-size: 70px;
            color: $ii-danger-300;
        }

        .detail {
            font-size: 16px;
            margin: 0 0 16px 16px;
            color: $ii-gray-400;
        }

        .backTo {
        }
    }
}
</style>