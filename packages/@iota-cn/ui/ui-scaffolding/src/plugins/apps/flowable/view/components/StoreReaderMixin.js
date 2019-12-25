export default {
    props: ['id', 'containerId'],
    data() {
        return {}
    },
    methods: {
        findProcessdef(processDefinitionKey) {
            return this.$store.getters[`iota/${this.containerId}/${this.id}/processdef`](processDefinitionKey)
        }
    },
    computed: {
        processdefsAsArray() {
            return this.$store.getters[`iota/${this.containerId}/${this.id}/processdefsAsArray`]
        },
        processdefs() {
            return this.$store.getters[`iota/${this.containerId}/${this.id}/processdefs`]
        }
    }
}