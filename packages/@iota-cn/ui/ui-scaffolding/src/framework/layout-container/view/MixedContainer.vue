<script>
import LayoutContainer from './LayoutContainer'
// const LayoutContainer = () => import('./LayoutContainer')
import MessageCenter from '../mixins/MessageCenter'
import { AuthenticationInterceptor, TrySigninInterceptor } from '../../mixins'

export default {
    mixins: [// 这里混入两个组件，这样减少依赖，注意顺序
        TrySigninInterceptor,
        AuthenticationInterceptor,
        MessageCenter,
        LayoutContainer
    ]
}
</script>