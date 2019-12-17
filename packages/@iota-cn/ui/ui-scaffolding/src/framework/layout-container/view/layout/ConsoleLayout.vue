<template>
    <div class="ii-layout-console">
        <div class="left"
            :class="layout.left.collapsed ? 'left-collapsed' : ''">
            <div class="top">
                <img v-if='!layout.left.top.hiddenDefault'
                    class="default-logo"
                    :src="layout.left.collapsed ? layout.left.top.defaultLogoCollapsed: layout.left.top.defaultLogo">
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
                <div class="left">
                    <component v-for="(item, i) in layout.head.left.items"
                        :key="i"
                        :is="item.component"
                        v-bind="item.props">
                    </component>
                </div>
                <div class="right">
                    <component v-for="(item, i) in layout.head.right.items"
                        :key="i"
                        :is="item.component"
                        v-bind="item.props">
                    </component>
                </div>
            </div>
            <div class="ii-background-color content">
                <transition>
                    <router-view />
                </transition>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    props: {
        layout: Object
    },

    data() {
        return {
        }
    },

    mounted() {
    },
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
                height: 36px;

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

            .left {
                display: flex;
                flex-direction: row;
                align-items: center;
            }

            .middle {
                display: flex;
                flex-direction: row;
                flex: 1;
            }

            .right {
                display: flex;
                flex-direction: row;
            }
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
