<template>
    <a-icon class="ii-collapsed"
        :type="collapsed ? 'menu-unfold' : 'menu-fold'"
        @click='onClick' />
</template>

<script>
import * as T from '../../store/mutation-types'

export default {
    props: {
        id: String
    },

    methods: {
        onClick() {
            this.$store.commit(`iota/${this.id}/${T.LEFT_COLLAPSE}`)
        }
    },

    computed: {
        collapsed() {
            const state = this.$store.state.iota[this.id || 'container']
            return state.layout.console.left.collapsed
        }
    }
}
</script>

<style lang="stylus" scoped>
.ii-collapsed {
    color: white;
    font-size: 20px;
    padding: 0px 10px;
}
</style>