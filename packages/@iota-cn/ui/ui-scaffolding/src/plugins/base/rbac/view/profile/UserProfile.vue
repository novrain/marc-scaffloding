<template>
    <a-tabs class="ii-user-profile">
        <a-tab-pane class="basic"
            key="basic"
            size='small'
            tab='基本信息'
            :bordered='false'>
            <a-card class="info"
                style="width: 300px"
                :bordered='false'>
                <iota-avatar slot="cover"
                    @avatar='getFile'
                    class='avatar-viewer'
                    :width='100'
                    :height='100'
                    :radius='50'
                    title="上传个人头像"
                    previewHint="图像预览"
                    cropHint="最佳尺寸 100×100，可以上传高质量图片进行裁切"
                    selectImgHint="选择图片"
                    okText="确认"
                    cancelText="取消">
                    <iota-avatar-viewer :img='$user.gravatar||"/assets/imgs/defaultAvatar.png"'
                        slot="controller"
                        :width='100'
                        :height='100'
                        :radius='50'
                        showUpload />
                </iota-avatar>
                <a-row type='flex'
                    class="item">
                    <a-col :span="8">{{t('account')}}</a-col>
                    <a-col :span="12">{{$user.username}}
                        <a-tag v-if='$user.isAdmin'
                            color="#f50">{{t('administrator')}}</a-tag>
                    </a-col>
                    <a-col :span="4"
                        v-if='!$settings.dsiableUsernameEdit'>
                        <a-button icon="edit"
                            @click="onChangeUsername"
                            type='link'>
                        </a-button>
                    </a-col>
                </a-row>
                <a-row type='flex'
                    class="item">
                    <a-col :span="8">{{t('position')}}</a-col>
                    <a-col v-if='$user.isAdmin'
                        :span="16">{{'--'}} </a-col>
                    <a-col v-else
                        :span="16">
                        <li v-for="position in positions"
                            :key="position.id"> {{position.name}} </li>
                    </a-col>
                </a-row>
                <a-row type='flex'
                    class="item">
                    <a-col :span="8">{{t('organization')}}</a-col>
                    <a-col v-if='$user.isAdmin'
                        :span="16">{{'--'}} </a-col>
                    <a-col v-else
                        :span="16">
                        <li v-for="organization in organizations"
                            :key="organization.id"> {{organization.name}} </li>
                    </a-col>
                </a-row>
            </a-card>
            <div class="operation">
                <a-row type='flex'
                    class="item">
                    <a-col :span="2">
                        <ii-icon type='lock' />
                    </a-col>
                    <a-col :span="18">
                        <a-row class="title">
                            {{t('password')}}
                        </a-row>
                        <a-row class="hint">
                            {{t('pwdHint')}}
                        </a-row>
                    </a-col>
                    <a-col :span="4">
                        <a-row type='flex'
                            justify='end'>
                            <a-button type='link'
                                @click="onChangePassword"
                                size='small'>{{t('change')}}</a-button>
                        </a-row>
                    </a-col>
                </a-row>
                <a-row type='flex'
                    class="item">
                    <a-col :span="2">
                        <a-icon type='mobile' />
                    </a-col>
                    <a-col :span="18">
                        <a-row class="title">
                            {{t('bindMobile')}}
                        </a-row>
                        <a-row class="hint">
                            {{t('bindMobileHint', { mobile : $user.mobile || '' })}}
                        </a-row>
                    </a-col>
                    <a-col :span="4">
                        <a-row type='flex'
                            justify='end'>
                            <a-button type='link'
                                @click="onChangeMobile"
                                size='small'>{{$user.mobile ? t('change') : t('bind')}}</a-button>
                        </a-row>
                    </a-col>
                </a-row>
                <a-row type='flex'
                    class="item">
                    <a-col :span="2">
                        <a-icon type='mail' />
                    </a-col>
                    <a-col :span="18">
                        <a-row class="title">
                            {{t('bindEmail')}}
                        </a-row>
                        <a-row class="hint">
                            {{t('bindEmailHint', { email : $user.email||'' })}}
                        </a-row>
                    </a-col>
                    <a-col :span="4">
                        <a-row type='flex'
                            justify='end'>
                            <ii-count-down-button type='link'
                                @click="onActiveEmail"
                                :text="t('active')"
                                size='small'
                                :countingTextPost="t('retry')"
                                v-if="!$user.actEmail && $user.email" />
                            <a-button type='link'
                                v-else
                                @click="onChangeEmail"
                                size='small'>{{$user.email ? t('change'): t('bind')}}</a-button>
                        </a-row>
                    </a-col>
                </a-row>
                <!-- <a-row type='flex'
                class="item">
                <a-col :span="2">
                    <ii-icon type='wechat' />
                </a-col>
                <a-col :span="18">
                    <a-row class="title">
                        {{t('bindWechat')}}
                    </a-row>
                    <a-row class="hint">
                        {{t('bindWechatHint')}}
                    </a-row>
                </a-col>
                <a-col :span="4">
                    <a-row type='flex'
                        justify='end'>
                        <a-button type='link'
                            size='small'>{{user.mobile ? t('change') : t('bind')}}</a-button>
                    </a-row>
                </a-col>
            </a-row> -->
            </div>
            <!-- 修改用户名 -->
            <a-modal :title="t('changeWhat', {what:t('account')})"
                :width='modelWidth'
                v-model="changeUsernameVisible"
                @ok="onChangeUsernameOk">
                <a-form :form="changeUsernameForm">
                    <a-form-item :label="t('account')"
                        :label-col="labelCol"
                        :wrapper-col="wrapperCol">
                        <a-input v-decorator="['username', {
                            rules: [
                                { required: true, message:  t('emptyWhat', {what:t('account')})  },
                                { validator: usernameValidator },
                            ],
                            initialValue: $user.username,
                            validateFirst: true
                        }]"
                            :placeholder="t('account')">
                        </a-input>
                    </a-form-item>
                </a-form>
            </a-modal>
            <!-- 修改邮箱 -->
            <a-modal :title="t('changeWhat', {what:t('email')})"
                :width='modelWidth'
                v-model="changeEmailVisible"
                @ok="onChangeEmailOk">
                <a-form :form="changeEmailForm">
                    <a-form-item :label="t('email')"
                        :label-col="labelCol"
                        :wrapper-col="wrapperCol">
                        <a-input v-decorator="['email', {
                            rules: [
                                { required: true, message: t('emptyWhat', {what:t('email')}) },
                                { validator: emailValidator },
                            ],
                            initialValue: $user.email,
                            validateFirst: true
                        }]"
                            :placeholder="t('email')">
                        </a-input>
                    </a-form-item>
                </a-form>
            </a-modal>
            <!-- 修改密码 -->
            <a-modal :title="t('changeWhat', {what:t('password')})"
                :width='modelWidth'
                v-model="changePasswordVisible"
                @ok="onChangePasswordOk">
                <a-form :form="changePasswordForm">
                    <ii-reset-password-form :isChange='true'
                        :form='changePasswordForm' />
                </a-form>
            </a-modal>
            <!-- 修改手机 -->
            <a-modal :title="t('changeWhat', {what:t('mobile')})"
                :width='modelWidth'
                v-model="changeMobileVisible"
                @ok="onChangeMobileOk">
                <a-form :form="changeMobileForm">
                    <a-form-item :label="t('mobile')"
                        :label-col="labelCol"
                        :wrapper-col="wrapperCol">
                        <a-input v-decorator="['mobile', {
                            rules: [
                                { required: true, message: t('emptyWhat', {what:t('mobile')}) },
                                { validator: mobileValidator },
                            ],
                            initialValue: $user.mobile,
                            validateFirst: true
                        }]"
                            :placeholder="t('mobile')">
                        </a-input>
                    </a-form-item>
                    <a-form-item :label="t('captcha')"
                        :label-col="labelCol"
                        :wrapper-col="wrapperCol">
                        <a-row type='flex'
                            align='middle'>
                            <a-col :span="16">
                                <a-input v-decorator="['captcha', {
                            rules: [
                                { validator: captchaValidator },
                            ],
                            validateFirst: true
                        }]"
                                    type='mobile'
                                    :placeholder="t('captcha')">
                                </a-input>
                            </a-col>
                            <a-col :span="8">
                                <a-row type='flex'
                                    justify='end'
                                    align='middle'>
                                    <ii-count-down-button type='link'
                                        @click="onGetCaptcha"
                                        :text="t('captcha')"
                                        size='small'
                                        :disabled='!isMobileValid'
                                        :countingTextPost="t('retry')" />
                                </a-row>
                            </a-col>
                        </a-row>
                    </a-form-item>
                </a-form>
            </a-modal>
        </a-tab-pane>
        <a-tab-pane class="extention"
            key="extention"
            size='small'
            tab='详细信息'
            :bordered='false'>
            <a-form :form="userExtentionForm">
                <ii-user-extends-form :form='userExtentionForm'
                    :extention='userExtention'
                    class='user_extends'>
                    <a-form-item :wrapper-col="{span:16, offset: 7}"
                        slot="item">
                        <a-button type='primary'
                            @click="onSaveUserExtention">保存</a-button>
                    </a-form-item>
                </ii-user-extends-form>
            </a-form>
        </a-tab-pane>
    </a-tabs>
