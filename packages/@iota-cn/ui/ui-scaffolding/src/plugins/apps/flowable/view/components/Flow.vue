<template>
    <a-row class="ii-flow">
        <splitpanes class="default-theme">
            <splitpane size='60'
                min-size="30"
                max-size="70">
                <div class="detail"
                    ref='_detail'>
                    <!-- <a-back-top :target='()=>$refs._detail' /> -->
                    <div class="title">
                        {{flow.name}}
                    </div>
                    <ncform :form-schema="formDef"
                        formName='_submitForm'
                        v-if="formDef"
                        v-model="formData"
                        :is-dirty.sync="isFormDirty"></ncform>
                    <div class="operations">
                        <a-button type='primary'
                            v-if="handleable"
                            @click="handleSubmit">提交</a-button>
                    </div>
                </div>
            </splitpane>
            <splitpane size='40'
                :class="fullscreen ? 'tabsplit tabsplit-fullscreen': 'tabsplit'">
                <div class="toolbar">
                    <a-button v-if="activeTab === 'comments'"
                        size='small'
                        @click='onShowGallery'
                        icon="pic-left" />
                    <a-button size='small'
                        @click='onFullscreen'
                        :icon="fullscreen ? 'shrink' : 'arrows-alt'" />
                </div>
                <a-tabs defaultActiveKey="comments"
                    size="small"
                    v-model="activeTab"
                    class='flowtabs'>
                    <a-tab-pane tab="跟踪信息"
                        key="comments">
                        <ii-comments :user='user'
                            ref='_comments'
                            :active='activeTab === "comments"'
                            v-if='$p("/fl/process/history/historic-process-instances/:instanceId/comments:GET")'
                            :flow='flow' />
                    </a-tab-pane>
                    <a-tab-pane tab="附件"
                        v-if='$p("/fl/content/content-service/content-items:GET")'
                        class="tabpanel"
                        key="attachements">
                        <ii-attachments :user='user'
                            :active='activeTab === "attachements"'
                            :flow='flow' />
                    </a-tab-pane>
                    <a-tab-pane tab="流程"
                        key="tasks">
                        <ii-tasks :user='user'
                            :active='activeTab === "tasks"'
                            :flow='flow'
                            :processdef='processdef' />
                    </a-tab-pane>
                </a-tabs>
                <a-modal centered
                    class="ii-gallery-modal"
                    v-model="showGallery"
                    :closable='false'
                    :footer='null'>
                    <a-carousel arrows
                        :dots='false'>
                        <div slot="prevArrow"
                            class="custom-slick-arrow"
                            style="left: 10px;zIndex: 1">
                            <a-icon type="left-circle" />
                        </div>
                        <div slot="nextArrow"
                            class="custom-slick-arrow"
                            style="right: 10px">
                            <a-icon type="right-circle" />
                        </div>
                        <div v-for="img in getImgsInComments()"
                            :key="img">
                            <img :src="img" />
                        </div>
                    </a-carousel>
                </a-modal>
            </splitpane>
        </splitpanes>
    </a-row>
</template>

<script>
import { message } from 'ant-design-vue/es'
import Comments from './Comments'
import Attachments from './Attachments'
import Tasks from './Tasks'
import * as U from '../../util'

