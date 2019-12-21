<template>
    <a-tabs class="ii-sys-config">
        <a-tab-pane class="basicConfig"
            key="basicConfig"
            size='small'
            tab='基础配置'
            :bordered='false'>
            <div class="operation"
                style="width: 300px">
                <a-row type='flex'
                    class="item">
                    <a-col :span="2">
                        <a-icon type='menu-unfold' />
                    </a-col>
                    <a-col :span="8">
                        <a-row class="title">
                            系统菜单Logo
                        </a-row>
                        <a-row class="hint">
                            {{"菜单使用的Logo, 最佳尺寸192x38"}}
                        </a-row>
                    </a-col>
                    <a-col :span="10">
                        <iota-raw-avatar :img='$settings.logo'
                            :uploadImg='createUpload({imgKey:"logo"})'
                            :width='192'
                            :height='38'
                            :radius='0'
                            color='#0d3ae3'
                            showUpload />
                    </a-col>
                </a-row>
                <a-row type='flex'
                    class="item">
                    <a-col :span="2">
                        <a-icon type='menu-fold' />
                    </a-col>
                    <a-col :span="8">
                        <a-row class="title">
                            系统菜单坍缩Logo
                        </a-row>
                        <a-row class="hint">
                            {{"菜单坍缩时使用的Logo, 最佳尺寸72x38"}}
                        </a-row>
                    </a-col>
                    <a-col :span="10">
                        <iota-raw-avatar :img='$settings.collapsedLogo'
                            :uploadImg='createUpload({imgKey:"collapsedLogo"})'
                            :width='72'
                            :height='38'
                            :radius='0'
                            color='#0d3ae3'
                            showUpload />
                    </a-col>
                </a-row>
                <a-row type='flex'
                    class="item">
                    <a-col :span="2">
                        <ii-icon type='application' />
                    </a-col>
                    <a-col :span="18">
                        <a-row class="title">
                            系统名称
                        </a-row>
                        <a-row class="title">
                            {{ this.$settings.title }}
                        </a-row>
                    </a-col>
                    <a-col :span="4">
                        <a-row type='flex'
                            justify='end'>
                            <a-button type='link'
                                @click="onChangeSysTitle"
                                size='small'>修改</a-button>
                        </a-row>
                    </a-col>
                </a-row>
                <a-row type='flex'
                    class="item">
                    <a-col :span="2">
                        <ii-icon type='notice' />
                    </a-col>
                    <a-col :span="18">
                        <a-row class="title">
                            系统版权
                        </a-row>
                        <a-row class="title">
                            {{ this.$settings.copyright }}
                        </a-row>
                    </a-col>
                    <a-col :span="4">
                        <a-row type='flex'
                            justify='end'>
                            <a-button type='link'
                                @click="onChangeSysCopyright"
                                size='small'>修改</a-button>
                        </a-row>
                    </a-col>
                </a-row>
                <a-row type='flex'
                    class="item">
                    <a-col :span="2">
                        <ii-icon type='protocol' />
                    </a-col>
                    <a-col :span="8">
                        <a-row class="title">
                            流程信息禁止编辑
                        </a-row>
                    </a-col>
                    <a-col :span="10">
                        <a-checkbox v-decorator="['processInfoEditDisable']"
                            v-model="$settings.processInfoEditDisable"
                            @change='changedProfile( { profileKey:"processInfoEditDisable" } ,$event)'>
                        </a-checkbox>
                    </a-col>
                </a-row>
                <a-row type='flex'
                    class="item">
                    <a-col :span="2">
                        <a-icon type='user' />
                    </a-col>
                    <a-col :span="8">
                        <a-row class="title">
                            用户名禁止编辑
                        </a-row>
                    </a-col>
                    <a-col :span="10">
                        <a-checkbox v-decorator="['userNameEditDisable']"
                            v-model="$settings.userNameEditDisable"
                            @change='changedProfile( { profileKey:"userNameEditDisable" },$event )'>
                        </a-checkbox>
                    </a-col>
                </a-row>
            </div>
            <!-- 修改Title -->
            <a-modal title="修改系统名称"
                :width='modelWidth'
                v-model="changeSysTitleVisible"
                @ok="onChangeSysTitleOk">
                <a-form :form="changeSysTitleForm">
                    <a-form-item label="系统名称"
                        :label-col="labelCol"
                        :wrapper-col="wrapperCol">
                        <a-input v-decorator="['title', {
                            rules: [
                                { required: true, message: 请输入系统名称 },
                            ],
                            initialValue: this.$settings.title
                        }]"
                            placeholder="请输入系统名称">
                        </a-input>
                    </a-form-item>
                </a-form>
            </a-modal>
            <!-- 修改Copyright -->
            <a-modal title="修改系统版权"
                :width='modelWidth'
                v-model="changeSysCopyrightVisible"
                @ok="onChangeSysCopyrightOk">
                <a-form :form="changeSysCopyrightForm">
                    <a-form-item label="系统版权"
                        :label-col="labelCol"
                        :wrapper-col="wrapperCol">
                        <a-input v-decorator="['copyright', {
                            rules: [
                                { required: true, message: 请输入系统版权 },
                            ],
                            initialValue: this.$settings.copyright
                        }]"
                            placeholder="请输入系统版权">
                        </a-input>
                    </a-form-item>
                </a-form>
            </a-modal>
        </a-tab-pane>
        <!-- 高级配置，暂屏蔽
        <a-tab-pane class="sysExtConfig"
            key="extConfig"
            size='small'
            tab='高级配置'
            :bordered='false'>
            <a-form :form="sysExtConfigForm">

            </a-form>
        </a-tab-pane>
        -->
    </a-tabs>
