//= require select2
//= require_self

$(function() {
  setupSelectedList(document);

  $(document).on('has_many_add:after', function(event, container){
    setupSelectedList(container);
  });

  function setupSelectedList(container) {
    $('.selected-list-container').click(function(event) {
      var item = $(event.target);
      if (item.hasClass('selected-item')) {
        item.remove();
      }
    });

    $('.selected-list', container).each(function(i, el) {
      var url = $(el).data('url'),
          fields = $(el).data('fields'),
          displayName = $(el).data('display_name'),
          width = $(el).data('width') || '100%',
          method = $(el).data('method'),
          model = $(el).data('model'),
          prefix = model + '_' + method,
          responseRoot = $(el).data('response_root'),
          minimumInputLength = $(el).data('minimum_input_length'),
          order = $(el).data('order') || (fields[0] + '_desc');


      var selectOptions = {
        width: width,
        minimumInputLength: minimumInputLength,
        allowClear: true,
        multiple: true,
        createSearchChoice: function() { return null; },
        ajax: {
          url: url,
          dataType: 'json',
          delay: 250,
          cache: true,
          data: function(term) {
            var textQuery = { m: 'or' };
            fields.forEach(function(field) {
              textQuery[field + '_contains'] = term;
            });

            var query =  {
              order: order,
              q: {
                groupings: [textQuery],
                combinator: 'and'
              }
            };

            return query;
          },
          results: function(data, page) {
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
        },
      };

      function onItemSelected(event) {
        var selectedItemsContainer = $("[id='" + prefix + "_selected_values']"),
          itemName = model + '[' + method + '][]',
          itemId = prefix + '_' + event.val;

        if ($("#" + itemId).length > 0) {
          return;
        }

        var item = $('<div>' + event.object.text + '</div>').attr({
          class: 'selected-item',
          id: itemId,
        });

        var hidden_input = $('<input>').attr({
          name: itemName,
          type: 'hidden',
          value: event.val
        });

        item.appendTo(selectedItemsContainer);
        hidden_input.appendTo(item);
      }

      function onSelectClosed() {
        $(el).select2('val', '');
      }

      $(el).on('select2-selecting', onItemSelected);
      $(el).on('select2-close', onSelectClosed);

      $(el).select2(selectOptions);
    });
  }
});
