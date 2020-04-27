<template>
    <a-card :bordered='false'
        :bodyStyle='bodyStyle'
        :style='style'>
        <template slot="extra">
            <slot name='extra'></slot>
        </template>
        <div slot="title"
            class='ii-card-head'>
            <slot name='icon'></slot>
            <span>{{title}}</span>
        </div>
        <template slot="default">
            <slot name='default'></slot>
        </template>
    </a-card>
</template>

<script>
export default {
    name: 'IiCard',
    props: ['title'],
    data() {
        return {
            bodyStyle: {
                padding: "2px",
                flex: 1,
                height: '100%'            },
            style: {
                height: '100%',
                width: '100%',
                overflow: 'hidden',
                backgroundColor: 'white',
                display: 'flex',
                flexDirection: 'column'
            }
        }
    }
}
</script>

<style lang="stylus" scoped>
.ii-card-head {
    span {
        color: $primary-color;
        margin-left: 8px;
    }
}</style>