</template>

<script>
import moment from 'moment'
import { Validator } from '@iota-cn/util-validation'

export default {
    beforeCreate() {
        this.userExtentionForm = this.$form.createForm(this, { name: 'user_extends' });
    },
    data() {
        return {
            modelWidth: 480,
            labelCol: { span: 7 },
            wrapperCol: { span: 16 },
            organizations: [],
            positions: [],
            changeUsernameVisible: false,
            changeUsernameForm: this.$form.createForm(this, {
                name: 'changeUsername',
            }),
            changeEmailVisible: false,
            changeEmailForm: this.$form.createForm(this, {
                name: 'changeEmail',
            }),
            changePasswordVisible: false,
            changePasswordForm: this.$form.createForm(this, {
                name: 'changePassword',
            }),
            changeMobileVisible: false,
            changeMobileForm: this.$form.createForm(this, {
                name: 'changeMobile',
            }),
            //
            isMobileValid: false,
            //
            userExtention: {}
        }
    },
    mounted() {
        this.refetchUserInfo()
        this.$axios.silentGet('/v1/api/accounts/profile_extention', true)
            .then((res) => {
                this.userExtention = res.data
                this.userExtention.birthday = this.userExtention.birthday ? moment(this.userExtention.birthday) : undefined
                this.userExtention.entryTime = this.userExtention.entryTime ? moment(this.userExtention.entryTime) : undefined
                this.userExtention.joinTime = this.userExtention.joinTime ? moment(this.userExtention.joinTime) : undefined
            })
            .catch(() => { })
    },
    computed: {
    },

    methods: {
        t(message, params) {
            return this.$t(`iota.frame.plugins.rbac.${message}`, params)
        },
        // username
        onChangeUsername() {
            this.changeUsernameVisible = !this.changeUsernameVisible
            this.changeUsernameForm.resetFields()
        },
        onChangeUsernameOk() {
            this.changeUsernameForm.validateFields((err, values) => {
                if (!err) {
                    if (values.username === this.$user.username) {
                        this.changeUsernameVisible = false
                        return
                    }
                    this.$axios.commonPut(`/v1/api/accounts/profile`, values, {
                        handleErr: true,
                        success: this.t('updateSuccess')
                    }).then(() => {
                        this.$store.dispatch('iota/global/updateUser', values)
                        this.changeUsernameVisible = false
                    }).catch(() => {
                    })
                }
            })
        },
        // eslint-disable-next-line
        usernameValidator(rule, value, callback) {
            if (value === this.$user.username) {
                callback()
            }
            if (!Validator.isUserName(value)) {
                callback(this.t('invalidUsername'))
            }
            this.$axios.get(`/v1/api/validations/usernames/validate?username=${value}`).then(() => {
                callback()
            }).catch(() => {
                callback(this.t('invalidUsername'))
            })
        },

        // email
        onChangeEmail() {
            this.changeEmailVisible = !this.changeEmailVisible
            this.changeEmailForm.resetFields()
        },
        onActiveEmail() {
            this.$axios.commonPost(`/v1/api/accounts/email/active`,
                { email: this.$user.email },
                {
                    success: this.t('successSendActiveEmail'),
                    error: this.t('failSendActiveEmail')
                }
            )
        },
        onChangeEmailOk() {
            this.changeEmailForm.validateFields((err, values) => {
                if (!err) {
                    if (values.email === this.$user.email) {
                        this.changeEmailVisible = false
                        return
                    }
                    this.$axios.commonPut(`/v1/api/accounts/profile`, values, {
                        handleErr: true,
                        success: this.t('updateSuccess')
                    }).then(() => {
                        this.$store.dispatch('iota/global/updateUser', values)
                        this.changeEmailVisible = false
                    }).catch(() => {
                    })
                }
            })
        },
        // eslint-disable-next-line
        emailValidator(rule, value, callback) {
            if (value === this.$user.email) {
                callback()
            }
            if (!Validator.isEmail(value)) {
                callback(this.t('invalidEmail'))
            }
            this.$axios.get(`/v1/api/validations/emails/validate?email=${value}`, { doNotHint: true }).then(() => {
                callback()
            }).catch(() => {
                callback(this.t('invalidEmail'))
            })
        },

        //password
        onChangePassword() {
            this.changePasswordVisible = !this.changePasswordVisible
            this.changePasswordForm.resetFields()
        },
        onChangePasswordOk() {
            this.changePasswordForm.validateFields((err, values) => {
                if (!err) {
                    this.$axios.commonPost('/v1/api/accounts/password/change', values, {
                        handleErr: true,
                        success: this.t('updateSuccess')
                    }).then(() => {
                        this.changePasswordVisible = false
                    }).catch(() => {
                    })
                }
            })
        },

        // mobile
        onChangeMobile() {
            this.changeMobileVisible = !this.changeMobileVisible
            this.changeMobileForm.resetFields()
        },
        onChangeMobileOk() {
            this.changeMobileForm.validateFields((err, values) => {
                if (!err) {
                    if (values.mobile === this.$user.mobile) {
                        this.changeMobileVisible = false
                        return
                    }
                    this.$axios.commonPut(`/v1/api/accounts/profile?captcha=${values.captcha}`, { mobile: values.mobile }, {
                        success: this.t('updateSuccess'),
                        error: this.t('updateError')
                    }).then(() => {
                        this.$store.dispatch('iota/global/updateUser', { mobile: values.mobile })
                        this.changeMobileVisible = false
                    }).catch(() => {
                    })
                }
            })
        },
        // eslint-disable-next-line
        mobileValidator(rule, value, callback) {
            this.isMobileValid = false
            if (!Validator.isPhone(value)) {
                callback(this.t('invalidMobile'))
                return
            }
            if (value === this.$user.mobile) {
                callback()
                return
            }

            this.$axios.silentGet(`/v1/api/validations/mobiles/validate?mobile=${value}`, true)
                .then(() => {
                    callback()
                    this.isMobileValid = true
                }).catch(() => {
                    callback(this.t('invalidMobile'))
                })
        },
        // eslint-disable-next-line
        captchaValidator(rule, value, callback) {
            const mobile = this.changeMobileForm.getFieldValue('mobile')
            if (mobile === this.$user.mobile) {
                callback()
                return
            }
            if (value === undefined || value === '') {
                callback(this.t('emptyWhat', { what: this.t('captcha') }))
                return
            }
            this.$axios.silentGet(`/v1/api/validations/smses/validate?mobile=${mobile}&captcha=${value}`, true)
                .then(() => {
                    callback()
                }).catch(() => {
                    callback(this.t('invalidCaptcha'))
                })
        },
        onGetCaptcha() {
            if (!this.isMobileValid) {
                return
            }
            const mobile = this.changeMobileForm.getFieldValue('mobile')
            this.$axios.commonPost('/v1/api/validations/smses', { mobile }, {
                success: this.t('successGetCaptcha'),
                error: this.t('failGetCaptcha')
            })
        },
        onSaveUserExtention() {
            this.userExtentionForm.validateFields((err, values) => {
                if (!err) {
                    values.userId = this.$user.id
                    this.$axios.commonPut(`/v1/api/accounts/profile_extention`, values, {
                        success: this.t('updateSuccess'),
                        error: this.t('updateError')
                    }).then(() => {
                        this.$store.dispatch('iota/global/updateUser', { userExt: values })
                    }).catch(() => {
                    })
                }
            })
        },
        refetchUserInfo() {
            this.$fetchAssignedOrganizations().then((assignedOrganizations) => {
                this.organizations = assignedOrganizations
            })
            this.$fetchAssignedPositions().then((assignedPositions) => {
                this.positions = assignedPositions
            })
        },
        // avatar
        /**
         * 从 canvas 获取数据
         * 首先更新头像
         * 再传入到data中，提交到服务器更新
         */
        getFile(canvas) {
            this.avatarBase64 = canvas.toDataURL();
            canvas.toBlob(blob => {
                let fd = new FormData()
                let gravatar
                fd.append("fileBlob", blob, `${this.$user.username}.png`); //目前后端做的验证必须加后缀
                this.$axios.silentPost('/v1/api/attachment/gravatar', fd, true)
                    .then((res) => {
                        gravatar = res.data.uploaded
                        return this.$axios.silentPut('/v1/api/accounts/profile', {
                            gravatar: gravatar
                        }, true)
                    }).then(() => {
                        this.$store.dispatch('iota/global/updateUser', { gravatar: gravatar })
                    }).catch(() => { })
            })
        }
    }
}
</script>

