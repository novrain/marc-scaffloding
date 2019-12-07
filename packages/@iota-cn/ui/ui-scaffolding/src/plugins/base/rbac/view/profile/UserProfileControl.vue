<template>
    <a-dropdown :trigger="['click']">
        <div class="ii-user-profile-control-overlay"
            slot="overlay">
            <div class="basic">
                <iota-avatar-viewer :img='$user.gravatar||"/assets/imgs/defaultAvatar.png"'
                    :width='60'
                    :height='60' />
                <a-divider type="vertical"
                    class="divider" />
                <div class="name-mail">
                    <div>{{$user.username}}</div>
                    <div>{{$user.email||'--'}}</div>
                </div>
            </div>
            <a-divider />
            <a-list size="small"
                class="menu"
                :dataSource="menus">
                <a-list-item slot="renderItem"
                    slot-scope="item">
                    <router-link :to='item.linkTo'>{{item.name}}</router-link>
                </a-list-item>
            </a-list>
            <!-- <a-divider /> -->
            <div class="signout">
                <a-button size='small'
                    @click="signout()"
                    type="primary">{{$t('iota.frame.plugins.rbac.signout')}}</a-button>
            </div>
        </div>
        <div class="ii-user-profile-control">
            <iota-avatar-viewer :img='$user.gravatar||"/assets/imgs/defaultAvatar.png"'
                :width='32'
                :radius='50'
                :height='32' />
        </div>
    </a-dropdown>
</template>

<script>
import { createNamespacedHelpers } from 'vuex'

const { mapActions } = createNamespacedHelpers('iota/global')

export default {
    data() {
        return {
            open: false,
            menus: [
                {
                    name: this.$t('iota.frame.plugins.rbac.profile'),
                    linkTo: '/console/account/profile'
                }
            ],
        }
    },

    methods: {
        ...mapActions(['signout'])
    },

    computed: {
    }
}
</script>

<style lang="stylus" scoped>
@import '../../../../../styles/imports';

.ii-user-profile-control {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 0 10px;
    cursor: pointer;

    &:hover {
        background-color: darken($primary-color, 20%);
    }
}

.ii-user-profile-control-overlay {
    width: 300px;
    transition: opacity 0.1s linear 0s;
    box-shadow: $ii-box-shadow;
    padding: 10px 0 0 0;
    background-color: white;

    .ant-divider-horizontal {
        margin: 5px 0px;
    }

    .menu {
        margin: 0 10px;
    }

    .basic {
        display: flex;
        align-items: center;

        .divider {
            height: 30px;
        }

        .name-mail {
            display: flex;
            flex-direction: column;
            justify-content: center;
            margin-left: 10px;
        }
    }

    .signout {
        position: relative;
        display: flex;
        justify-content: flex-end;
        height: 30px;
        padding: 0 10px;
        align-items: center;
        background-color: lighten($primary-color, 80%);
    }
}
</style>