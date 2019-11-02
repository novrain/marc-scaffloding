<template>
    <a-form :form="form"
        class="ii-login-form"
        @submit="handleSubmit">
        <span class="mark"></span>
        <h3>{{t('signin')}}</h3>
        <a-form-item>
            <a-input v-decorator="['username', {rules: [{ required: true, message: t('requireName') }] }]"
                :placeholder="t('username')">
                <a-icon slot="prefix"
                    type="user"
                    style="color: rgba(0,0,0,.25)" />
            </a-input>
        </a-form-item>
        <a-form-item>
            <a-input v-decorator="[
          'password',
          { rules: [{ required: true, message: t('requirePwd') }] },
        ]"
                type="password"
                :placeholder="t('password')">
                <a-icon slot="prefix"
                    type="lock"
                    style="color: rgba(0,0,0,.25)" />
            </a-input>
        </a-form-item>
        <a-form-item>
            <a-checkbox v-decorator="[
          'remember',
          {
            valuePropName: 'checked',
            initialValue: true,
          },
        ]">
                {{t('remember')}}
            </a-checkbox>
            <a class="forgot"
                href="">
                {{t('forgotPwd')}}
            </a>
            <a-button type="primary"
                html-type="submit"
                class="button">
                {{t("signin")}}
            </a-button>
        </a-form-item>
        <div v-if="user.loggedIn">
            <a-divider>{{$t('iota.global.authentication.or')}}</a-divider>
            <router-link :to='redirect'
                class="quick-signin">{{t('keepUsing', {user : user.username})}}</router-link>
        </div>
    </a-form>
</template>

<script>
// import Actions from '../store/actions'  
// ...mapActions(Objects.keys(Actions))
import { createNamespacedHelpers } from 'vuex'

const { mapActions } = createNamespacedHelpers('iota/global')

export default {
    beforeCreate() {
        this.form = this.$form.createForm(this, { name: 'normal_login' });
    },
    props: {
        redirect: String
    },
    methods: {
        handleSubmit(e) {
            let that = this
            e.preventDefault()
            this.form.validateFields((err, user) => {
                if (!err) {
                    that.signin({ require: user, that, redirect: this.redirect })
                }
            });
        },

        t(message, params) {
            return this.$t(`iota.global.authentication.${message}`, params)
        },

        ...mapActions(['signin'])
    },

    computed: {
        user() {
            // 这个模块需要从上层规定
            const state = this.$store.state.iota.global.authentication
            return state.user
        }
    }
};
</script>
<style lang="stylus" scoped>
@import '../../../../styles/imports';

.ii-login-form {
    width: 350px;
    padding: 30px;
    position: relative;
    left: 450px;
    background-color: white;

    .mark {
        position: absolute;
        width: 19px;
        height: 3px;
        background-color: $ii-primary-color;
        border-radius: 2px;
    }

    .forgot {
        float: right;
    }

    .button {
        width: 100%;
    }

    .quick-signin {
        width: 100%;
        text-align: center;
        display: inline-block;
    }
}
</style>