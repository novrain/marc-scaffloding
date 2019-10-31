<template functional>
    <a-sub-menu :key="props.menuInfo.id">
        <span slot="title">
            <i :class="`iota-icon iota-icon-${props.menuInfo.icon}`" /><span>{{ props.menuInfo.name }}</span>
        </span>
        <template v-for="item in props.menuInfo.children">
            <a-menu-item v-if="!item.children || item.children.length<=0"
                :key="item.id">
                <router-link :to='item.linkTo'
                    v-if="item.linkTo">
                    <!-- 菜单需要统一风格 仅支持 iota 自定义菜单 -->
                    <!-- 对其他 icon 方式的支持，需要考虑统一方式 -->
                    <!-- <a-icon :type="item.icon || 'pie-chart'" /> -->
                    <i :class="`iota-icon iota-icon-${item.icon}`" />
                    <span>{{ item.name }}</span>
                </router-link>
                <div v-else>
                    <i :class="`iota-icon iota-icon-${item.icon}`" />
                    <span>{{ item.name }}</span>
                </div>
            </a-menu-item>
            <ii-sub-menu v-else
                :key="item.id"
                :menu-info="item" />
        </template>
    </a-sub-menu>
</template>
<script>
export default {
    props: ['menuInfo'],
};
</script>