<style lang="stylus" scoped>
@import '../../../../../styles/imports';

.ii-user-profile {
    width: 100%;
    height: 100%;
    background-color: white;
    display: flex;
    flex-direction: column;

    /deep/ .ant-tabs-content {
        flex: 1;
        height: 0;
    }

    .basic {
        width: 100%;
        padding: 5px;
        display: flex;
        justify-content: center;
        width: 100%;

        .info {
            .ant-card-cover {
                .avatar-viewer {
                    width: 100px;
                    margin: 20px auto;

                    img {
                        border: 1px solid $md-blue-grey-300;
                    }
                }
            }

            .ant-card-body {
                padding: 10px 24px;
            }

            .name-mail {
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .item {
                height: 40px;
                border-bottom: 1px solid $md-blue-grey-300;
                align-items: center;

                &:last-child {
                    border: none;
                }
            }
        }

        .operation {
            background-color: white;
            padding: 24px;
            margin-left: 10px;
            min-width: 700px;

            .item {
                height: 80px;
                border-bottom: 1px solid $md-blue-grey-300;
                align-items: center;

                .anticon, .iota-icon {
                    font-size: 20px;
                    color: $primary-color;
                }

                .title {
                    font-weight: 500;
                }

                .hint {
                    font-size: 12px;
                    color: $md-blue-grey-300;
                }

                &:last-child {
                    border: none;
                }
            }
        }
    }

    .extention {
        width: 100%;
        height: 100%;
        overflow-y: auto;

        .user_extends {
            width: 30%;
            margin: 0 auto;
        }
    }
}
</style>