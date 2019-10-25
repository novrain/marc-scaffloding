    #account 接口名称
    #账户
        1.GET  /accounts/current 获取账户信息  （账户中心页面 包含基本信息和已购服务信息）
        2.GET /accounts/balance/recharge  查询充值记录
        3.POST /accounts/balance/recharge 创建充值记录（点击充值，向微信支付宝发送支付请求）
        4.PUT  /accounts/balance/recharge/wechat_result_notify  (微信充值完成，微信的回调接口，充值记录状态更新、余额修改)

    #订单
        4.GET  /accounts/orders/:id? （获取订单列表或单个订单）
        5.POST /accounts/order (点击去支付操作调用的接口，会创建订单)
        6.PUT  /accounts/order/wechat_result_notify (微信支付完成调用接口，修改订单信息、余额、消费记录)

          POST /accounts/order (点击去支付操作调用的接口，会创建订单)
          PUT /accounts/order/balance_pay_notify (余额支付完成，回掉函数修改订单信息、余额、消费记录，添加已经购服务)
    #服务
        7.GET  /services/:id? (获取所有服务或单个服务)

    #已购服务
        8.GET  /accounts/services/current  获取账户已购服务
        9.POST                         使用内部方法代替提供给--接口6
        10.PUT 待定，提供用户操作对资源配额的使用情况的更新


