<template>
    <div>
        <a-form-item :label="t('fullname')"
            :label-col="labelCol"
            :wrapper-col="wrapperCol">
            <a-input v-decorator="['fullname', {
                            rules: [
                                { validator: fullNameValidator },
                            ],
                            validateFirst: true,
                            initialValue: extention.fullname
                        }]"
                :placeholder="t('fullname')">
                <a-icon slot="prefix"
                    v-if="isSimple"
                    type="user"
                    style="color: rgba(0,0,0,.25)" />
            </a-input>
        </a-form-item>
        <a-form-item :label="t('photo')"
            :label-col="labelCol"
            :wrapper-col="wrapperCol">
            <iota-avatar @avatar='getFile'
                class='avatar-viewer'
                :width='132'
                :height='200'
                :radius='0'
                title="上传个人照片"
                previewHint="图像预览"
                cropHint="最佳尺寸 150×100，可以上传高质量图片进行裁切"
                selectImgHint="选择图片"
                okText="确认"
                cancelText="取消">
                <iota-avatar-viewer :img='photo'
                    slot="controller"
                    :width='132'
                    :height='200'
                    :radius='0'
                    showUpload />
            </iota-avatar>
            <a-input class="hidden"
                v-decorator="['photo', { initialValue: personPhoto || extention.photo }]" />
        </a-form-item>
        <a-form-item :label="t('entryTime')"
            :label-col="labelCol"
            :wrapper-col="wrapperCol">
            <a-date-picker v-decorator="['entryTime', {initialValue: extention.entryTime}]" />
        </a-form-item>
        <a-form-item :label="t('sex')"
            :label-col="labelCol"
            :wrapper-col="wrapperCol">
            <a-radio-group v-decorator="['sex', {initialValue: extention.sex}]">
                <a-radio value="male">男</a-radio>
                <a-radio value="female">女</a-radio>
            </a-radio-group>
        </a-form-item>
        <a-form-item :label="t('birthday')"
            :label-col="labelCol"
            :wrapper-col="wrapperCol">
            <a-date-picker v-decorator="['birthday', {initialValue: extention.birthday}]" />
        </a-form-item>
        <a-form-item :label="t('education')"
            :label-col="labelCol"
            :wrapper-col="wrapperCol">
            <a-select v-decorator="['education', {initialValue: extention.education}]"
                :options='eduOptions'>
            </a-select>
        </a-form-item>
        <a-form-item :label="t('politic')"
            :label-col="labelCol"
            :wrapper-col="wrapperCol">
            <a-select v-decorator="['politic', {initialValue: extention.politic}]"
                :options='politicsOptions'>
            </a-select>
        </a-form-item>
        <a-form-item :label="t('joinTime')"
            :label-col="labelCol"
            :wrapper-col="wrapperCol">
            <a-date-picker v-decorator="['joinTime', {initialValue: extention.joinTime}]" />
        </a-form-item>
        <a-form-item :label="t('telephone')"
            :label-col="labelCol"
            :wrapper-col="wrapperCol">
            <a-input v-decorator="['telephone', {
                            rules: [
                                { validator: telephoneValidator },
                            ],
                            validateFirst: true,
                            initialValue: extention.telephone
                        }]"
                :placeholder="t('telephone')">
                <a-icon slot="prefix"
                    v-if="isSimple"
                    type="phone"
                    style="color: rgba(0,0,0,.25)" />
            </a-input>
        </a-form-item>
        <slot name="item" />
    </div>
</template>

<script>
import * as U from '../util'

export default {
    props: ['form', 'isSimple', 'extention'],
    data() {
        return {
            labelCol: { span: 7 },
            wrapperCol: { span: 16 },
            //
            eduOptions: [],
            politicsOptions: [],
            personPhoto: undefined
        }
    },
    mounted() {
        if (U.educationOptions) {
            this.eduOptions = U.educationOptions
        } else {
            this.$axios.silentGet('/v1/api/dictionaries/frame_education', true)
                .then((res) => {
                    this.eduOptions = res.data.items.map(i => {
                        return { label: i.name, value: i.key }
                    })
                    U.setEducationOptions(this.eduOptions)
                }).catch(() => { })
        }

        if (U.politicsOptions) {
            this.politicsOptions = U.politicsOptions
        } else {
            this.$axios.silentGet('/v1/api/dictionaries/frame_politics', true)
                .then((res) => {
                    this.politicsOptions = res.data.items.map(i => {
                        return { label: i.name, value: i.key }
                    })
                    U.setPoliticsOptions(this.politicsOptions)
                }).catch(() => { })
        }
    },
    methods: {
        t(message, params) {
            return this.$t(`iota.global.authentication.${message}`, params)
        },
        fullNameValidator(rule, value, callback) {
            callback()
        },
        telephoneValidator(rule, value, callback) {
            callback()
        },
        getFile(canvas) {
            this.avatarBase64 = canvas.toDataURL();
            canvas.toBlob(blob => {
                let fd = new FormData()
                fd.append("fileBlob", blob, `${this.$user.username}.png`); //目前后端做的验证必须加后缀
                this.$axios.silentPost('/v1/api/attachment/personal', fd, true)
                    .then((res) => {
                        this.personPhoto = res.data.uploaded
                    }).then(() => {
                    }).catch(() => { })
            })
        }
    },
    computed: {
        photo() {
            const defaultPersonPhoto = "/assets/imgs/defaultPersonPhoto.png"
            return this.personPhoto
                ? `${this.$axios.baseURL()}${this.personPhoto}`
                : (this.extention.photo ? `${this.$axios.baseURL()}${this.extention.photo}` : defaultPersonPhoto)
        }
    }
}
</script>

<style lang="stylus" scoped>
.hidden {
    display: none;
}
</style>