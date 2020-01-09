<template>
    <a-row type='flex'
        class="item">
        <a-col :span="2">
            <ii-icon :type='item.widgetSettings.icon' />
        </a-col>
        <a-col :span="8">
            <a-row class="title">
                {{item.name}}
            </a-row>
            <a-row class="hint">
                {{item.desc}}
            </a-row>
        </a-col>
        <a-col :span="10">
            <iota-raw-avatar :img='image'
                :uploadImg='upload'
                v-bind="item.widgetSettings"
                showUpload />
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
        upload(imgObj) {
            let uploadFn = blob => {
                let fd = new FormData()
                let uploaded
                fd.append("fileBlob", blob, `${this.$settings[this.item.key]}.png`); //目前后端做的验证必须加后缀
                this.$axios.silentPost('/v1/api/attachment/sysconfig', fd, true)
                    .then((res) => {
                        uploaded = res.data.uploaded
                        return this.$axios.silentPut(`/v1/api/sysconfig/${this.item.key}`, { value: uploaded }, true)
                    }).then(() => {
                        this.updateSysconfig({ [this.item.key]: uploaded })
                    }).catch(() => {
                    })
            }
            if (typeof imgObj.toBlob === 'function') {
                imgObj.toBlob(uploadFn)
            }
            else {
                let blob = imgObj
                uploadFn(blob)
            }
        }
    },
    computed: {
        image() {
            return this.item.value ? `${this.$axios.baseURL()}${this.item.value}` : this.item.defaultValue
        }
    }
}
</script>

<style>
</style>