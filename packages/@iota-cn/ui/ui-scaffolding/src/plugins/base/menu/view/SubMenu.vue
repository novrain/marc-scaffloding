<template functional>
    <a-sub-menu :key="props.menus.id"
        class="ii-sub-menu">
        <span slot="title">
            <ii-icon :type='props.menus.icon || "folder"' />
            <span class="ii-menu">{{ props.menus.name }}</span>
        </span>
        <template v-for="item in props.menus.children">
            <a-menu-item v-if="(!item.children || item.children.length <= 0) && !collapsed"
                :key="item.id">
                <router-link :to='item.linkTo'
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
                :key="item.id"
                :collapsed='collapsed'
                :menus="item" />
        </template>
    </a-sub-menu>
</template>
<script>
export default {
    props: ['menus', 'collapsed'],
};
</script>

<style lang="stylus" scoped>
.ii-sub-menu {
    div {
        span {
            > .iota-icon {
                font-size: 16px;
                font-weight: 500;
            }
        }
    }

    .ii-menu {
        font-size: 15px;
        font-weight: 500;
    }
}

.ii-menu-item {
    font-size: 14px;
    margin-left: 5px;
}

.hidden {
    // display: none;
}
</style>