
<script>
import { Form } from 'ant-design-vue'
import { Validator } from '@iota-cn/util-validation'

export default Form.create()({
    props: ['data', 'user', 'type'],
    methods: {
        checkEmail(rule, value, callback) {
            if (value === '') {
                callback()
            }
            if (!Validator.isEmail(value)) {
                callback('邮箱输入错误或者已被注册')
            } else if (!this.data || (this.data && value != this.data.email)) {
                this.$axios.silentGet(`v1/api/validations/emails/validate?email=${value}`, true)
                    .then(() => {
                        callback()
                    })
                    .catch(() => {
                        callback('邮箱已存在')
                    })
            } else {
                callback()
            }
        },

        checkPassword(rule, value, callback) {
            if (value === '') {
                callback()
            }
            if (!Validator.isPassword(value)) {
                callback('支持6-16位数字、字母或下划线组合')
            } else {
                callback()
            }
        },

        checkName(rule, value, callback) {
            if (value === '') {
                callback()
            }
            if (!Validator.isUserName(value)) {
                callback(Validator.userNameHelp)
            } else if (!this.data || (this.data && value != this.data.username)) {
                this.$axios.silentGet(`v1/api/validations/usernames/validate?username=${value}`, true)
                    .then(() => {
                        callback()
                    })
                    .catch(() => {
                        callback('用户名已存在')
                    })
            } else {
                callback()
            }
        }
    },

    render() {
        let { data, user } = this
        const { getFieldDecorator } = this.form
        const formOptions = {
            props: {
                labelCol: { span: 6 },
                wrapperCol: { span: 18 }
            }
        }
        return (
            <div>
                {
                    this.type === 'changePwd' ?
                        <Form class={'editor'} layout='horizontal'>
                            <Form.Item
                                {...formOptions}
                                hasFeedback label="密码"
                            >
                                {getFieldDecorator('password', {
                                    rules: [{
                                        required: true, message: '请输入密码'
                                    }, {
                                        validator: this.checkPassword
                                    }]
                                })(
                                    <AInput type="password"
                                        maxLength="16"
                                        placeholder='请输入密码'
                                    />
                                )}
                            </Form.Item>
                        </Form> :
                        <Form class={'editor'}>
                            <Form.Item
                                {...formOptions}
                                hasFeedback label="用户名"
                            >
                                {getFieldDecorator('username', {
                                    rules: [{
                                        required: true, message: '请输入用户名'
                                    }, {
                                        validator: this.checkName
                                    }],
                                    initialValue: data ? data.username : ''
                                })(
                                    <AInput type="text"
                                        maxLength="24"
                                        placeholder='请输入用户名'
                                    />
                                )}
                            </Form.Item>

                            {this.type === 'edit' ? null : <Form.Item
                                {...formOptions}
                                hasFeedback label="密码"
                            >
                                {getFieldDecorator('password', {
                                    rules: [{
                                        required: true, message: '请输入密码'
                                    }, {
                                        validator: this.checkPassword
                                    }]
                                })(
                                    <AInput type="password"
                                        maxLength="16"
                                        placeholder='请输入密码'
                                    />
                                )}
                            </Form.Item>}

                            <Form.Item
                                {...formOptions}
                                hasFeedback label="邮箱"
                            >
                                {getFieldDecorator('email', {
                                    rules: [{
                                        required: true, message: '请输入绑定邮箱'
                                    }, {
                                        validator: this.checkEmail
                                    }],
                                    initialValue: data ? data.email : ''
                                })(
                                    <AInput type="text"
                                        maxLength="100"
                                        placeholder='请输入正确未绑定的邮箱'
                                    />
                                )}
                            </Form.Item>

                            <Form.Item
                                {...formOptions}
                                hasFeedback label="状态"
                                class='has-feed-back'
                            >
                                {getFieldDecorator('enable', {
                                    rules: [{
                                        required: true, message: '请选择状态'
                                    }],
                                    initialValue: this.type !== 'create' ? data.enable : true
                                })(
                                    <ASwitch checkedChildren={'激活'} unCheckedChildren={'禁用'}
                                        size={"default"}
                                        defaultChecked={this.type !== 'create' ? data.enable : true} />
                                )}
                            </Form.Item>

                            {user.isAdmin ? <Form.Item
                                {...formOptions}
                                hasFeedback label="管理员"
                                class='has-feed-back'
                            >
                                {getFieldDecorator('isAdmin', {
                                    rules: [{
                                        required: true, message: '是否管理员'
                                    }],
                                    initialValue: this.type !== 'create' ? data.isAdmin : false
                                })(
                                    <ASwitch checkedChildren={'是'} unCheckedChildren={'否'}
                                        size={"default"}
                                        defaultChecked={data.isAdmin} />
                                )}
                            </Form.Item>
                                : null
                            }
                        </Form>
                }
            </div>
        )
    }
})
</script>

<style lang="stylus">
.has-feed-back {
    /deep/ .ant-form-item-children {
        display: block;
    }
}
</style>

<style lang="stylus" scoped>
.editor {
    position: relative;
    max-width: 500px;
    margin: 0 auto;
}
</style