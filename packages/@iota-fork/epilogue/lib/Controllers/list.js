'use strict';

var util = require('util'),
    Base = require('./base'),
    _ = require('lodash'),
    errors = require('../Errors');

var List = function (args) {
    List.super_.call(this, args);
};

util.inherits(List, Base);

List.prototype.action = 'list';
List.prototype.method = 'get';
List.prototype.plurality = 'plural';

List.prototype._safeishParse = function (value, type, sequelize) {
    if (sequelize) {
        if (type instanceof sequelize.STRING || type instanceof sequelize.CHAR || type instanceof sequelize.TEXT) {
            if (!isNaN(value)) {
                return value;
            }
        } else if (type instanceof sequelize.INTEGER || type instanceof sequelize.BIGINT) {
        }
    }
    try {
        return JSON.parse(value);
    } catch (err) {
        return value;
    }
};

var stringOperators = /like|iLike|notLike|notILike/;
List.prototype.fetch = function (ctx, context) {
    var self = this,
        model = this.model,
        options = context.options || {},
        criteria = context.criteria || {},
        include = this.include,
        includeAttributes = this.includeAttributes,
        Sequelize = this.resource.sequelize,
        defaultCount = 100,
        count = +context.count || +ctx.query.limit || defaultCount,
        offset = +context.offset || +ctx.query.offset || 0;
    // offset = 0;

    // only look up attributes we care about
    options.attributes = options.attributes || this.resource.attributes;

    // account for offset and count
    // offset += context.page * count || ctx.query.page * count || 0;
    if (count > 1000) count = 1000;
    if (count < 0) count = defaultCount;

    options.offset = offset;
    options.limit = count;
    if (!this.resource.pagination)
        delete options.limit;

    if (context.include && context.include.length) {
        include = include.concat(context.include);
    }
    if (include.length) {
        options.include = include;
    }

    var searchParams = this.resource.search.length ? this.resource.search : [this.resource.search];
    searchParams.forEach(function (searchData) {
        var searchParam = searchData.param;
        if (_.has(ctx.query, searchParam)) {
            var search = [];
            var searchOperator = searchData.operator || '$like';
            var searchAttributes =
                searchData.attributes || Object.keys(model.rawAttributes);
            searchAttributes.forEach(function (attr) {
                if (stringOperators.test(searchOperator)) {
                    var attrType = model.rawAttributes[attr].type;
                    if (!(attrType instanceof Sequelize.STRING) &&
                        !(attrType instanceof Sequelize.TEXT)) {
                        // NOTE: Sequelize has added basic validation on types, so we can't get
                        //       away with blind comparisons anymore. The feature is up for
                        //       debate so this may be changed in the future
                        return;
                    }
                }

                var item = {};
                var query = {};
                var searchString;
                if (!~searchOperator.toLowerCase().indexOf('like')) {
                    searchString = ctx.query[searchParam];
                } else {
                    searchString = '%' + ctx.query[searchParam] + '%';
                }
                query[searchOperator] = searchString;
                item[attr] = query;
                search.push(item);
            });

            if (Object.keys(criteria).length || Object.getOwnPropertySymbols(criteria).length)
                criteria = Sequelize.and(criteria, Sequelize.or.apply(null, search));
            else
                criteria = Sequelize.or.apply(null, search);
        }
    });

    var sortParam = this.resource.sort.param;
    if (_.has(ctx.query, sortParam) || _.has(this.resource.sort, 'default')) {
        var order = [];
        var columnNames = [];
        var sortQuery = ctx.query[sortParam] || this.resource.sort.default || '';
        var sortColumns = sortQuery.split(',');
        sortColumns.forEach(function (sortColumn) {
            if (sortColumn.indexOf('-') === 0) {
                var actualName = sortColumn.substring(1);
                order.push([actualName, 'DESC']);
                columnNames.push(actualName);
            } else {
                columnNames.push(sortColumn);
                order.push([sortColumn, 'ASC']);
            }
        });
        var allowedColumns = this.resource.sort.attributes || Object.keys(model.rawAttributes);
        var disallowedColumns = _.difference(columnNames, allowedColumns);
        if (disallowedColumns.length) {
            throw new errors.BadRequestError('Sorting not allowed on given attributes', disallowedColumns);
        }

        if (order.length)
            options.order = order;
    }

    if (!this.resource.disableDefaultQueryParams) {
        // all other query parameters are passed to search
        var extraSearchCriteria = _.reduce(ctx.query, function (result, value, key) {
            if (_.has(model.rawAttributes, key)) result[key] = self._safeishParse(value, model.rawAttributes[key].type, Sequelize);
            return result;
        }, {});

        if (Object.keys(extraSearchCriteria).length)
            criteria = _.assign(criteria, extraSearchCriteria);
    }

    // do the actual lookup
    if (Object.keys(criteria).length || Object.getOwnPropertySymbols(criteria).length)
        options.where = criteria;
    if (ctx.query.scope) {
        model = model.scope(ctx.query.scope);
    }

    return model
        .findAndCountAll(options)
        .then(function (result) {
            context.instance = result.rows;
            var start = offset;
            var end = start + result.rows.length - 1;
            end = end === -1 ? 0 : end;

            if (self.resource.associationOptions.removeForeignKeys) {
                _.each(context.instance, function (instance) {
                    _.each(includeAttributes, function (attr) {
                        delete instance[attr];
                        delete instance.dataValues[attr];
                    });
                });
            }

            if (!!self.resource.pagination) {
                // ctx.header['Content-Range'] = 'items ' + [[start, end].join('-'), result.count].join('/');
                context.instance = {
                    data: context.instance,
                    count: result.count
                }
            }

            return context.continue;
        });
};

module.exports = List;
