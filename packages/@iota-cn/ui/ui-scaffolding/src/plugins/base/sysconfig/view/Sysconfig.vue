<template>
    <a-tabs class="ii-sys-config">
        <a-tab-pane class="basicConfig"
            key="basicConfig"
            size='small'
            tab='基础配置'
            :bordered='false'>
            <div class="settings">
                <template v-for="item in settings">
                    <component :key='item.key'
                        :is='`ii-${item.type}`'
                        :item='item' />
                </template>
            </div>
        </a-tab-pane>
        <!-- 高级配置，暂屏蔽
        <a-tab-pane class="sysExtConfig"
            key="extConfig"
            size='small'
            tab='高级配置'
            :bordered='false'>
            <a-form :form="sysExtConfigForm">

            </a-form>
        </a-tab-pane>
        -->
    </a-tabs>
</template>

<script>
import StoreHelperMixin from '../components/StoreHelperMixin'
import SetString from '../components/SetString'
import SetImage from '../components/SetImage'
import SetBoolean from '../components/SetBoolean'

export default {
    name: 'IiSysconfig',
    mixins: [StoreHelperMixin],
    components: {
        'ii-image': { mixins: [SetImage, StoreHelperMixin] },
        'ii-string': { mixins: [SetString, StoreHelperMixin] },
        'ii-boolean': { mixins: [SetBoolean, StoreHelperMixin] }
    },
    data() {
        return {
        }
    },
    mounted() {
        this.fetchSysconfig()
    },
    computed: {
        settings() {
            return this.$store.state.iota.global.sysconfig.settings
        }
    },
    methods: {
        t(message, params) {
            return this.$t(`iota.frame.plugins.sysconfig.${message}`, params)
        }
    }
}
</script>

<style lang="stylus" scoped>
@import '../../../../styles/imports';

.ii-sys-config {
    width: 100%;
    height: 100%;
    background-color: white;
    display: flex;
    flex-direction: column;

    /deep/ .ant-tabs-content {
        height: 0;
        flex: 1;
        overflow: auto;
    }

    .settings {
        background-color: white;
        min-width: 700px;
        width: 100%;
        max-width: 800px;
        margin: 0 auto;

        /deep/ .item {
            height: 80px;
            border-bottom: 1px solid $md-blue-grey-300;
            align-items: center;

            .anticon, .iota-icon {
                font-size: 20px;
                color: $primary-color;
            }

            .title {
                font-weight: 500;
            }

            .hint {
                font-size: 12px;
                color: $md-blue-grey-300;
            }

            &:last-child {
                border: none;
            }
        }
    }

    .extConfig {
        width: 100%;
        height: 100%;
        overflow-y: auto;
    }
}
</style>