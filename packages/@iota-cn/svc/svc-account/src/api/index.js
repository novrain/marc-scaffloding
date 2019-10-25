import Account from './account';
import ServicePackage from './service_package';
import AccountServicePackage from './account_service_package';
import RechargeMw from './recharge';
import OrderMw from './order';
import Dashboard from './dashboard';
import { createMiddleware } from '@iota-cn/svc-util'

export default function (app, router, opts) {
    const Recharge = new RechargeMw(opts);
    const Order = new OrderMw(opts);
    const dashboard = new Dashboard();
    router.get('/accounts/finance', createMiddleware(Account.find));
    router.get('/accounts/recharges/:id?', createMiddleware(Recharge.find));
    router.post('/accounts/recharges', createMiddleware(Recharge.create));
    router.post(`/accounts/recharges/wechat_result_notify`, Recharge.onWXNotifyForRecharge);
    router.post(`/accounts/recharges/alipay_result_notify`, Recharge.onAliNotifyForRecharge)
    router.get('/accounts/orders/:id?', createMiddleware(Order.find));
    router.post('/accounts/orders', createMiddleware(Order.create));
    router.post(`/accounts/orders/wechat_result_notify`, Order.onWXNotifyForOrder);
    router.put('/accounts/orders/balance_pay_callback', Order.onBalancePayCallback);
    router.post('/accounts/orders/alipay_result_notify', Order.onAliNotifyForOrder);
    router.get('/accounts/services', createMiddleware(AccountServicePackage.find));
    router.get('/services/packages/:id?', ServicePackage.find);
    router.get('/dashboard/:id?', createMiddleware(dashboard.find));
    router.post('/dashboard', createMiddleware(dashboard.create));
    router.put('/dashboard/:id', createMiddleware(dashboard.update));
    router.delete('/dashboard/:id', createMiddleware(dashboard.delete));
    //alipay 下单和回调接口
    //router.post('/payments/alipay', Alipay.create);
    //router.post('/payments/alipay/result_notify', Alipay.payNotify);
}

let createHook = Account.createHook;
let changeBalance = Account.changeBalance;
let addAccountService = AccountServicePackage.create;
let createDefaultServiceHook = AccountServicePackage.createDefaultServiceHook;

export {
    createHook,
    changeBalance,
    addAccountService,
    createDefaultServiceHook
}