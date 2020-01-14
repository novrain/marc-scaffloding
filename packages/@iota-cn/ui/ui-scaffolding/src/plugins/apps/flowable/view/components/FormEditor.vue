<template>
    <div class="ii-form-editor">
        <div class="body">
            <splitpanes class="default-theme">
                <splitpane class="splitpane"
                    :size='50'
                    :min-size="30"
                    :max-size="70">
                    <div ref='_jsonEditor'
                        class="code" />
                </splitpane>
                <splitpane class="splitpane"
                    :size='50'
                    :style='{ flex: 1 }'>
                    <ncform formName='_ncformEditor'
                        :formSchema='jsonSchema' />
                </splitpane>
            </splitpanes>
        </div>
        <div class="footer">
            <a-button @click="onCancel">取消</a-button>
            <a-button type='primary'
                @click="onOk">确定</a-button>
        </div>
    </div>
</template>

<script>
import { message } from 'ant-design-vue/es'
import JSONEditor from 'jsoneditor'
import 'jsoneditor/dist/jsoneditor.min.css'

export default {
    props: ['schema'],
    data() {
        return {
            innerSchema: this.schema || '{}',
            editor: undefined,
            errors: false
        }
    },
    mounted() {
        const editorContainer = this.$refs._jsonEditor
        this.editor = new JSONEditor(editorContainer, {
            onChange: this.onChange,
            onValidationError: this.onValidationError,
            mode: "code",
            indentation: 2
        })
        this.editor.setText(this.innerSchema)
    },
    methods: {
        onChange() {
            try {
                let json = this.editor.getText()
                this.$emit('change', json)
                this.innerSchema = json
            } catch (e) {
                this.$emit('error', e)
            }
        },
        onValidationError(errors) {
            this.errors = errors
        },
        onCancel(e) {
            this.$emit('cancel', e)
        },
        onOk() {
            if (this.errors.length > 0) {
                message.error('表单定义存在错误，请修改')
                return
            }
            this.$emit('ok', this.innerSchema)
        }
    },
    watch: {
        schema: {
            handler(newSchema) {
                this.innerSchema = newSchema
                if (this.editor) {
                    this.editor.setText(this.innerSchema)
                }
            }
        }
    },
    computed: {
        jsonSchema() {
            let jsonObject = { type: 'object' }
            try {
                jsonObject = JSON.parse(this.innerSchema)
                // eslint-disable-next-line
            } catch (e) {
            }
            return jsonObject
        }
    }
}
</script>

<style lang="stylus" scoped>
.ii-form-editor {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;

    .body {
        flex: 1;
        overflow: hidden;

        .splitpane {
            overflow: scroll;
            margin: 10px;

            .code {
                height: 100%;
            }
        }
    }

    .footer {
        padding: 10px 16px;
        text-align: right;
        border-top: 1px solid #e8e8e8;
        border-radius: 0 0 0px 0px;

        button:not(:last-child) {
            margin-right: 8px;
        }
    }
}
</style>>