'use strict';

var _ = require('lodash');

module.exports = function(Resource, resource, association) {
  // access points
  var subResourceName =
    association.target.options.name.plural.toLowerCase();

  // Find reverse association
  var associationPaired;
  if (association.paired) {
    associationPaired = _.find(association.target.associations, association.paired);
  } else {
    associationPaired = _.findWhere(association.target.associations, {
      paired: association
    });
  }

  if (!associationPaired) {
    // Do not create the resource
    return;
  }

  var associatedResource = new Resource({
    app: resource.app,
    sequelize: resource.sequelize,
    model: association.target,
    endpoints: [
      resource.endpoints.singular + '/' + subResourceName,
      resource.endpoints.plural + '/:' + associationPaired.foreignIdentifierField + '/' +
        subResourceName + '/:' + association.target.primaryKeyField
    ],
    actions: ['read', 'list']
  });

  associatedResource.associationOptions = resource.associationOptions;
  associatedResource.read.fetch.before(function(ctx, context) {
    var where = {};
    where[association.source.primaryKeyField] = ctx.params[associationPaired.foreignIdentifierField];
    delete ctx.params[associationPaired.foreignIdentifierField];

    context.include = context.include || [];
    context.include.push({
      association: associationPaired,
      where: where
    });
    context.continue();
  });

  associatedResource.read.send.before(function(ctx, context) {
    delete context.instance.dataValues[associationPaired.as];
    context.continue();
  });

  associatedResource.list.fetch.before(function(ctx, context) {
    // Filter
    var where = {};
    where[association.source.primaryKeyField] = ctx.params[association.target.primaryKeyField];

    context.include = context.include || [];
    context.include.push({
      association: associationPaired,
      where: where
    });

    context.continue();
  });

  associatedResource.list.send.before(function(ctx, context) {
    context.instance.forEach(function(instance) {
      if (instance.dataValues[associationPaired.as]) {
        instance.dataValues[associationPaired.as].forEach(function(a) {
          delete a.dataValues[associationPaired.combinedName];
        });
      }
    });

    context.continue();
  });

  return associatedResource;
};
