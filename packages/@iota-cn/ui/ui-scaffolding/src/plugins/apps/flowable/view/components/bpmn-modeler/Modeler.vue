<template>
    <div class="modeler">
        <div class="canvas"
            ref="_canvas">
        </div>
        <div class="properties-panel-parent"
            ref="_properties">
        </div>
        <ul class="custom-toolbar">
            <li>
                <input ref='_fileInput'
                    type="file"
                    accept="text/xml"
                    :style="{ display: 'none' }" />
                <button type="button"
                    title="打开"
                    @click='onOpen'>
                    <i class='open' />
                </button>
            </li>
            <li class="divider">
                <button type="button"
                    title="保存"
                    @click='onSave'>
                    <i class='save' />
                </button>
            </li>
            <li>
                <button type="button"
                    title="撤销"
                    :disabled='!loaded||!commandStack||commandStack._stackIdx === -1'
                    @click='onUndo'>
                    <i class='undo' />
                </button>
            </li>
            <li class="divider">
                <button type="button"
                    title="恢复"
                    :disabled='!loaded||!commandStack||commandStack._stackIdx === commandStack._stack.length-1'
                    @click='onRedo'>
                    <i class='redo' />
                </button>
            </li>
            <li>
                <button type="button"
                    title="适应屏幕"
                    :disabled='!loaded'
                    @click='onFit'>
                    <i class='fit' />
                </button>
            </li>
            <li>
                <button type="button"
                    title="重置"
                    :disabled='!loaded'
                    @click='onResetZoom'>
                    <i class='zoom' />
                </button>
            </li>
            <li>
                <button type="button"
                    :disabled='!loaded||scale>=5'
                    title="放大"
                    @click='onZoomIn'>
                    <i class='zoom-in' />
                </button>
            </li>
            <li>
                <button type="button"
                    title="缩小"
                    :disabled='!loaded||scale<=0.2'
                    @click='onZoomOut'>
                    <i class='zoom-out' />
                </button>
            </li>
        </ul>
    </div>
</template>

<script>
import BpmnModeler from 'bpmn-js/lib/Modeler'
import propertiesPanelModule from './bpp-fork/lib'
import propertiesProviderModule from './bpp-fork/lib/provider/flowable'
import flowableDefinitions from './bpp-fork/flowable/flowable'
import Translate from './bpmn-custom/i18n/Translate'
import paletteCutomProvider from './bpmn-custom/palette'

export default {
    name: 'ii-bpmn-modeler',
    props: [
        'bpmnXML',
        'locale',
        'handleOpen',
        'processId'
    ],
    data() {
        return {
            innerXML: this.bpmnXML,
            modeler: undefined,
            scale: 1,
            loaded: false,
            commandStack: undefined
        }
    },
    beforeCreate() {
    },
    mounted() {
        let canvas = this.$refs._canvas
        let properties = this.$refs._properties
        let customTranslate = {
            // translate: ['value', require('./i18n/Translate').default]
            translate: ['value', Translate]
        }
        this.modeler = new BpmnModeler({
            additionalModules: [
                propertiesPanelModule,
                propertiesProviderModule,
                customTranslate,
                paletteCutomProvider
            ],
            container: canvas,
            propertiesPanel: {
                parent: properties
            },
            moddleExtensions: {
                flowable: flowableDefinitions
            }
        })
        this.reload()
    },
    watch: {
        innerXML: {
            handler() {
                this.reload()
            }
        },
        bpmnXML: {
            handler(val) {
                this.innerXML = val
                this.reload()
            }
        }
    },
    methods: {
        reload() {
            if (this.innerXML) {
                let that = this
                this.modeler.importXML(this.innerXML, function (err) {
                    if (err) {
                        that.$emit('load-error', err)
                    } else {
                        that.loaded = true
                        that.commandStack = that.modeler.get('commandStack')
                    }
                })
            }
        },
        onOpen() {
            if (this.handleOpen) { //由 外部 处理打开操作，可以做提示等其他交互
                this.handleOpen()
                return
            }
            this.$refs._fileInput.click()
            let that = this
            this.$refs._fileInput.type = "file"
            this.$refs._fileInput.accept = ".xml"
            this.$refs._fileInput.addEventListener('change', function () {
                let files = that.$refs._fileInput.files
                const reader = new FileReader()
                reader.readAsText(files[0])
                reader.onload = function (event) {
                    that.loaded = false
                    try {
                        let data = event.target.result
                        let parser = new DOMParser()
                        let doc = parser.parseFromString(data, "text/xml")
                        let process = doc.querySelector('process')
                        if (!process) {
                            that.$emit('parse-error', new Error('invalid xml file'))
                            return
                        }
                        if (that.processId) {
                            doc.querySelector('process').setAttribute('id', that.processId)
                            let xmlSerializer = new XMLSerializer();
                            data = xmlSerializer.serializeToString(doc)
                        }
                        that.innerXML = data
                        that.loaded = true
                    } catch (err) {
                        that.$emit('parse-error', err)
                    }
                }
            })
        },
        onSave() {
            this.modeler.saveXML({ format: true }, (err, xml) => {
                if (err) {
                    this.$emit('save-error', err)
                } else {
                    this.$emit('save', xml)
                }
            });
        },
        onUndo() {
            this.commandStack.undo()
        },
        onRedo() {
            this.commandStack.redo()
        },
        onResetZoom() {
            this.scale = 1
            this.modeler.get('canvas').zoom(this.scale)
        },
        onZoomIn() {
            this.scale = Math.min(this.scale * (1 + 0.1), 5)
            this.modeler.get('canvas').zoom(this.scale)
        },
        onZoomOut() {
            this.scale = Math.max(this.scale * (1 - 0.1), 0.2)
            this.modeler.get('canvas').zoom(this.scale)
        },
        onFit() {
            this.modeler.get('canvas').zoom('fit-viewport')
        }
    },
    computed: {
        // canRedo() {
        //     return this.commandStack
        // },
        // canUndo() {
        //     return this.commandStack
        // }
    }
}
</script>

