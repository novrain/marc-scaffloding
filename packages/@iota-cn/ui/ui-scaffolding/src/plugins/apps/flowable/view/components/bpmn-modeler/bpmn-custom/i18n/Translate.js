import zhCN from './zh-cn'

let locale = 'zh-cn'

export default function translate(template, replacements) {
    replacements = replacements || {}

    // Translate
    if (!zhCN[template])
        console.log(template)

    template = locale === 'zh-cn' ? zhCN[template] || template : template

    // Replace
    return template.replace(/{([^}]+)}/g, function (_, key) {
        return replacements[key] || '{' + key + '}'
    })
}