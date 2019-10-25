<template>
    <div class="ii-layout-console ii-background-color">
        <div class="left"
            :class="layout.left.collapsed ? 'left-collapsed' : ''">
            <div class="top">

            </div>
            <div class="middle">
                <component v-for="(item,i) in layout.left.middleItems"
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
                    <component v-for="(item, i) in layout.head.leftItems"
                        :key="i"
                        :is="item.component"
                        v-bind="item.props">
                    </component>
                </div>
                <div class="right">
                    <component v-for="(item, i) in layout.head.rightItems"
                        :key="i"
                        :is="item.component"
                        v-bind="item.props">
                    </component>
                </div>
            </div>
            <div class="content">
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
@import '../../../../styles/imports';

.ii-layout-console {
    display: flex;
    flex-direction: row;
    height: 100%;
    width: 100%;

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
        height: 100%;
        width: 100%;

        .header {
            display: flex;
            flex-direction: row;
            min-height: $ii-head-height;
            background-color: $ii-primary-color;

            .left {
                display: flex;
                flex-direction: row;
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
        }
    }
}
</style>
