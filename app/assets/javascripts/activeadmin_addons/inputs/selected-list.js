var initializer = function() {
  setupSelects(document);

  $(document).on('has_many_add:after', function(event, container) {
    setupSelects(container);
  });

  function removeSelectedItemOnClick(container) {
    container.click(function (event) {
      var item = $(event.target);
      if (item.hasClass('selected-item')) {
        item.remove();
      }
    });
  }

  function getDataOptions(inputElement) {
    var input = $(inputElement);
    return {
      url: input.data('url'),
      fields: input.data('fields'),
      predicate: input.data('predicate'),
      displayName: input.data('display-name'),
      method: input.data('method'),
      model: input.data('model'),
      prefix: input.data('model') + '_' + input.data('method'),
      responseRoot: input.data('response-root'),
      minimumInputLength: input.data('minimum-input-length'),
      order: input.data('order'),
    };
  }

  function getSelectOptions(inputElement) {
    var dataOptions = getDataOptions(inputElement);
    return {
      minimumInputLength: dataOptions.minimunInputLength,
      allowClear: true,
      ajax: {
        url: dataOptions.url,
        dataType: 'json',
        delay: 250,
        cache: true,
        data: function(params) {
          var textQuery = { m: 'or' };
          dataOptions.fields.forEach(function(field) {
            textQuery[field + '_' + dataOptions.predicate] = params.term;
          });

          var query = {
            order: dataOptions.order,
            q: {
              groupings: [textQuery],
              combinator: 'and',
            },
          };

          return query;
        },
        processResults: function(data) {
          if (data.constructor == Object) {
            data = data[responseRoot];
          }

          return {
            results: jQuery.map(data, function(resource) {
              return {
                id: resource.id,
                text: resource[dataOptions.displayName].toString(),
              };
            }),
          };
        },
      },
    };
  }

  function onItemSelected(event) {
    var dataOptions = getDataOptions(event.target);
    var data = event.params.data;
    var selectedItemsContainer = $("[id='" + dataOptions.prefix + "_selected_values']");
    var itemName = dataOptions.model + '[' + dataOptions.method + '][]';
    var itemId = dataOptions.prefix + '_' + data.id;

    if ($('#' + itemId).length > 0) {
      return;
    }

    var item = $('<div>' + data.text + '</div>').attr({
      class: 'selected-item',
      id: itemId,
    });

    var hiddenInput = $('<input>').attr({
      name: itemName,
      type: 'hidden',
      value: data.id,
    });

    item.appendTo(selectedItemsContainer);
    hiddenInput.appendTo(item);
  }

  function onSelectClosed(event) {
    $(event.target).val(null).trigger('change');
  }

  function setupSelects(container) {
    removeSelectedItemOnClick($('.selected-list-container'))

    $('.selected-list-input', container).each(function(i, el) {
      var selectOptions = getSelectOptions(el);

      $(el).on('select2:select', onItemSelected);
      $(el).on('select2:close', onSelectClosed);
      $(el).select2(selectOptions);
    });
  }
};

$(initializer);
$(document).on('turbolinks:load', initializer);
