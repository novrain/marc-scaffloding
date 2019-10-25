## IOTA validation

iota validation for front-end and back-end

## usage

类似 Laravel validation 的 API

```js
const data = {
    username: 'iotahele',
    phone: '13838384381',
    email: 'he.le@theiota.cn',
    password: 'itismypassowrd123'
}

const validation = new Validation(data, {
    username: 'name|min:3|max:12',
    phone: 'phone|min:3',
    email: 'email|min:3|max:16',
    password: 'min:3'
})

const result = validation.exec()
```

1. 构造需要验证的对象
2. new Validation 第二个参数的key和data中的key需要一致, value 是规则
3. 执行exec()

在所有规则验证成功之后会返回 `true`，
失败会返回最先失败的信息

## rules

规则有以下几个

* phone 手机号
* email 邮箱
* name 用户名，不允许奇葩字符
* min 最短要多短
* max 最长要多长

规则可以通过`|`组合

