<template>
    <a-locale-provider :locale="locale">
        <div class="ii-app">
            <router-view />
        </div>
    </a-locale-provider>
</template>

<script>
import zh_CN from 'ant-design-vue/lib/locale-provider/zh_CN';
import moment from 'moment';
import 'moment/locale/zh-cn';
import * as T from '../store/mutation-types'

import { createNamespacedHelpers } from 'vuex'
const { mapMutations } = createNamespacedHelpers("iota/global")

moment.locale('zh-cn');

export default {
    data() {
        return {
            locale: zh_CN
        }
    },

    methods: {
        ...mapMutations([T.ROOT_CHANGE_THEME])
    },

    beforeCreate() {
        /**
         * 
         */
        const initActions = this.$store.state.iota.global.initActions
        initActions.forEach(action => {
            if (typeof action === 'string') {
                this.$store.dispatch(action)
            } else if (typeof action === 'object' && typeof action.action === 'string') {
                this.$store.dispatch(action.action, action.params)
            }
        })
    },

    mounted() {
        this[T.ROOT_CHANGE_THEME](localStorage.getItem('ii:theme') || 'default')
        // @TODO change locale
    },

    watch: {
        $settings: {
            handler() {
                // 设置title
                document.title = this.$settings.title
                // 设置 favorite icon
                let link = document.querySelector("link[rel*='icon']") || document.createElement('link');
                link.rel = 'icon'
                link.href = this.$settings.favicon || link.href
                document.getElementsByTagName('head')[0].appendChild(link);
            },
            immediately: true,
        }
    }
}
</script>

<style lang="stylus" scoped>
.ii-app {
    display: flex;
    flex-direction: column;
    height: 100%;
}
</style>
