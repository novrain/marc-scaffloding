<template>
    <a-row type='flex'
        class="item">
        <a-col :span="2">
            <ii-icon :type='item.widgetSettings.icon' />
        </a-col>
        <a-col :span="8">
            <a-row class="title">
                {{ item.name }}
            </a-row>
            <a-row class="hint">
                {{ item.desc }}
            </a-row>
        </a-col>
        <a-col :span="10">
            <a-checkbox @change='onChange'
                :checked='checked'>
            </a-checkbox>
        </a-col>
    </a-row>
</template>
<script>
export default {
    props: ['item'],
    data() {
        return {
        }
    },
    methods: {
        onChange(e) {
            this.$axios.silentPut(`/v1/api/sysconfig/${this.item.key}`, { value: e.target.checked }, true).then(() => {
                this.updateSysconfig({ [this.item.key]: e.target.checked.toString() })
            }).catch(() => {
            })
        }
    },
    computed: {
        checked() {
            return this.item.value === 'true' || this.item.defaultValue === 'true'
        }
    }
}
</script>

<style>
</style>