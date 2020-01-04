
<script>
export default {
    name: 'IiStatus',
    props: ['value', 'text', 'revert'],
    methods: {
        getValue() {
            return this.value;
        }
    },

    render() {
        let value = this.revert ? !this.value : this.value
        let icon = value ? (<AIcon type="check-circle" style={{ color: '#32CD32' }} />) : (
            <AIcon type="close-circle" style={{ color: '#DC143C' }} />);
        return this.text ? <span>{icon} {this.text}</span> : icon;
    }
}
</script>

<style>
</style>