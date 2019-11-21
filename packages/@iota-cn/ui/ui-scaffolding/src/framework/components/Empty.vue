<template>
    <a-empty :image='image'
        class="ii-empty-normal" />
</template>

<script>
import emptyImg from './assets/imgs/empty.svg'

export default {
    name: 'ii-empty',
    data() {
        return { image: emptyImg }
    }
}
</script>

<style lang="stylus" scoped>
.ii-empty-normal {
    margin: 32px 0;
}
</style>

<style lang="stylus" >
.ant-empty-image {
    height: 40px;
}
</style>