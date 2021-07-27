$.fn.select2.amd.define('select2/data/nestedCustomAdapter', ['select2/data/array', 'select2/utils'], function(ArrayData, Utils) {
  function CustomData($element, options) {
    CustomData.__super__.constructor.call(this, $element, options);
  }

  Utils.Extend(CustomData, ArrayData);

  CustomData.prototype.query = function(params, callback) {
    var data = { results: [] };
    var element = this.$element;
    var collection = element.data('collection');
    var parent = element.data('parent');
    var parentId = element.data('parent-id');

    collection.forEach(function(record) {
      var regex = new RegExp(params.term, 'i');
      var matched = !!record.text.match(regex);

      if ((!parent || record[parent] == parentId) && matched) {
        data.results.push(record);
      }
    });

    callback(data);
  };

  CustomData.prototype.current = function(callback) {
    var currentOption = null;
    var element = this.$element;
    var selectedOption = element.data('selected');
    var collection = element.data('collection');
    var data = [];

    $.each(collection, function(index, option) {
      if (!!selectedOption && option.id == selectedOption.id) {
        currentOption = option;
        element.data('selected', null);
        return;
      }

      if (element.val() == option.id) {
        currentOption = option;
        return;
      }
    });

    if (currentOption) {
      data.push(currentOption);
    }

    callback(data);
  };

  return CustomData;
});

var initializer = function() {
  configureSelect2(document);

  $(document).on('has_many_add:after', function(event, container) {
    configureSelect2(container);
  });

  function configureSelect2(container) {
    var INVALID_PARENT_ID = -1;

    $('.nested-level-input', container).each(function(i, el) {
      var element = $(el);
      var url = element.data('url');
      var fields = element.data('fields');
      var predicate = element.data('predicate');
      var filters = element.data('filters');
      var displayName = element.data('display-name');
      var parent = element.data('parent');
      var width = element.data('width');
      var model = element.data('model');
      var responseRoot = element.data('response-root');
      var collection = element.data('collection');
      var minimumInputLength = element.data('minimum-input-length');
      var order = element.data('order');
      var parentId = element.data('parent-id');
      var selectInstance;

      var select2Config = {
        width: width,
        minimumInputLength: minimumInputLength,
        placeholder: '',
        allowClear: true,
      };

      if (collection) {
        select2Config.dataAdapter = $.fn.select2.amd.require('select2/data/nestedCustomAdapter');
      } else {
        var ajaxConfig = {
          url: url,
          dataType: 'json',
          delay: 250,
          cache: true,
          data: function(params) {
            var textQuery = { m: 'or' };
            fields.forEach(function(field) {
              if (field == 'id') {
                textQuery[field + '_eq'] = params.term;
              } else {
                textQuery[field + '_' + predicate] = params.term;
              }
            });

            var query = {
              order: order,
              q: {
                groupings: [textQuery],
                combinator: 'and',
              },
            };

            if (!!parent) {
              query.q[parent + '_eq'] = parentId;
            }

            Object.assign(query.q, filters);

            return query;
          },
          processResults: function(data) {
            if (data.constructor == Object) {
              data = data[responseRoot];
            }

            return {
              results: jQuery.map(data, function(resource) {
                if (!resource[displayName]) {
                  resource[displayName] = 'No display name for id #' + resource.id.toString();
                }
                return {
                  id: resource.id,
                  text: resource[displayName].toString(),
                };
              }),
            };
          },
        };

        select2Config.ajax = ajaxConfig;
      }

      selectInstance = element.select2(select2Config);

      function setParentValue(e) {
        selectInstance.val(null).trigger('select2:select').trigger('change');
        parentId = (e.params && e.params.data.id) ? e.params.data.id : INVALID_PARENT_ID;
        element.data('parent-id', parentId);
      }

      if (!!parent) {
        var parentSelectorId = '#' + model + '_' + parent;
        if (!$(parentSelectorId).length) {
          parentSelectorId = $(container).find('*[id*=' + parent + ']')[0];
        }
        var parentSelector = $(parentSelectorId)[0];

        $(parentSelector).on('select2:select', setParentValue);
        $(parentSelector).on('select2:unselect', setParentValue);
      }
    });
  }
};

$(initializer);
$(document).on('turbolinks:load turbo:load', initializer);
