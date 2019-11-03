
<script>
export default {
    props: ['value', 'text'],
    methods: {
        getValue() {
            return this.value;
        }
    },

    render() {
        let icon = this.value ? (<AIcon type="check-circle" style={{ color: '#32CD32' }} />) : (
            <AIcon type="close-circle" style={{ color: '#DC143C' }} />);
        return this.text ? <span>{icon} {this.text}</span> : icon;
    }
}
</script>

<style>
</style>