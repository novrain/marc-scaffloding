<template functional>
    <a-sub-menu :key="props.menuInfo.id">
        <span slot="title">
            <a-icon :type="props.menuInfo.icon || 'folder'" /><span>{{ props.menuInfo.name }}</span>
        </span>
        <template v-for="item in props.menuInfo.children">
            <a-menu-item v-if="!item.children || item.children.length<=0"
                :key="item.id">
                <router-link :to='item.linkTo'
                    v-if="item.linkTo">
                    <a-icon :type="item.icon || 'file'" />
                    <span>{{ item.name }}</span>
                </router-link>
                <div v-else>
                    <a-icon :type="item.icon || 'file'" />
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