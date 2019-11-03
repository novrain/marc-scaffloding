import { Validator } from '@iota-cn/util-validation'

export default {
    en: {

    },
    'zh-cn': {
        iota: {
            frame: {
                validator: {
                    intHelp: Validator.intHelp,
                    nameHelp: Validator.nameHelp,
                    versionHelp: Validator.versionHelp,
                    commonStrHelp: Validator.commonStrHelp
                },
                components: {
                    common: {
                        name: '名称',
                        desc: '描述',
                        enterWhat: '请输入%{what}'
                    },
                    tablelayout: {
                        total: '总共 %{total} 条',
                        selected: '已选 %{count} 条'
                    }
                }
            }
        }
    }
}