</template>

<script>

import { createNamespacedHelpers } from 'vuex'
const { mapActions } = createNamespacedHelpers('iota/global/sysconfig')

export default {
    data() {
        return {
            labelCol: { span: 7 },
            wrapperCol: { span: 16 },
            changeSysTitleVisible: false,
            changeSysTitleForm: this.$form.createForm(this, {
                name: 'changeSysTitle',
            }),
            changeSysCopyrightVisible: false,
            changeSysCopyrightForm: this.$form.createForm(this, {
                name: 'changeSysCopyright',
            }),

        }
    },
    mounted() {
        this.fetchSysconfig()
    },
    methods: {
        ...mapActions(['fetchSysconfig', 'updateSysconfig']),
        t(message, params) {
            return this.$t(`iota.frame.plugins.sysconfig.${message}`, params)
        },
        // 获取系统配置
        // Title
        onChangeSysTitle() {
            this.changeSysTitleVisible = !this.changeSysTitleVisible
            this.changeSysTitleForm.resetFields()
        },
        onChangeSysTitleOk() {
            this.changeSysTitleForm.validateFields((err, values) => {
                if (!err) {
                    if (values.title === this.$settings.title) {
                        this.changeSysTitleVisible = false
                        return
                    }
                    this.$axios.silentPut(`/v1/api/sysconfig`, values, true).then(() => {
                        this.changeSysTitleVisible = false
                        this.updateSysconfig({ title: values.title })
                    }).catch(() => {
                    })
                }
            })
        },

        // Copyright
        onChangeSysCopyright() {
            this.changeSysCopyrightVisible = !this.changeSysCopyrightVisible
            this.changeSysCopyrightForm.resetFields()
        },
        onChangeSysCopyrightOk() {
            this.changeSysCopyrightForm.validateFields((err, values) => {
                if (!err) {
                    if (values.copyright === this.$settings.copyright) {
                        this.changeSysCopyrightVisible = false
                        return
                    }
                    this.$axios.silentPut(`/v1/api/sysconfig`, values, true).then(() => {
                        this.changeSysCopyrightVisible = false
                        this.updateSysconfig({ copyright: values.copyright })
                    }).catch(() => {
                    })
                }
            })
        },

        // processInfoEditDisable,userNameEditDisable
        changedProfile({ profileKey }, e) {
            this.$axios.silentPut(`/v1/api/sysconfig`, { [profileKey]: e.target.checked }, true).then(() => {
                this.updateSysconfig({ [profileKey]: e.target.checked })
            }).catch(() => {
            })
        },
        // avatar
        /**
         * 从 imgObj 获取数据
         * 首先更新头像
         * 再传入到data中，提交到服务器更新
         */
        createUpload({ imgKey }) {
            let that = this
            return function (imgObj) {
                let uploadFn = blob => {
                    let fd = new FormData()
                    let uploaded
                    fd.append("fileBlob", blob, `${that.$settings[imgKey]}.png`); //目前后端做的验证必须加后缀
                    that.$axios.silentPost('/v1/api/attachment/sysclogo', fd, true)
                        .then((res) => {
                            uploaded = res.data.uploaded
                            return that.$axios.silentPut('/v1/api/sysconfig', { [imgKey]: uploaded }, true)
                        }).then(() => {
                            that.updateSysconfig({ [imgKey]: uploaded })
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
        }
    }
}
</script>

<style lang="stylus" scoped>
@import '../../../../styles/imports';

.ii-sys-config {
    width: 100%;
    height: 100%;
    background-color: white;
    display: flex;
    flex-direction: column;

    /deep/ .ant-tabs-content {
        height: 0;
        flex: 1;
        overflow: auto;
    }

    .basicConfig {
        width: 100%;
        padding: 5px;
        display: flex;
        justify-content: center;
        width: 100%;

        .info {
            .ant-card-cover {
                .avatar-viewer {
                    width: 228;
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

    .extConfig {
        width: 100%;
        height: 100%;
        overflow-y: auto;
    }
}
</style>