<script>
import Signin from './Signin'
import { TrySigninInterceptor } from '../../../../framework/mixins'

export default {
    mixins: [Signin, TrySigninInterceptor]
}
</script>