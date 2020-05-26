<template>
    <div class="ii-layout-console">
        <div class="left"
            :class="layout.left.collapsed ? 'left-collapsed' : ''">
            <div class="top">
                <div class="default-logo">
                    <img v-if='!layout.left.top.hiddenDefault'
                        :src="layout.left.collapsed ? $settings.consoleCollapsedLogo: $settings.consoleLogo">
                </div>
            </div>
            <div class="middle">
                <component v-for="(item,i) in layout.left.middle.items"
                    :key="i"
                    :is="item.component"
                    v-bind="item.props">
                </component>
            </div>
            <div class="bottom">
            </div>
        </div>
        <div class="main">
            <div class="header">
                <div class="h-left">
                    <component v-for="(item, i) in layout.head.left.items"
                        :key="i"
                        :is="item.component"
                        v-bind="item.props">
                    </component>
                    <span class="system-title">{{$settings.title}}</span>
                </div>
                <div class="h-middle">
                </div>
                <div class="h-right">
                    <component v-for="(item, i) in layout.head.right.items"
                        :key="i"
                        :is="item.component"
                        v-bind="item.props">
                    </component>
                </div>
            </div>
            <!-- 标签导航 -->
            <div class="navigation">
                <div class="n-toolbar">
                    <component v-for="(item, i) in layout.navigation.bar.items"
                        :key="i"
                        :is="item.component"
                        v-bind="item.props" />
                </div>
            </div>
            <div class="ii-background-color content">
                <transition name="fade-transform"
                    mode="out-in">
                    <keep-alive :include="cachedViews">
                        <router-view :key="key"
                            v-if="isRouterAlive" />
                    </keep-alive>
                </transition>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    provide() {
        return { reload: this.reload }
    },
    props: {
        layout: Object
    },

    data() {
        return {
            isRouterAlive: true
        };
    },

    mounted() {
    },

    methods: {
        reload() {
            this.isRouterAlive = false;
            this.$nextTick(function () {
                this.isRouterAlive = true;
            });
        }
    },

    computed: {
        cachedViews() {
            return this.$store.state.iota['console'].cachedViews
        },
        key() {
            return this.$route.fullpath
        }
    }
}
</script>
<style lang="stylus">
@import '../../../../styles/base';
</style>

<style lang="stylus" scoped>
@import '../../../../styles/imports';

.ii-layout-console {
    display: flex;
    flex-direction: row;
    height: 100%;
    width: 100%;
    overflow: hidden;

    .left {
        display: flex;
        width: 200px;
        flex-direction: column;
        box-shadow: $ii-box-shadow-light;

        &-collapsed {
            width: 80px;
        }

        .top {
            display: flex;
            flex-direction: row;
            height: $ii-head-height;
            background-color: darken($ii-primary-color, 20%);
            justify-content: center;
            align-items: center;

            .default-logo {
                width: calc(100% - 4px);
                height: calc(100% - 4px);
                margin: 2px;
                position: relative;

                img {
                    max-width: 100%;
                    max-height: 100%;
                    margin: auto;
                    position: absolute;
                    top: 0;
                    left: 0;
                    bottom: 0;
                    right: 0;
                }

                &-collapsed {
                }
            }
        }

        .middle {
            display: flex;
            flex-direction: column;
            flex: 1;
            overflow-y: auto;
        }

        .bottom {
            display: flex;
            flex-direction: row;
        }
    }

    .main {
        display: flex;
        flex-direction: column;
        flex: 1;
        overflow: hidden;

        .header {
            display: flex;
            flex-direction: row;
            min-height: $ii-head-height;
            background-color: $ii-primary-color;
            justify-content: space-between;

            .h-left {
                display: flex;
                flex-direction: row;
                align-items: center;

                .system-title {
                    margin: 0 10px;
                    font-size: 18px;
                    color: white;
                    line-height: 40px;
                }
            }

            .h-middle {
                display: flex;
                flex-direction: row;
                flex: 1;
            }

            .h-right {
                display: flex;
                flex-direction: row;
            }
        }

        .navigation {
            padding: 0px 0px;
        }

        .content {
            display: flex;
            flex: 1;
            flex-direction: row;
            overflow: auto;
            padding: 10px;
        }
    }
}
</style>
