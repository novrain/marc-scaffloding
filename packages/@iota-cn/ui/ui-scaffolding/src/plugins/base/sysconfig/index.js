import store from './store'
import messages from './view/locale'
import routes from './routes'

const entry = (opts, Vue) => {
    // const { id, containerId } = opts
    Vue.mixin({
        computed: {
            $settings() {
                const state = this.$store.state.iota.global.sysconfig
                const settings = {}
                state.settings.forEach(s => {
                    let value = s.value || s.defaultValue
                    switch (s.type) {
                        case 'image':
                            // 图片分上传或默认的，上传走API静态目录，默认走WEB静态目录
                            value = s.value ? `${this.$axios.baseURL()}${s.value}` : s.defaultValue
                            break
                        case 'boolean':
                            value = s.value === 'true'
                            break
                        default:
                            break
                    }
                    settings[s.key] = value
                })
                return settings
            }
        }
    })
    return {
        store: store(opts),
        messages,
        routes: routes(opts)
    }
}

export {
    entry
}