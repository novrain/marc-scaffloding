<script>
import { message } from 'ant-design-vue/es'
import moment from 'moment'
import * as U from '../../util'

export default {
    props: ['user', 'flow', 'active'],
    components: {
    },
    data() {
        return {
            contents: { //接口暂不支持分页
                items: []
            },
            limit: 60,
            page: 1,
            total: 0
        }
    },
    watch: {
        flow: {
            handler() {
                this.refetch()
            }
        },
        active: {
            handler() {
                this.refetch()
            }
        }
    },
    mounted() {
        this.refetch()
    },
    methods: {
        onPageChange(page) {
            this.page = page
            this.refetch()
        },
        onLimitChange(current, pageSize) {
            this.limit = pageSize
            this.page = 1
            this.refetch()
        },
        refetch() {
            if (!this.active) {
                return
            }
            this.contents.items = []
            const instanceId = this.flow.processInstanceId
            const start = (this.page - 1) * this.limit
            this.$axios.silentGet(`/fl/content/content-service/content-items?processInstanceId=${instanceId}&size=${this.limit}&start=${start}&sort=created&order=desc`, true)
                .then((res) => {
                    this.contents.items = res.data.data.map(attachment => {
                        attachment.user = U.parseAssignee(attachment.createdBy)
                        attachment.created = moment(attachment.created).format('YYYY-MM-DD HH:mm:ss')
                        attachment.link = `${this.$axios.baseURL()}/fl/content/content-service/content-items/${attachment.id}/data`
                        return attachment
                    })
                    this.total = res.data.size
                }).catch(() => { })
        },
        onDelete({ record }) {
            return () => {
                return this.$axios.silentDelete(`/fl/content/content-service/content-items/${record.id}`, true)
                    .then(() => {
                        // this.contents.items.splice(index, 1)
                        this.refetch()
                        return true
                    }).catch(() => { return true })
            }
        },
        onUpload({ file }) {
            if (file.status === 'done') {
                // const attachment = file.response
                // attachment.user = U.parseAssignee(attachment.createdBy)
                // attachment.created = moment(attachment.created).format('YYYY-MM-DD HH:mm:ss')
                // this.contents.items = [attachment].concat(this.contents.items)
                this.refetch()
            } else if (file.status === 'error') {
                message.error('文件上传失败，请稍后重试')
            }
        }
    },
    computed: {
        uploadParams() {
            return {
                createdBy: U.idOfUser(this.user),
                processInstanceId: this.flow.processInstanceId
            }
        },
        uploadAction() {
            return `${this.$axios.baseURL()}/fl/content/content-service/content-items`
        }
    },
    render() {
        const disabled = this.flow.finished
        const columns = [
            {
                title: '文件名',
                dataIndex: 'name',
                key: 'name',
                width: '30%',
            },
            {
                title: '用户',
                dataIndex: 'createdBy',
                key: 'createdBy',
                width: '30% ',
                customRender: (text, record) => {
                    let user = record.user || {}
                    return user.fullname || user.username || record.createdBy
                }
            },
            {
                title: '创建时间',
                dataIndex: 'created',
                key: 'created',
                width: '20% '
            },
            {
                title: '操作',
                dataIndex: 'operation',
                width: '20%',
                customRender: (text, record, index) => {
                    // 预览依赖浏览器，暂时去掉              
                    // <ADivider type="vertical" />
                    // <a href={`${record.link}`} target='_blank' onClick={(e) => e.stopPropagation()}>预览</a>
                    return (
                        <div class='operation'>
                            {
                                this.$p('/fl/content/content-service/content-items/:attachmentId/data:GET') ?
                                    <a href={`${record.link}?op=download`} target='_blank' download={record.name} onClick={(e) => e.stopPropagation()}>下载</a>
                                    : null
                            }
                            <ADivider type="vertical" />
                            {
                                this.$p('/fl/content/content-service/content-items/:id:DELETE')
                                    && record.user.id === this.user.id && !disabled
                                    ? <IiModal
                                        title="删除"
                                        content={(<span>是否删除附件:{record.name}</span>)}
                                        button={(<a>删除</a>)}
                                        ok={this.onDelete({ record, index })}
                                        clearFloat={true} />
                                    : null
                            }
                        </div>
                    )
                },
            }]
        const pageSizeOptions = ['20', '40', '60', '80']
        return (
            <div class="ii-attachments">
                {
                    disabled || !this.$p('/fl/content/content-service/content-items:POST') ?
                        null
                        :
                        <a-upload-dragger name="file"
                            class="upload"
                            multiple={false}
                            onChange={this.onUpload}
                            action={this.uploadAction}
                            data={this.uploadParams}
                            showUploadList={false}>
                            <a-icon class="icon"
                                type="inbox" />
                            <span class="text">拖拽文件或点击选择文件</span>
                        </a-upload-dragger>
                }
                <IiTableLayout
                    size='small'
                    headheight={68}
                    total={this.total}
                    pageSize={this.limit}
                    currentPage={this.page}
                    showSizeChanger={true}
                    onShowSizeChange={this.onLimitChange}
                    onPaginationChange={this.onPageChange}
                    pageSizeOptions={pageSizeOptions}
                    class={'table'}
                    showPagination='both'
                    columns={columns}
                    rows={this.contents.items}>
                </IiTableLayout>
                {
                    this.previewDoc && this.showPreview ?
                        <a-modal centered
                            class="ii-preview-modal"
                            v-model={this.showPreview}
                            closable={true}
                            footer={null} >
                            <object>
                                <embed src={this.previewDoc.link} type={this.previewDoc.mimeType} class='ii-preview-embed' />
                            </object>
                        </a-modal>
                        : null
                }
            </div>
        )
    }
}
</script>
<style lang="stylus">
.ii-preview-modal {
    width: 90% !important;
    height: 90%;

    .ant-modal-content {
        height: 100%;

        .ant-modal-body {
            height: 100%;
            overflow-y: auto;
            text-align: center;
        }
    }
}

.ii-preview-embed {
    width: 96%;
    min-height: 100%;
    margin: 0 auto;
}
</style>

<style lang="stylus" scoped>
@import '../../../../../styles/imports';

.ii-attachments {
    height: 100%;

    .upload {
        display: block;
        margin: 10px;
        border-bottom: 1px solid $ii-gray-100;

        /deep/ .ant-upload-drag-container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 10px 0;
        }

        .icon {
            font-size: 32px;
            line-height: 32px;
        }

        .text {
            font-size: 12px;
        }

        .ant-upload-list {
            display: none;
        }
    }

    .operation {
        display: flex;
        justify-content: left;
        align-items: center;

        a {
            color: $primary-color;
        }
    }
}
</style>