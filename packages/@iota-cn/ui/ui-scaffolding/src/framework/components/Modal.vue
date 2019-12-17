<script>

export default {
    name: 'IiModal',
    props: ['button', 'content', 'title', 'ok', 'cancel', 'clearFloat', 'width'],
    data() {
        return {
            visible: false,
            confirmLoading: false
        }
    },
    methods: {
        showModal() {
            this.visible = true
        },
        handleOk() {
            this.confirmLoading = true
            if (this.ok) {
                //涉及到异步方法时，需要包装成promise。暂不支持dispatch方法
                this.ok().then((result) => {
                    if (result) {
                        this.visible = false
                        this.confirmLoading = false
                    } else {
                        this.confirmLoading = false
                    }
                }).catch(() => {
                    this.confirmLoading = false
                })
            } else {
                this.$emit('ok')
                this.visible = false
                this.confirmLoading = false
            }
        },
        handleCancel() {
            if (this.cancel) {
                this.cancel()
            } else {
                this.$emit('cancel')

            }
            this.visible = false
        }
    },

    render() {
        return (
            <div class={this.clearFloat ? 'button' : 'modal'}>
                <div onClick={this.showModal}>
                    {this.button}
                </div>
                <AModal
                    // key={this.key}
                    title={this.title}
                    visible={this.visible}
                    onOk={this.handleOk}
                    confirmLoading={this.confirmLoading}
                    onCancel={this.handleCancel}
                    width={this.width}
                >
                    {this.content}
                </AModal>
            </div>
        )
    }
}
</script>

<style lang="stylus" scoped>
.modal {
    display: block;
    float: left;
}

.button {
    display: inline-block;
}
</style>