export default {
    components: {
        "ii-comments": Comments,
        "ii-attachments": Attachments,
        "ii-tasks": Tasks
    },
    props: ['flow', 'processdef', 'user'],
    data() {
        return {
            fullscreen: false,
            showGallery: false,
            formData: {},
            isFormDirty: false,
            formDef: undefined,
            contents: {
                items: []
            },
            activeTab: 'comments'
        }
    },
    watch: {
        flow: {
            handler() {
                this.refetch()
            },
            deep: true
        },
        processdef: {
            handler() {
                this.updateForm()
            }
        },
        // activeTab: {
        //     handler() {
        //         this.refetch()
        //     }
        // }
    },
    mounted() {
        this.refetch()
    },
    methods: {
        onFullscreen() {
            this.fullscreen = !this.fullscreen
        },
        onShowGallery() {
            this.showGallery = true
        },
        refetch() {
            const instanceId = this.flow.processInstanceId
            this.updateForm()
            // 刷新flow的状态 通过Task去查询的
            if (this.flow.suspended === undefined && !this.flow.finished) {
                this.$axios.silentGet(`/fl/process/runtime/process-instances/${instanceId}`, true)
                    .then((res) => {
                        this.flow.suspended = res.data.suspended
                    })
            }
        },
        // onChange({ paths, itemValue, formValue }) {
        //     console.log(typeof itemValue, itemValue, paths, formValue)
        // },
        updateForm() {
            // 确保数据是深度复制的，避免相互间的冲突
            this.formData = Object.assign({}, this.flow.formData)
            this.formDef = JSON.parse(this.processdef.formDef)
            const variables = this.flow.formData
            /**
             * 针对表单的全局配置
             * 1、flow所在阶段
             * 2、样式控制
             * 3、全局使能控制 // 当没有任务，或者任务的当前非当前用户
             */
            this.formDef.globalConfig = {
                style: {
                    formCls: 'ii-nc-form'
                },
                constants: {
                    initiatorId: variables.initiatorId,
                    initiatorName: variables.initiatorName,
                    initiatorUser: variables.initiatorUser,
                    currentTaskId: this.flow.task ? this.flow.task.taskDefinitionKey : undefined
                }
            }
            if (!this.handleable) {
                this.disableForm(this.formDef)
            }
        },
        disableForm(formSchema) {
            const items = formSchema.properties
            const itemKeys = Object.keys(items)
            itemKeys.forEach(key => {
                const item = items[key]
                if (item.type === 'object') {
                    this.disableForm(item)
                } else {
                    item.ui = item.ui || {}
                    item.ui.disabled = true
                }
            })
        },
        // 这里存在一定的问题，提交后，该flow还在待处理列表里，需要手动刷新才能跳转
        handleSubmit() {
            if (this.flow.task) {
                this.$ncformValidate('_submitForm').then(data => {
                    if (data.result) {
                        const variables = []
                        // 全程的变量都重复提交，FORM里的覆盖旧变量
                        // 暂存一个当前任务的被指派人/执行人，供可能的其他节点使用
                        let fullFormData = Object.assign(
                            {},
                            this.flow.formData,
                            this.formData,
                            { [`${this.flow.task.taskDefinitionKey}_TaskAssignee`]: `${U.idOfUser(this.user)}` }
                        )
                        Object.keys(fullFormData).forEach(k => {
                            variables.push({
                                name: k,
                                value: fullFormData[k]
                            })
                        })
                        this.$axios.silentPost(`/fl/process/runtime/tasks/${this.flow.task.id}`, {
                            action: 'complete',
                            variables: variables
                        }, true)
                            .then(() => {
                                this.$emit('submit', { flow: this.flow })
                                message.success('任务已提交')
                            }).catch(() => {
                                message.error('提交失败，请稍后再试')
                            })
                    }
                })
            }
        },
        getImgsInComments() {
            let imgs = []
            if (this.$refs._comments) {
                this.$refs._comments.$el.querySelectorAll('img').forEach(i => {
                    if (i.src) {
                        imgs.push(i.src)
                    }
                })
            }
            return imgs
        }
    },
    computed: {
        handleable() {
            return !this.flow.finished
                && !this.flow.suspended
                && this.flow.task !== undefined
                && !this.flow.task.finished
                && !this.flow.task.suspended
                && this.flow.task.assignee.id === this.user.id
                && this.$p('/fl/process/runtime/tasks/:id:POST')
        }
    }
}
</script>
<style lang="stylus">
.ii-gallery-modal {
    width: 40% !important;

    .ant-modal-content {
        background-color: transparent;
    }
}
</style>

<style lang="stylus" scoped>
@import '../../../../../styles/imports';

.ii-flow {
    height: 100%;
    width: 100%;
    overflow: hidden;
    background-color: white;

    .detail {
        width: 100%;
        height: 100%;
        display: flex;
        flex-direction: column;
        padding: 10px;
        // border-right: 1px solid $primary-color;
        overflow-y: auto;
        background-color: white;

        .title {
            text-align: center;
            font-size: 18px;
        }

        .form {
        }

        .operations {
            text-align: right;
            margin: 0 14px 14px 14px;
        }
    }

    .tabsplit {
        position: relative;

        .toolbar {
            position: absolute;
            right: 18px;
            z-index: 1;
            top: 11px;

            :not(:last-child) {
                margin-right: 10px;
            }
        }
    }

    .tabsplit-fullscreen {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        z-index: 50;
        width: 100% !important;
        padding: 0 20%;
    }

    .flowtabs {
        height: 100%;
        display: flex;
        flex-direction: column;
        padding: 10px;
        background-color: white;

        /deep/ .ant-tabs-bar {
            margin: 0;
        }

        .ant-tabs-content {
            flex: 1;
            height: 0;
        }

        .tabpanel {
            height: 100%;
        }
    }
}

.ant-carousel >>> .custom-slick-arrow {
    width: 25px;
    height: 25px;
    font-size: 25px;
    color: #fff;
    background-color: rgba(31, 45, 61, 0.11);
    opacity: 0.3;
}

.ant-carousel >>> .custom-slick-arrow:before {
    display: none;
}

.ant-carousel >>> .custom-slick-arrow:hover {
    opacity: 0.5;
}

.ant-carousel >>> .slick-dots {
    height: auto;
}

.ant-carousel >>> .slick-slide img {
    border: 5px solid #fff;
    display: block;
    margin: auto;
    max-width: 80%;
}

.ant-carousel >>> .slick-thumb {
    bottom: -45px;
    width: 100px;
    overflow-x: auto;
}

.ant-carousel >>> .slick-thumb li {
    width: 60px;
    height: 45px;
}

.ant-carousel >>> .slick-thumb li img {
    width: 100%;
    height: 100%;
    filter: grayscale(100%);
}

.ant-carousel >>> .slick-thumb li.slick-active img {
    filter: grayscale(0%);
}
</style>