import { createMiddleware } from '@iota-cn/svc-util'

import * as Menu from './menu'
import * as Operation from './operation'
import * as Organization from './organization'
import * as Position from './position'
import * as Role from './role'
import * as User from './user'

/**
 * 
 * @param {*} app 
 * @param {*} router 
 * @param {*} opts 
 */
export default function (app, router, opts) {
    //Menus
    router.get('/authorizations/menus', createMiddleware(Menu.findMenuOfCurrentUser));

    //Operations
    router.get('/authorizations/operations', createMiddleware(Operation.findOperationOfCurrentUser));

    //Organizations
    router.get('/authorizations/organizations', createMiddleware(Organization.findOrg));
    router.get('/authorizations/assigned_organizations', createMiddleware(Organization.findOrganizationsAssignToSelf));
    router.post('/authorizations/organizations', createMiddleware(Organization.createOrg));
    router.put('/authorizations/organizations/:id', createMiddleware(Organization.updateOrg));
    router.delete('/authorizations/organizations/:id?', createMiddleware(Organization.deleteOrg));

    router.get('/authorizations/organizations/:organizationId/roles', createMiddleware(Organization.findRoleAssignToOrg));
    router.get('/authorizations/organizations/:organizationId/not_assigned/roles', createMiddleware(Organization.findRoleNotAssignToOrg));
    router.post('/authorizations/organizations/:organizationId/roles', createMiddleware(Organization.assignRoleToOrg));
    router.delete('/authorizations/organizations/:organizationId/roles/:id?', createMiddleware(Organization.removeRoleFromOrg)); // record id or roleId?

    router.get('/authorizations/organizations/:organizationId/users', createMiddleware(Organization.findUserInOrg));
    router.get('/authorizations/organizations/:organizationId/not_in/users', createMiddleware(Organization.findUserNotInOrg));
    router.post('/authorizations/organizations/:organizationId/users', createMiddleware(Organization.addUserToOrg));
    router.delete('/authorizations/organizations/:organizationId/users/:id?', createMiddleware(Organization.removeUseFromOrg));

    //Positions    
    router.get('/authorizations/positions', createMiddleware(Position.findPosition));
    router.get('/authorizations/assigned_positions', createMiddleware(Position.findPositionsAssignToSelf));
    router.post('/authorizations/positions', createMiddleware(Position.createPosition));
    router.put('/authorizations/positions/:id', createMiddleware(Position.updatePosition));
    router.delete('/authorizations/positions/:id?', createMiddleware(Position.deletePosition));

    router.get('/authorizations/positions/:positionId/roles', createMiddleware(Position.findRoleAssignToPosition));
    router.get('/authorizations/positions/:positionId/not_assigned/roles', createMiddleware(Position.findRoleNotAssignToPosition));
    router.post('/authorizations/positions/:positionId/roles', createMiddleware(Position.assignRoleToPosition));
    router.delete('/authorizations/positions/:positionId/roles/:id?', createMiddleware(Position.removeRoleFromPosition));

    router.get('/authorizations/positions/:positionId/users', createMiddleware(Position.findUserInPosition));
    router.get('/authorizations/positions/:positionId/not_in/users', createMiddleware(Position.findUserNotInPosition));
    router.post('/authorizations/positions/:positionId/users', createMiddleware(Position.addUserToPosition));
    router.delete('/authorizations/positions/:positionId/users/:id?', createMiddleware(Position.removeUseFromPosition));

    //Roles
    router.get('/authorizations/roles', createMiddleware(Role.findRole));
    router.get('/authorizations/assigned_roles', createMiddleware(Role.findRolesAssignToSelf));
    router.post('/authorizations/roles', createMiddleware(Role.createRole));
    router.put('/authorizations/roles/:id', createMiddleware(Role.updateRole));
    router.delete('/authorizations/roles/:id?', createMiddleware(Role.deleteRole));

    router.get('/authorizations/roles/:roleId/menus', createMiddleware(Role.findMenuOfRole));
    router.post('/authorizations/roles/:roleId/menus', createMiddleware(Role.assignMenuToRole));
    router.delete('/authorizations/roles/:roleId/menus/:id?', createMiddleware(Role.removeMenuFromRole));
    router.get('/authorizations/roles/:roleId/operations', createMiddleware(Role.findOperationOfRole));
    router.post('/authorizations/roles/:roleId/operations', createMiddleware(Role.assignOperationToRole));
    router.delete('/authorizations/roles/:roleId/operations/:id?', createMiddleware(Role.removeOperationFromRole));
    router.get('/authorizations/roles/:roleId/organizations', createMiddleware(Role.findOrgBindToRole));
    router.get('/authorizations/roles/:roleId/not_bind/organizations', createMiddleware(Role.findOrgNotBindToRole));
    //@see Organization.assignRoleToOrg
    router.post('/authorizations/roles/:roleId/organizations', createMiddleware(Role.bindRoleToOrg));
    //@see Organization.removeRoleFromeOrg
    router.delete('/authorizations/roles/:roleId/organizations/:id?', createMiddleware(Role.unbindRoleAndOrg));

    router.get('/authorizations/roles/:roleId/positions', createMiddleware(Role.findPositionBindToRole));
    router.get('/authorizations/roles/:roleId/not_bind/positions', createMiddleware(Role.findPositionNotBindToRole));
    //@see Position.asignRoleToPosition
    router.post('/authorizations/roles/:roleId/positions', createMiddleware(Role.bindRoleToPosition));
    //@see Position.removeRoleFromePosition
    router.delete('/authorizations/roles/:roleId/positions/:id?', createMiddleware(Role.unbindRoleAndPosition));

    router.get('/authorizations/roles/:roleId/users', createMiddleware(Role.findUserBindToRole));
    router.get('/authorizations/roles/:roleId/not_bind/users', createMiddleware(Role.findUserNotBindToRole));
    router.post('/authorizations/roles/:roleId/users', createMiddleware(Role.bindRoleToUser));
    router.delete('/authorizations/roles/:roleId/users/:id?', createMiddleware(Role.unbindRoleAndUser));

    //Users
    router.get('/authorizations/users/:id?', createMiddleware(User.findUser));
    router.post('/authorizations/users', createMiddleware(User.createUser));
    router.put('/authorizations/users/:id', createMiddleware(User.updateUser));
    router.delete('/authorizations/users/:id', createMiddleware(User.deleteUser));
    router.post('/authorizations/users/enable/:id?', createMiddleware(User.enable));
    router.post('/authorizations/users/disable/:id?', createMiddleware(User.disable));
    //Extention
    router.get('/authorizations/users/:id/extention', createMiddleware(User.findUserExtention));
    router.put('/authorizations/users/:id/extention', createMiddleware(User.updateUserExtention));


    router.get('/authorizations/users/:userId/roles', createMiddleware(User.findRoleAssignToUser))
    router.get('/authorizations/users/:userId/not_assigned/roles', createMiddleware(User.findRoleNotAssignToUser))
    //@see Role.bindRoleToUser
    router.post('/authorizations/users/:userId/roles', createMiddleware(User.bindRoleToUser))
    //@see Role.unbindRoleAndUser
    router.delete('/authorizations/users/:userId/roles/:id?', createMiddleware(User.unbindRoleAndUser))

    router.get('/authorizations/users/:userId/organizations', createMiddleware(User.findOrgAssignToUser))
    router.get('/authorizations/users/:userId/not_assigned/organizations', createMiddleware(User.findOrgNotAssignToUser))
    router.post('/authorizations/users/:userId/organizations', createMiddleware(User.bindUserToOrg))
    router.delete('/authorizations/users/:userId/organizations/:id?', createMiddleware(User.unbindUserAndOrg))

    router.get('/authorizations/users/:userId/positions', createMiddleware(User.findPositionAssignToUser))
    router.get('/authorizations/users/:userId/not_assigned/positions', createMiddleware(User.findPositionNotAssignToUser))
    router.post('/authorizations/users/:userId/positions', createMiddleware(User.bindUserToPosition))
    router.delete('/authorizations/users/:userId/positions/:id?', createMiddleware(User.unbindUserAndPosition))

    router.get('/authorizations/users/:userId/menus', createMiddleware(User.findMenuOfUser))
    router.get('/authorizations/users/:userId/operations', createMiddleware(User.findOperationOfUser))
}