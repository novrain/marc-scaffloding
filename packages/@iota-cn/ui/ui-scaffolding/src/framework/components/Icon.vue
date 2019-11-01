<template>
    <i :class="`anticon iota-icon iota-icon-${type}`" />
</template>

<script>
export default {
    name: 'ii-icon',
    props: {
        type: String
    }
}
</script>

<style>
</style>