<template>
    <div class="ii-user-profile">
        <a-card hoverable
            style="width: 300px">
            Basic
        </a-card>
        <div class="operation">
            Operation
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
        }
    },
};
</script>

<style lang="stylus" scoped>
.ii-user-profile {
    display: flex;
    justify-content: center;
    margin: 10px;
    flex: 1;
    align-items: flex-start;

    .operation {
        background-color: white;
        padding: 10px;
        margin-left: 10px;
        min-width: 600px;
    }
}
</style>