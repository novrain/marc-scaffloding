import SubUser from './sub_user';
import ResourceGroup from './resource_group';
import UserGroup from './user_group';
import Resource from './resource';
import Role from './role';
import Authorization from './authorization';
import { createMiddleware } from '@iota-cn/svc-util';


export default function (app, router, opts) {
    const restful = app.iota.restful;
    const models = app.iota.dc.models;

    router.get('/users/:parentId/subusers/:id?', SubUser.find);
    router.post('/users/:parentId/subusers', SubUser.createApi);
    router.put('/users/:parentId/subusers/:id', SubUser.updateApi);
    router.post('/users/:parentId/subusers/enable', SubUser.enable);
    router.post('/users/:parentId/subusers/disable', SubUser.disable);
    router.post('/users/:parentId/subusers/dependent', SubUser.makeDependent);
    router.post('/users/:parentId/subusers/independent', SubUser.makeIndependent);


    let resourceTypes = restful.resource({
        model: models.ResourceType,
        endpoints: ['/resource_types', '/resource_types/:id'],
        associations: true,
        actions: ['list', 'read'],
        search: {
            operator: '$eq',
            attributes: ['shareable']
        }
    });
    if (app && app.iota && app.iota.restful && typeof app.iota.restful.createNormalizerAfter === 'function') {
        resourceTypes.list.send.after(app.iota.restful.createNormalizerAfter("resourceTypes"));
    }

    //resource_group
    router.get('/resource_groups/:id?', createMiddleware(ResourceGroup.find));
    router.post('/resource_groups', createMiddleware(ResourceGroup.create));
    router.put('/resource_groups/:id', createMiddleware(ResourceGroup.update));
    router.delete('/resource_groups/:id?', createMiddleware(ResourceGroup._delete));

    router.get('/resource_groups/:resourceGroupId/resources/:id?', createMiddleware(Resource.findResourceInGroup));
    router.get('/resource_groups/:resourceGroupId/not_in_group/resources/:type', createMiddleware(Resource.findResourceNotInGroup));
    router.post('/resource_groups/:resourceGroupId/resources', createMiddleware(Resource.create));
    router.put('/resource_groups/:resourceGroupId/resources/:id', createMiddleware(Resource.update));
    router.delete('/resource_groups/:resourceGroupId/resources/:id?', createMiddleware(Resource._delete));


    //user_group
    router.get('/user_groups/:id?', createMiddleware(UserGroup.find));
    router.post('/user_groups', createMiddleware(UserGroup.createCreateApi(app, opts)));
    router.put('/user_groups/:id', createMiddleware(UserGroup.update));
    router.delete('/user_groups/:id?', createMiddleware(UserGroup._delete));

    router.get('/user_groups/:userGroupId/users/:id?', createMiddleware(UserGroup.findUserInGroup));
    router.post('/user_groups/:userGroupId/users', createMiddleware(UserGroup.createAddUserApi(app, opts)));
    router.get('/user_groups/:userGroupId/not_in_group/users', createMiddleware(UserGroup.findSubUserNotInGroup));
    router.post('/user_groups/:userGroupId/users/enable', createMiddleware(UserGroup.enable));
    router.post('/user_groups/:userGroupId/users/disable', createMiddleware(UserGroup.disable));
    router.get('/user_groups/:userGroupId/invite_users/accept', UserGroup.accept(opts));
    router.delete('/user_groups/:userGroupId/users/:id?', createMiddleware(UserGroup.removeUser));
    router.get('/user_groups/:userGroupId/emails/validate', createMiddleware(UserGroup.emailVerifyByGroup));
    router.get('/user_groups/emails/validate', createMiddleware(UserGroup.emailVerify));

    //role
    router.get('/roles/:id?', createMiddleware(Role.find));
    router.post('/roles', createMiddleware(Role.create));
    router.put('/roles/:id', createMiddleware(Role.updateBasic));
    router.put('/roles/:roleId/permissions', createMiddleware(Role.update));
    router.delete('/roles/:id?', createMiddleware(Role._delete));

    //authorization
    //@TODO 分别按用户组/角色/资源组查询
    router.get('/user_groups/:userGroupId/authorizations/:id?', createMiddleware(Authorization.findByUserGroup));
    //router.get('/resource_groups/:userGroupId/authorizations', createMiddleware(Authorization.findByUserGroup));
    //router.get('/roles/:userGroupId/authorizations', createMiddleware(Authorization.findByUserGroup));
    router.post('/authorizations/', createMiddleware(Authorization.create));
    router.delete('/authorizations/:id?', createMiddleware(Authorization._delete));
    router.get('/user_groups/:userGroupId/resource_groups/not_assigned', createMiddleware(ResourceGroup.findNotAssignToUserGroup));
}

let createHook = SubUser.createHook;
let updateHook = SubUser.updateHook;

export {
    createHook,
    updateHook
}
