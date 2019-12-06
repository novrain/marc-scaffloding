<template>
    <div class="ii-comments">
        <ii-comment-item :user='user'
            v-if='commentable && $p("/fl/process/history/historic-process-instances/:instanceId/comments:POST")'
            :onCreate='onCreateComment' />
        <template v-for="(comment, index) in comments.items">
            <ii-comment-item :key="comment.id"
                :comment='comment'
                :index='index'
                :user='user'
                :disabled='!commentable'
                :onDelete='onDeleteComment'
                :onUpdate='onUpdateComment' />
        </template>
    </div>
</template>

<script>
import CommentItem from './CommentItem'
export default {
    props: ['user', 'flow', 'active'],
    components: {
        'ii-comment-item': CommentItem
    },
    data() {
        return {
            comments: { //接口暂不支持分页
                items: []
            },
        }
    },
    watch: {
        flow: {
            handler() {
                this.refetch()
            }
        },
        activce: {
            handler() {
                this.refetch()
            }
        }
    },
    mounted() {
        this.refetch()
    },
    methods: {
        refetch() {
            this.comments.items = []
            const instanceId = this.flow.processInstanceId
            this.$axios.silentGet(`/fl/process/history/historic-process-instances/${instanceId}/comments`, true)
                .then((res) => {
                    this.comments.items = res.data
                }).catch(() => { })
        },
        async onCreateComment({ comment }) {
            const instanceId = this.flow.processInstanceId
            return this.$axios.silentPost(`/fl/process/history/historic-process-instances/${instanceId}/comments`, comment, true)
                .then((res) => {
                    this.comments.items = [res.data].concat(this.comments.items)
                })
        },
        async onUpdateComment({ comment }) {
            return this.$axios.silentPut(`/fl/process/history/historic-process-instances/${comment.processInstanceId}/comments/${comment.id}`, comment, true)
                .then(() => {
                    // 不需要更新
                })
        },
        async onDeleteComment({ comment, index }) {
            return this.$axios.silentDelete(`/fl/process/history/historic-process-instances/${comment.processInstanceId}/comments/${comment.id}`, true)
                .then(() => {
                    this.comments.items.splice(index, 1)
                })
        }
    },
    computed: {
        commentable() {
            return !this.flow.finished
        }
    }
}
</script>

<style lang="stylus" scoped>
@import '../../../../../styles/imports';

.ii-comments {
    border-top: 1px solid $ii-gray-300;
    padding: 10px;
}
</style>