<style>
@import "~bpmn-js/dist/assets/diagram-js.css";
@import "~bpmn-js/dist/assets/bpmn-font/css/bpmn.css";
</style>

<style lang="less">
@import "./bpp-fork/styles/properties.less";
</style>

<style lang="stylus" scoped>
.modeler {
    width: 100%;
    height: 100%;
    position: relative;

    .custom-toolbar {
        position: absolute;
        list-style: none;
        top: 20px;
        right: 320px;
        padding: 0 10px;
        margin: 0;
        background: #FFF;
        border: solid 1px #CCC;

        .divider:after {
            content: '';
            position: absolute;
            top: 50%;
            right: 0;
            transform: translateY(-50%);
            height: 16px;
            border-right: 1px solid #ddd;
        }

        li {
            position: relative;
            display: inline-block;
            padding: 6px 8px;
            list-style-type: none;

            button {
                padding: 0;
                outline: none;
                cursor: pointer;
                font-size: 22px;
                line-height: 26px;
                color: #555;
                background: none;
                border: none;

                &[disabled] {
                    filter: brightness(2.5);
                }

                i {
                    display: inline-block;
                    width: 16px;
                    height: 16px;
                    vertical-align: middle;
                }
            }
        }

        .open {
            background: url('./assets/icons/open.svg') 0 0 no-repeat;
        }

        .save {
            background: url('./assets/icons/save.svg') 0 0 no-repeat;
        }

        .undo {
            background: url('./assets/icons/undo.svg') 0 0 no-repeat;
        }

        .redo {
            background: url('./assets/icons/redo.svg') 0 0 no-repeat;
        }

        .fit {
            background: url('./assets/icons/zoomFit.svg') 0 0 no-repeat;
        }

        .zoom {
            background: url('./assets/icons/zoom.svg') 0 0 no-repeat;
        }

        .zoom-in {
            background: url('./assets/icons/zoomIn.svg') 0 0 no-repeat;
        }

        .zoom-out {
            background: url('./assets/icons/zoomOut.svg') 0 0 no-repeat;
        }
    }

    .canvas {
        width: 100%;
        height: 100%;
    }

    /deep/ .bjs-container {
        .djs-palette {
            background-color: white;
            width: 48px;

            .djs-palette-entries {
                .group:first-child {
                    hr {
                    }
                }

                .group {
                    .bpmn-custom-palette-start, .bpmn-custom-palette-end, .bpmn-custom-palette-intermediate {
                        &:hover {
                            color: rgb(255, 116, 0);
                        }
                    }

                    .bpmn-custom-palette-start {
                        color: #00BF9C;

                        &:hover {
                            color: rgb(255, 116, 0);
                        }
                    }

                    .bpmn-custom-palette-end {
                        color: #ED4757;
                    }

                    .bpmn-custom-palette-intermediate {
                        color: #fabd2d;
                    }
                }
            }
        }
    }

    .bjs-powered-by {
        display: none;
    }

    .properties-panel-parent {
        position: absolute;
        top: 0;
        bottom: 0;
        right: 0;
        width: 300px;
        z-index: 10;
        border-left: 1px solid #ccc;
        overflow: auto;

        &:empty {
            display: none;
        }

        /deep/ .bpp-properties-panel {
            background-color: #fdfdfd;

            * {
                font-weight: normal !important;
                font-size: 12px;
                font-style: normal;
            }

            .bpp-properties-tabs-container {
                .bpp-properties-tab {
                    .bpp-properties-group {
                        .group-toggle {
                            width: 2px;
                        }

                        .group-label {
                            font-size: 14px;
                        }

                        .bpp-properties-entry {
                            label {
                                font-size: 12px;
                            }

                            .bpp-field-description {
                                font-size: 12px;
                            }

                            .bpp-error-message {
                                font-size: 12px;
                            }
                        }

                        .bpp-textfield input {
                            padding-right: 0px;
                        }
                    }
                }
            }
        }
    }
}
</style>