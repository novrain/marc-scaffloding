<template>
    <a-row class="ii-flow">
        <a-tabs defaultActiveKey="content"
            size="small"
            class="flowtabs">
            <a-tab-pane tab="正文"
                class="tabpanel"
                key="content">
                <div class="detail"
                    ref='_detail'>
                    <!-- <a-back-top :target='()=>$refs._detail' /> -->
                    <div class="title">
                        {{flow.name}}
                    </div>
                    <ncform :form-schema="formDef"
                        v-if="formDef"
                        v-model="formData"
                        :is-dirty.sync="isFormDirty"></ncform>
                    <ii-comments :user='user'
                        :flow='flow' />
                </div>
            </a-tab-pane>
            <a-tab-pane tab="流程"
                key="tasks">
                <ii-tasks :user='user'
                    :flow='flow' />
            </a-tab-pane>
            <a-tab-pane tab="附件"
                class="tabpanel"
                key="attachements">
                <ii-attachments :user='user'
                    :flow='flow' />
            </a-tab-pane>
        </a-tabs>
    </a-row>
</template>

<script>
import Comments from './Comments'
import Attachments from './Attachments'
import Tasks from './Tasks'

export default {
    components: {
        "ii-comments": Comments,
        "ii-attachments": Attachments,
        "ii-tasks": Tasks
    },
    props: ['flow', 'processDef', 'user'],
    data() {
        return {
            formData: {},
            isFormDirty: false,
            formDef: undefined,
            contents: {
                items: []
            }
        }
    },
    watch: {
        flow: {
            handler() {
                this.refetch()
            }
        },
        processDef: {
            handler() {
                this.updateForm()
            }
        }
    },
    mounted() {
        this.refetch()
    },
    methods: {
        refetch() {
            const instanceId = this.flow.processInstanceId
            // 如果没有定义，则查询一下，通过watch来触发刷新form
            if (!this.processDef) {
                this.$axios.silentGet(`/fl/process/${instanceId}`, true)
                    .then((res) => {
                        this.processDef = res.data
                    })
            } else {
                this.updateForm()
            }
        },
        // onChange({ paths, itemValue, formValue }) {
        //     console.log(typeof itemValue, itemValue, paths, formValue)
        // },
        updateForm() {
            // 确保数据是深度复制的，避免相互间的冲突
            this.formData = Object.assign({}, this.flow.formData)
            this.formDef = JSON.parse(this.processDef.formDef)
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
                    currentNode: this.flow.currentNode
                }
            }
            if (!this.flow.task || this.flow.task.assignee.id !== this.user.id) {
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
        }
    }
}
</script>

<style lang="stylus" scoped>
@import '../../../../styles/imports';

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
        border-right: 1px solid $primary-color;
        overflow-y: auto;

        .title {
            text-align: center;
            font-size: 18px;
        }

        .form {
        }
    }

    .flowtabs {
        height: 100%;
        display: flex;
        flex-direction: column;
        padding: 10px;

        /deep/ .ant-tabs-bar {
            margin: 0;
        }

        .tabpanel {
            height: 100%;
        }
    }
}
</style>>