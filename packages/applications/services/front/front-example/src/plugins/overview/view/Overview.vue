<script>

export default {
    props: ['widgets'],
    data() {
        return {
        }
    },
    mounted() {
    },
    methods: {
    },
    watch: {
    },
    computed: {
    },
    render() {
        return (
            <div class='ii-app-overview'>
                {
                    this.widgets.map(w => {
                        const component = w.component
                        return <div class='widget'>
                            <component {...{ props: w.props }} />
                        </div>
                    })
                }
            </div>
        )
    }
}
</script>

<style lang="stylus" scoped>
@import '~@iota-cn/ui-scaffolding/src/styles/imports';

.ii-app-overview {
    width: 100%;
    height: 100%;
    overflow-y: auto;
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;

    .widget {
        width: calc(50% - 10px);
        height: 300px;
        display: inline-block;
        margin: 5px;
    }

    .rightMenu {
        box-shadow: $ii-box-shadow;
    }

    .col {
        height: 100%;
    }

    .bordered {
        border-right: 1px solid $primary-color;
    }

    .ii-card {
        height: 100%;
        width: 100%;
        overflow: hidden;
        background-color: white;
        display: flex;
        flex-direction: column;
    }

    .categories {
        height: 100%;
        width: 100%;
        display: flex;
        flex-direction: column;

        .operation {
            margin: 10px 10px 0 10px;
        }
    }
}
</style>>