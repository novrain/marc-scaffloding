import store from './store'
import messages from './view/locale'
import routes from './routes'

const entry = (opts, Vue) => {
    // const { id, containerId } = opts
    Vue.mixin({
        computed: {
            $settings() {
                const state = this.$store.state.iota.global.sysconfig
                const settings = Object.assign({}, state.settings || {})
                settings.logo = settings.logo ? `${this.$axios.baseURL()}${settings.logo}` : "/assets/imgs/defaultLogo.png"
                settings.collapsedLogo = settings.collapsedLogo ? `${this.$axios.baseURL()}${settings.collapsedLogo}` : "/assets/imgs/defaultLogoCollapsed.png"
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