<template>
    <div :class="selected?'ii-flow-item ii-flow-item_slected':'ii-flow-item'"
        @click="onClick">
        <div class="main">
            <div class="basic">
                <div class="head">
                    <span class="title">
                        {{flow.name}}
                    </span>
                    <div class="currentTask"
                        v-if="!flow.finished && flow.task">
                        当前节点：
                        <span class="node">
                            {{flow.task.name}}
                        </span>
                    </div>
                </div>
                <div class="summary">
                    {{flow.summary}}
                </div>
            </div>
            <div class="desc">
                {{flow.desc}}
            </div>
            <div class="more">
                <ul>
                    <li>
                        <span>发起人:</span>
                        <span>{{flow.formData.initiatorName}}</span>
                    </li>
                </ul>
                <span class="createTime">{{m(flow.createTime).fromNow()}}</span>
            </div>
        </div>
        <div class="extra"
            v-if="!flow.finished">
            <a-popconfirm v-if="cancelable"
                title="确认取消？"
                okText="确认"
                @confirm='handleCancel'
                cancelText="取消">
                <a-button type='link'>取消</a-button>
            </a-popconfirm>
            <a-popconfirm v-if="suspendable"
                title="确认挂起？"
                okText="确认"
                @confirm='handleSuspend'
                cancelText="取消">
                <a-button type='link'>挂起</a-button>
            </a-popconfirm>
            <a-popconfirm v-if="activeable"
                title="确认激活？"
                okText="确认"
                @confirm='handleActive'
                cancelText="取消">
                <a-button type='link'>激活</a-button>
            </a-popconfirm>
        </div>
    </div>
</template>

<script>
import moment from 'moment'

export default {
    props: ['flow', 'selected', 'user', 'onCancel', 'onClaim', 'onDelegate', 'onResolve', 'onSuspend', 'onActive'],
    data() {
        return {
            m: moment
        }
    },
    methods: {
        onClick() {
            this.$emit('click', this.flow)
        },
        handleCancel() {
            if (this.onCancel) {
                this.onCancel({ flow: this.flow }).catch(() => { })
            }
        },
        handleSuspend() {
            if (this.onSuspend) {
                this.onSuspend({ flow: this.flow }).catch(() => { })
            }
        },
        handleActive() {
            if (this.onActive) {
                this.onActive({ flow: this.flow }).catch(() => { })
            }
        },

    },
    computed: {
        cancelable() {
            return (this.user.isAdmin || this.flow.formData.initiatorId === this.user.id) && !this.flow.endTime
        },
        claimable() {
            return false // 到任务侧去做认领，不在这里重复做；或者能提供通用方法出来
        },
        resolveable() {
            // 暂不支持
            return false
        },
        suspendable() {
            return (this.user.isAdmin || this.flow.formData.initiatorId === this.user.id) && this.flow.suspended === false
        },
        activeable() {
            return (this.user.isAdmin || this.flow.formData.initiatorId === this.user.id) && this.flow.suspended === true
        }
    }
}
</script>

<style lang="stylus" scoped>
@import '../../../../styles/imports';

.ii-flow-item {
    display: flex;
    width: 100%;
    border-bottom: 1px solid $ii-gray-300;
    padding: 10px;
    cursor: pointer;

    &:hover {
        border-bottom: 1px solid $primary-color;
        background-color: $ii-gray-100;
    }

    &_slected {
        border-bottom: 1px solid $primary-color;
        background-color: $ii-gray-100;
    }

    .main {
        flex: 1;
        flex-direction: column;

        .basic {
            .head {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 2px;

                .title {
                    font-weight: 500;
                    font-size: 19px;
                    overflow: hidden;
                    white-space: nowrap;
                    text-overflow: ellipsis;
                }

                .currentTask {
                    position: relative;
                    float: right;

                    .node {
                        color: $ii-gray-800;
                        overflow: hidden;
                        white-space: nowrap;
                        text-overflow: ellipsis;
                    }
                }
            }

            .summary {
                margin-bottom: 2px;
                margin-left: 5px;
                color: $ii-gray-500;
                overflow: hidden;
                white-space: nowrap;
                text-overflow: ellipsis;
            }
        }

        .desc {
            margin-left: 5px;
            flex: 1;
            color: $ii-gray-500;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        .more {
            margin-left: 5px;
            color: $ii-gray-300;

            ul {
                list-style: none;
                margin: 0;
                padding: 0;
                display: inline-block;

                li {
                    position: relative;
                    display: inline-block;
                    padding-right: 8px;

                    span {
                        padding-right: 4px;
                    }
                }
            }

            .createTime {
                position: relative;
                display: inline-block;
                float: right;
            }
        }
    }

    .extra {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        margin-left: 10px;
        padding: 0 0 0 10px;
        border-left: 1px solid $ii-gray-200;

        a {
            color: $primary-color;
            cursor: pointer;
        }
    }
}
</style>