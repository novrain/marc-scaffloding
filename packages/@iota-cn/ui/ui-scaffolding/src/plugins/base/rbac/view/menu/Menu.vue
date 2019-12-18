<template>
    <a-menu mode="inline"
        class="ii-console-menu"
        @select='onSelect'
        @openChange='onOpenChange'
        :selectedKeys='selectedKeys'
        :openKeys='openKeys'
        :class="collapsed?'ii-console-menu-collapsed':''"
        :inlineCollapsed="collapsed">
        <template v-for="item in menus">
            <a-menu-item v-if="!item.children || item.children.length <= 0"
                :key="item.id">
                <!-- 菜单需要统一风格 仅支持 iota 自定义菜单 -->
                <!-- 对其他 icon 方式的支持，需要考虑统一方式 -->
                <!-- <a-icon :type="'pie-chart'" /> -->
                <router-link :to='item.linkTo'
                    class="menu"
                    v-if="item.linkTo">
                    <!-- 菜单需要统一风格 仅支持 iota 自定义菜单 -->
                    <!-- 对其他 icon 方式的支持，需要考虑统一方式 -->
                    <!-- <a-icon :type="item.icon || 'pie-chart'" /> -->
                    <ii-icon :type='item.icon || "folder"' />
                    <span class="ii-menu-item">{{ item.name }}</span>
                </router-link>
                <div v-else>
                    <ii-icon :type='item.icon || "folder"' />
                    <span>{{ item.name }}</span>
                </div>
            </a-menu-item>
            <ii-sub-menu v-else
                :menus="item"
                :collapsed='collapsed'
                :key="item.id" />
        </template>
    </a-menu>
</template>

<script>
import SubMenu from './SubMenu'

export default {
    components: {
        'ii-sub-menu': SubMenu
    },
    props: {
        id: String, // 支持多实例
        containerId: String // 归属Container， 与ID 决定在store中的位置
    },
    data() {
        return {
            openKeys: [],
            selectedKeys: []
        }
    },
    mounted() {
        // 带变量的命名空间，暂时使用这种方式调用Action
        // 模块应该清楚自己所在的命名空间
        this.$store.dispatch(`iota/${this.containerId}/${this.id}/fetchMenus`).then(() => {
            this.updateMenuState()
        })
    },
    destroyed() {
        this.$clearRBACInfo()
    },
    watch: {
        $route() {
            this.updateMenuState()
        }
    },
    methods: {
        updateMenuState() {
            // 获取到数据后再刷新
            const path = this.$route.path
            if (path != '') {
                const state = this.$store.state.iota[this.containerId || 'container'][this.id || 'menu']
                const { idMap, pathMap } = state.menus
                let menu = pathMap[path]
                if (menu) {
                    let keys = [menu.id]
                    let parent = idMap[menu.parentId]
                    while (parent && parent.id) { // 
                        keys.push(parent.id)
                        parent = idMap[parent.parentId]
                    }

                    this.openKeys = this.selectedKeys = keys
                    if (this.collapsed) {
                        this.openKeys = []
                    }
                }
            }
        },
        onSelect({ selectedKeys }) {
            this.selectedKeys = selectedKeys
        },
        onOpenChange(openKeys) {
            this.openKeys = openKeys
        }
    },
    computed: {
        collapsed() {
            const state = this.$store.state.iota[this.containerId || 'container']
            return state.layout.console.left.collapsed
        },
        menus() {
            const state = this.$store.state.iota[this.containerId || 'container'][this.id || 'menu']
            return state.menus.roots[0].children
        }
    }
}
</script>

<style lang="stylus" scoped>
@import '../../../../../styles/iota/components/menu';

.ii-console-menu {
    width: 100%;

    .ant-menu-item {
        margin: $ii-console-menu-item-margin;
        font-size: 14px;
    }

    .menu {
        font-size: 16px;
        font-weight: 500;
    }

    &-collapsed {
        > .ant-menu-item .iota-icon, .ant-menu-submenu > .ant-menu-submenu-title .iota-icon {
            + span {
                display: inline-block;
                max-width: 0;
                opacity: 0;
            }
        }
    }
}
</style>>