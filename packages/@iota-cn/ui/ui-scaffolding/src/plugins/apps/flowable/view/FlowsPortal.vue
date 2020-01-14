<template>
    <div class="ii-flowable-portal">
        <div class="categoried-flowables">
            <a-modal :title='`新建${processdef.name}`'
                v-if="formDef && helper"
                :bodyStyle='{ maxHeight: "80%", padding: "10px" }'
                :width='formWidth'
                :visible='showAdd'
                @ok='onAddItemOk'
                @cancel='onAddItemCancel'>
                <ncform formName='_addItemForm'
                    :formSchema='formDef'
                    v-model='processVariables' />
            </a-modal>
            <template v-for="c in processdefsCategoried">
                <div :key="c.key"
                    class="category">
                    <span class="title">{{c.name}}</span>
                    <div class="processdefs">
                        <template v-for="p in c.processdefs">
                            <div :key="p.key"
                                class="processdef">
                                <div class="body">
                                    <span class="p-title"
                                        :key="p.key">{{p.name}}</span>
                                    <p class="desc">{{p.desc}}</p>
                                </div>
                                <a-divider type="vertical" />
                                <div class="operation">
                                    <a-button shape="circle"
                                        @click="()=>{onAddItem(p.processDefinitionKey)}"
                                        icon="plus"></a-button>
                                </div>
                            </div>
                        </template>
                    </div>
                </div>
            </template>
            <ii-empty v-if="processdefsCategoried.length === 0" />
        </div>
    </div>
</template>

<script>
import { message } from 'ant-design-vue/es'
import * as U from '../util'
import FlowHelperMixin from './components/FlowHelperMixin'

export default {
    name: 'IiFlowsPortal',
    props: ['id', 'containerId'],
    mixins: [FlowHelperMixin],
    data() {// 这里无法使用全局的计算属性
        const state = this.$store.state.iota.global.authentication
        const systemVariables = {
            initiatorId: state.user.id,
            initiatorName: U.nameOfUser(state.user),
            initiatorUser: U.idOfUser(state.user)
        }
        return {
            categories: {},
            showAdd: false,
            systemVariables: systemVariables,
            processVariables: {
                ...systemVariables
            },
            processDefinitionKey: undefined
        }
    },
    beforeCreate() {
        this.$axios.silentGet('/v1/api/dictionaries/frame_flowable_categories').then((res) => {
            if (res) {
                this.categories = {}
                res.data.items.forEach(i => {
                    this.categories[i.key] = { name: i.name, index: i.index }
                })
            }
        })
    },
    computed: {
        processdefsCategoried() {
            let processdefsAsArray = this.processdefsAsArray
            let categoried = {}
            let others = []
            processdefsAsArray.forEach(p => {
                if (p.disabled || !p.deployed) {
                    return
                }
                if (p.category && this.categories[p.category]) {
                    let theCategory = categoried[p.category] || []
                    theCategory.push(p)
                    categoried[p.category] = theCategory
                } else {
                    others.push(p)
                }
            })
            categoried = Object.keys(categoried).map(k => {
                return { key: k, processdefs: categoried[k], name: this.categories[k].name }
            })
            categoried.sort((l, r) => {
                return this.categories[l.key].index - this.categories[r.key].index
            })
            if (others.length > 0)
                categoried.push({
                    key: others,
                    name: '其他',
                    processdefs: others
                })
            return categoried
        }
    },
    methods: {
        onAddItem(processDefinitionKey) {
            if (processDefinitionKey) {
                this.processDefinitionKey = processDefinitionKey
                this.showAdd = true
            }
        },
        onAddItemOk() {
            this.$ncformValidate('_addItemForm').then(async data => {
                if (data.result) {
                    const variables = []
                    Object.keys(this.processVariables).forEach(k => {
                        variables.push({
                            name: k,
                            value: this.processVariables[k]
                        })
                    })
                    Object.keys(this.systemVariables).forEach(k => {
                        variables.push({
                            name: k,
                            value: this.systemVariables[k]
                        })
                    })
                    let process = {
                        processDefinitionKey: this.processDefinitionKey,
                        returnVariables: true,
                        variables: variables
                    }
                    // 允许增加参数
                    if (this.helper && this.helper.create) {
                        process = this.helper.create({ processdef: this.processdef, process: process })
                    }
                    process.variables = U.encodeFormVariables(process.variables)
                    this.$axios.silentPost(`/fl/process/runtime/process-instances`, process, true)
                        .then(() => {
                            message.success('新建成功，请在 由我发起 中查看')
                            this.showAdd = false
                            this.processVariables = {
                                ...this.systemVariables
                            }
                        }).catch(() => {
                            message.error('新建失败，请稍后再试')
                        })
                }
            })
        },
        onAddItemCancel() {
            this.showAdd = false
            this.processVariables = {
                ...this.systemVariables
            }
        },
    }
}
</script>

<style lang="stylus" scoped>
@import '../../../../styles/imports';

.ii-flowable-portal {
    height: 100%;
    width: 100%;
    overflow-y: auto;
    background-color: white;
    padding: 10px;

    .categoried-flowables {
        width: 100%;

        .category {
            border: 1px solid $ii-gray-100;
            margin-bottom: 10px;

            .title {
                display: block;
                padding: 10px;
                width: 100%;
                font-size: 16px;
                border-bottom: 1px solid $ii-gray-100;
            }

            .processdefs {
                display: flex;
                flex-wrap: wrap;

                .processdef {
                    display: flex;
                    width: 200px;
                    margin: 10px;
                    padding: 10px;
                    max-height: 200px;
                    border: 1px solid $ii-gray-100;
                    align-items: center;
                    justify-content: space-between;
                    box-shadow: 0 0 2px 0 rgba(0, 0, 0, 0.12), 0 2px 2px 0 rgba(0, 0, 0, 0.12);

                    &:hover {
                        box-shadow: 0 0 2px 0 rgba(0, 0, 0, 0.12), 0 2px 2px 0 rgba(0, 0, 0, 0.24);
                    }

                    .body {
                        .p-title {
                            display: block;
                            font-size: 15px;
                            margin-bottom: 5px;
                            cursor: pointer;

                            &:hover {
                                color: $primary-color;
                            }
                        }

                        .desc {
                            font-size: 12px;
                            color: $ii-gray-300;
                            margin: 0;
                        }
                    }

                    .operation {
                    }
                }
            }
        }
    }
}
</style>