<template>
    <component :is="layout.type"
        :layout="layout.define"
        :id="id" />
</template>

<script>
import ConsoleLayout from './layout/ConsoleLayout'
import NormalLayout from './layout/NormalLayout'

export default {
    props: {
        id: String
    },

    components: {
        'console': ConsoleLayout,
        'normal': NormalLayout
    },

    data() {
        return {
        }
    },

    created() {
        const initActions = this.$store.state.iota[this.id || 'container'].initActions
        initActions.forEach(action => {
            if (typeof action === 'string') {
                this.$store.dispatch(action, { vm: this })
            } else if (typeof action === 'object' && typeof action.action === 'string') {
                action.params = action.params || {}
                action.params.vm = this
                this.$store.dispatch(action.action, action.params)
            }
        })
    },

    mounted() {
    },

    computed: {
        layout() {
            const state = this.$store.state.iota[this.id || 'container']
            const type = state.type
            const define = state.layout[type] || {// 控制台，左右（上下）
                head: {
                    right: {
                        items: []
                    },
                    left: {
                        items: []
                    }
                },
                left: {
                    top: {
                        items: []
                    },
                    menu: {
                        items: [],
                    },
                    bottom: {
                        items: []
                    }
                }
            }
            return {
                type,
                define
            }
        }
    }
}

</script>

<style lang="stylus" scoped></style>
