<template>
    <component v-if="processdef"
        :is='processdef.component'
        v-bind='$props' />
</template>

<script>
import FlowHelperMixin from './components/FlowHelperMixin'
export default {
    name: 'IiSingleFlowable',
    props: ['processDefinitionKey', 'id', 'containerId'],
    mixins: [FlowHelperMixin],
    data() {
        return {}
    }
}
</script>