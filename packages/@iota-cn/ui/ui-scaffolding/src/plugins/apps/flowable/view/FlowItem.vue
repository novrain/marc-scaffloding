<template>
    <div :class="selected?'ii-flow-item ii-flow-item_slected':'ii-flow-item'"
        @click="onClick">
        <div class="main">
            <div class="basic">
                <div class="head">
                    <span class="title">
                        {{flow.name}}
                    </span>
                    <div class="currentNode"
                        v-if="flow.currentNode">
                        当前节点：
                        <span class="node">
                            {{flow.currentNode}}
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
        <div class="extra">
        </div>
    </div>
</template>

<script>
import moment from 'moment'

export default {
    props: ['flow', 'selected'],
    data() {
        return {
            m: moment
        }
    },
    methods: {
        onClick() {
            this.$emit('click', this.flow)
        }
    },
    computed: {
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
                .title {
                    font-weight: 400;
                }

                .currentNode {
                    position: relative;
                    float: right;

                    .node {
                        color: $primary-color;
                    }
                }
            }

            .summary {
                color: $ii-gray-600;
                word-break: break-word;
            }
        }

        .desc {
            flex: 1;
            color: $ii-gray-600;
            word-break: break-word;
        }

        .more {
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
    }
}
</style>