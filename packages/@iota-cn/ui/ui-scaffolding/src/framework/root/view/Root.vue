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

    mounted() {
        this[T.ROOT_CHANGE_THEME](localStorage.getItem('ii:theme') || 'default')
        // @TODO change locale
    },
}
</script>

<style lang="stylus">
.ii-app {
    display: flex;
    flex-direction: column;
    height: 100%;
}
</style>
