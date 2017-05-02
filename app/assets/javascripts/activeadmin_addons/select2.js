//= require select2-full
//= require_self

$(function() {
  configureSelect2(document);

  $(document).on('has_many_add:after', function(event, container){
    configureSelect2(container);
  });

  function configureSelect2(container) {
    var INVALID_PARENT_ID = -1;
    var DEFAULT_SELECT_WIDTH = '80%';

    setupDefaultBehaviour();
    setupAjaxSearch();
    setupTags();

    function setupTags() {
      $('.select2-tags', container).each(function(i, el) {
        var model = $(el).data('model'),
            method = $(el).data('method'),
            width = $(el).data('width'),
            selectOptions = {
              width: width || DEFAULT_SELECT_WIDTH,
              tags: true,
              multiple: true,
              data: $(el).data('collection')
            };

        if(!!model) {
          selectOptions.createSearchChoice = function() { return null; };
          var prefix = model + '_' + method;
          $(el).on('select2-selecting', onItemAdded);
          $(el).on('select2-removed', onItemRemoved);
        }

        $(el).select2(selectOptions);

        function onItemRemoved(event) {
          var itemId = '[id=\'' + prefix +  '_' + event.val + '\']';
          $(itemId).remove();
        }

        function onItemAdded(event) {
          var selectedItemsContainer = $("[id='" + prefix + "_selected_values']"),
            itemName = model + '[' + method + '][]',
            itemId = prefix + '_' + event.val;

          $('<input>').attr({
            id: itemId,
            name: itemName,
            type: 'hidden',
            value: event.val
          }).appendTo(selectedItemsContainer);
        }
      });
    }

    function setupAjaxSearch() {
      $('.select2-ajax', container).each(function(i, el) {
        var url = $(el).data('url');
        var fields = $(el).data('fields');
        var displayName = $(el).data('display_name');
        var parent = $(el).data('parent');
        var width = $(el).data('width') || DEFAULT_SELECT_WIDTH;
        var model = $(el).data('model');
        var responseRoot = $(el).data('response_root');
        var collection = $(el).data('collection');
        var minimumInputLength = $(el).data('minimum_input_length');
        var order = $(el).data('order') || (fields[0] + '_desc');
        var parentId = $(el).data('parent_id') || INVALID_PARENT_ID;
        var perPage = $(el).data('per_page');
        var multiple = $(el).data('multiple');
        var selectInstance;

        var ajaxOptions = {
          url: url,
          dataType: 'json',
          delay: 250,
          data: function(params) {
            var textQuery = { m: 'or' };
            fields.forEach(function(field) {
              if (field == "id") {
                textQuery[field + '_eq'] = params.term;
              } else {
                textQuery[field + '_contains'] = params.term;
              }
            });

            var query =  {
              order: order,
              q: {
                groupings: [textQuery],
                combinator: 'and'
              }
            };

            if (!!parent) {
              query.q[parent + '_eq'] = parentId;
            }

            if (perPage) {
              query.per_page = perPage;
            }

            return query;
          },
          processResults: function(data) {
            if(data.constructor == Object) {
              data = data[responseRoot];
            }

            return {
              results: jQuery.map(data, function(resource) {
                return {
                  id: resource.id,
                  text: resource[displayName].toString()
                };
              })
            };
          },
          cache: true
        };

        var collectionOptions = function(query) {
          var data = { results: [] };

          collection.forEach(function(record) {
            var matched = fields.some(function(field) {
              var regex = new RegExp(query.term, 'i');
              return !!record[field] && !!record[field].match(regex);
            });

            if((!parent || record[parent] == parentId) && matched) {
              data.results.push({ id: record.id, text: record[displayName].toString() });
            }
          });

          query.callback(data);
        };

        if (!!parent) {
          var parentSelector = '#' + model + '_' + parent;

          $(el).parent().find(parentSelector).on('change', function(e) {
            selectInstance.val(null).trigger('change');
            parentId = e.val;

            if(!parentId) {
              parentId = INVALID_PARENT_ID;
            }
          });
        }

        var select2Config = {
          width: width,
          containerCssClass: 'nested-select-container',
          minimumInputLength: minimumInputLength,
          placeholder: ' ',
          allowClear: true,
        };

        if (multiple) {
          select2Config.multiple = true;
        }

        if (collection) {
          select2Config.query = collectionOptions;
        } else {
          select2Config.ajax = ajaxOptions;
        }

        selectInstance = $(el).select2(select2Config);
      });
    }

    function setupSelect2(select) {
      var firstOption = $('option', select).first(),
          allowClear  = false;

      if (firstOption.val() === "" && firstOption.text() === "") {
        allowClear = true;
      }

      if ($(select).closest('.filter_form').length > 0) {
        $(select).select2({
          width: 'resolve',
          allowClear: allowClear,
          placeholder: ' ',
        });
      } else {
        $(select).select2({
          width: DEFAULT_SELECT_WIDTH,
          allowClear: allowClear,
          placeholder: ' ',
        });
      }
    }

    function setupDefaultBehaviour() {
      if(ActiveadminAddons.config.defaultSelect == 'select2') {
        $('select:not(.default-select)', container).each(function(i, el) {
          setupSelect2(el);
        });
      }

      $('select.select2', container).each(function(i, el) {
        setupSelect2(el);
      });
    }
  }
});
