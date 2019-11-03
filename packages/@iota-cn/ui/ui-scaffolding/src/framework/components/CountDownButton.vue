<template>
    <a-button @click="onClick"
        :disabled='disabled||counting'
        :size='size'
        :icon='icon'
        :shape='shape'
        :type='type'>
        {{counting?`${countingTextPrefix||''}(${seconds})s${countingTextPost||''}`:text}}
    </a-button>
</template>

<script>
export default {
    name: 'IiCountDownButton',
    props: {
        type: String,
        timeout: {
            type: Number,
            default: 60
        },
        countingTextPrefix: String,
        countingTextPost: String,
        text: String,
        size: String,
        icon: String,
        shape: String,
        disabled: Boolean
    },
    data() {
        return {
            counting: false,
            seconds: 0
        }
    },
    methods: {
        run() {
            this.seconds = this.seconds - 1;
            if (this.seconds > 0) {
                setTimeout(() => {
                    this.run()
                }, 1000)
            } else {
                this.counting = false
            }
        },
        onClick() {
            this.$emit('click')
            this.counting = true
            this.seconds = this.timeout
            this.run()
        }
    }
}
</script>

<style>
</style>