<template>
    <div ref="container"
        :class="fullscreen ? 'ii-bpmn-diagram-container ii-bpmn-diagram-container-fullscreen' : 'ii-bpmn-diagram-container'">
        <div class='toolbar'>
            <a-button size='small'
                @click='onFullscreen'
                :icon="fullscreen ? 'shrink' : 'arrows-alt'" />
            <a-divider type="vertical" />
            <a-button size='small'
                @click='onFit'
                icon="fullscreen" />
            <a-button size='small'
                @click='onZoomIn'
                icon="plus" />
            <a-button size='small'
                @click='onZoomOut'
                icon="minus" />
        </div>

        <resize-observer @notify='onResize' />
    </div>
</template>

<script>
import BpmnJS from 'bpmn-js/dist/bpmn-navigated-viewer.production.min.js';

export default {
    name: 'ii-bpmn-viewer',
    props: {
        url: {
            type: String
        },
        bpmnXML: {
            type: String
        }
    },
    data: function () {
        return {
            diagramXML: this.bpmnXML,
            fullscreen: false,
            done: false
        };
    },
    mounted: function () {
        var container = this.$refs.container;
        var self = this;
        this.bpmnViewer = new BpmnJS({
            container: container
        });
        this.bpmnViewer.on('import.done', function (event) {
            var error = event.error;
            var warnings = event.warnings;
            if (error) {
                self.$emit('error', error);
            } else {
                self.$emit('shown', warnings);
            }
            self.bpmnViewer.get('canvas').zoom('fit-viewport');
            self.done = true
        });
        this.load()
        if (this.url) {
            this.fetchDiagram(this.url);
        }
    },
    beforeDestroy: function () {
        this.bpmnViewer.destroy();
    },
    watch: {
        url: function (val) {
            this.$emit('loading');
            this.fetchDiagram(val);
        },
        bpmnXML: function (val) {
            this.diagramXML = val
            this.load()
        },
        diagramXML: function () {
            this.load()
        }
    },
    updated() {
        // this.bpmnViewer.get('canvas').zoom('fit-viewport');
    },
    methods: {
        load() {
            if (this.diagramXML) {
                this.bpmnViewer.importXML(this.diagramXML, (err) => {
                    if (err) {
                        this.$emit('load-error', err)
                    } else {
                        this.$emit('loaded')
                    }
                })
            }
        },
        fetchDiagram: function (url) {
            var self = this;
            fetch(url)
                .then(function (response) {
                    return response.text();
                })
                .then(function (text) {
                    self.diagramXML = text;
                })
                .catch(function (err) {
                    self.$emit('load-error', err);
                });
        },
        onResize() {
            if (this.done) {
                this.onFit()
            }
        },
        onZoomIn() {
            this.bpmnViewer.get('zoomScroll').stepZoom(1);
        },
        onZoomOut() {
            this.bpmnViewer.get('zoomScroll').stepZoom(-1);
        },
        onFullscreen() {
            this.fullscreen = !this.fullscreen
        },
        onFit() {
            this.bpmnViewer.get('canvas').zoom('fit-viewport');
            // weird fit one more time.
            this.bpmnViewer.get('canvas').zoom('fit-viewport');
        },
        colorNode(node) {
            this.bpmnViewer.get('canvas').addMarker(node, 'highlight')
        }
    }
};
</script>

<style lang="stylus" scoped>
@import '../../../../../styles/vars';

.ii-bpmn-diagram-container {
    height: 100%;
    width: 100%;
    background-color: white;

    .toolbar {
        position: absolute;
        top: 10px;
        right: 10px;
        z-index: 100;
    }

    /deep/ .bjs-powered-by {
        color: #efefef;
    }

    /deep/ .highlight:not(.djs-connection) .djs-visual > :nth-child(1) {
        fill: lighten($primary-color, 50%) !important;
    }
}

.ii-bpmn-diagram-container-fullscreen {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    z-index: 100;
}
</style>
