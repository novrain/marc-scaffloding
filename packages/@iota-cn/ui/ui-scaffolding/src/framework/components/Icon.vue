<template>
    <i :class="`anticon iota-icon iota-icon-${type}`" />
</template>

<script>
export default {
    name: 'IiIcon',
    props: {
        type: String
    }
}
</script>

<style>
</style>