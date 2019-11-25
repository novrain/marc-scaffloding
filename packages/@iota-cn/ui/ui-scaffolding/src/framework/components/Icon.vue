<template>
    <a-icon v-if="useAntIcon"
        :type='icon' />
    <i v-else
        :class="`anticon iota-icon iota-icon-${icon}`" />
</template>

<script>
export default {
    name: 'IiIcon',
    props: {
        type: String
    },
    data() {
        let icon = this.type
        const useAntIcon = icon.indexOf('antv-') === 0
        if (useAntIcon) {
            icon = icon.replace('antv-', '')
        }
        return {
            useAntIcon: useAntIcon,
            icon
        }
    }
}
</script>

<style>
</style>