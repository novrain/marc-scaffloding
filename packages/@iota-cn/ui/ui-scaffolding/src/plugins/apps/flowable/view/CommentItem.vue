<template>
    <div class="ii-comment">
        <div class="container">
            <div class="header"
                v-if="!newComment">
                <div class="info">
                    <strong>{{innerComment.user.username || innerComment.user.fullname}}</strong>
                    <span>{{innerComment.createdAt}}</span>
                </div>
                <div class="top-toolbar"
                    v-if="status === 'view' && editorable">
                    <a-button type='link'
                        @click="handleChangeToEdit">编辑</a-button>
                    <a-popconfirm title="确认删除？"
                        okText="确认"
                        @confirm='handleDelete'
                        cancelText="取消">
                        <a-button type='link'>删除</a-button>
                    </a-popconfirm>
                </div>
            </div>
            <div class="header"
                v-else>
                <div class="info">
                    <strong>{{user.username || user.fullname}}</strong>
                    <span>{{innerComment.createdAt}}</span>
                </div>
            </div>
            <ckeditor :editor="editor.ui"
                v-if="newComment || status === 'edit'"
                v-model="innerComment.message"
                :config="editor.config"></ckeditor>
            <div v-else
                class="body"
                v-html="innerComment.message">
            </div>
            <div class="bottom-toolbar"
                v-if="newComment || status === 'edit'">
                <a-button v-if="status === 'edit'"
                    size='small'
                    @click="handleChangeToView">取消</a-button>
                <a-button v-if="newComment"
                    @click="handleNewComment"
                    size='small'>保存</a-button>
                <a-button v-else
                    @click="handleUpdate"
                    size='small'>更新</a-button>
            </div>
        </div>
    </div>
</template>

<script>
import moment from 'moment'
import * as U from '../util'
import ClassicEditor from '@ckeditor/ckeditor5-build-classic';

export default {
    props: ['index', 'id', 'user', 'comment', 'onDelete', 'onCreate', 'onUpdate'],
    data() {
        let editorable = false
        let innerComment = { message: '' }
        if (this.comment) {
            const user = U.parseAssignee(this.comment.createdBy || this.comment.author)
            if (user.id === this.user.id) {
                editorable = true
            }
            innerComment = Object.assign({}, this.comment)
            innerComment.user = user
            if (innerComment.createdAt || innerComment.time) {
                innerComment.createdAt = moment(innerComment.createdAt || innerComment.time).fromNow()
            }
        }
        return {
            editor: {
                ui: ClassicEditor,
                config: {
                    toolbar: ['bold', 'italic', 'bulletedList', 'numberedList']
                }
            },
            innerComment: innerComment,  // 内部的保存 comment 的变量
            newComment: !this.comment, // 如果没有传递 comment ，就是新建状态
            editorable: editorable, // 如果是当前用户的comment，就是可编辑的
            status: 'view' // 当是可编辑的时候，可以切换编辑状态 view / edit
        }
    },
    methods: {
        handleChangeToEdit() {
            this.status = 'edit'
        },
        handleChangeToView() {
            this.status = 'view'
            this.innerComment.message = this.comment.message
        },
        handleUpdate() {
            if (this.onUpdate) {
                let comment = {}
                comment.id = this.innerComment.id
                comment.processInstanceId = this.innerComment.processInstanceId
                comment.createdBy = comment.author = U.idOfUser(this.innerComment.user)
                comment.message = this.innerComment.message
                this.onUpdate({ comment, index: this.index }).then(() => {
                    this.status = 'view'
                }).catch(() => { })
            }
        },
        handleDelete() {
            if (this.onDelete) {
                let comment = {}
                comment.id = this.innerComment.id
                comment.processInstanceId = this.innerComment.processInstanceId
                this.onDelete({ comment, index: this.index }).catch(() => { })
            }
        },
        handleNewComment() {
            if (this.onCreate && this.innerComment.message) {
                let comment = Object.assign({}, this.innerComment)
                comment.createdBy = comment.author = U.idOfUser(this.user)
                this.onCreate({ comment }).then(() => {
                    this.innerComment.message = ''
                }).catch(() => { })
            }
        }
    }
}
</script>

<style lang="stylus" scoped>
@import '../../../../styles/imports';

.ii-comment {
    padding-bottom: 20px;
    position: relative;

    &:before { // 未来解决头像效率问题再使用
        position: absolute;
        top: 0;
        bottom: 0;
        left: 30px;
        display: block;
        width: 2px;
        content: '';
        background-color: $ii-gray-100;
    }

    .container {
        border: 1px solid $ii-gray-200;
        background-color: white;
        position: relative;

        /deep/ .ck-editor {
            padding: 5px;
        }

        /deep/ .ck.ck-button, a.ck.ck-button {
            height: 20px;
            width: 20px;
            padding: 0;
            min-width: 0;
            min-height: 0;
        }

        /deep/ .ck-editor__editable_inline {
            min-height: 100px;
            max-height: 250px;
        }

        .avatar {
            position: absolute;
            top: 0;
            left: -50px;
            z-index: 1;
            width: 33px;
            height: 33px;
            background-color: red;
        }

        .header {
            display: flex;
            justify-content: space-between;
            padding: 0px 10px;
            background-color: $ii-gray-100;
            position: relative;
            height: 32px;

            .info {
                display: flex;
                align-items: center;

                strong {
                    margin-right: 10px;
                }
            }

            .top-toolbar {
                button {
                    padding: 0 5px;
                }
            }

            .before { // 未来解决头像效率问题再使用
                position: absolute;
                top: 9px;
                right: 100%;
                left: -16px;
                display: block;
                width: 0;
                height: 0;
                pointer-events: none;
                content: ' ';
                border-color: transparent;
                border-style: solid solid outset;
                border-width: 8px;
                border-right-color: $ii-gray-100;
            }
        }

        .body {
            width: 100%;
            padding: 10px 10px 0 10px;
            overflow: visible;
            position: relative;
        }

        .bottom-toolbar {
            display: flex;
            justify-content: flex-end;
            padding: 10px;

            button {
                padding: 0 5px;
                margin: 0 5px;
            }
        }
    }
}
</style>