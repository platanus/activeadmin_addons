var initializer = function() {
  setupTags(document);

  $(document).on('has_many_add:after', function(event, container) {
    setupTags(container);
  });

  function setupTags(container) {
    $('.tags-input', container).each(function(i, el) {
      var model = $(el).data('model');
      var method = $(el).data('method');
      var original_name = $(el).attr('name');
      var prefix = model + '_' + method;
      var isRelation = !!$(el).data('relation');
      var collection = $(el).data('collection');
      var width = $(el).data('width');
      var selectOptions = {
        width: width,
        multiple: true,
        tags: true,
        data: collection,
      };

      if (!!isRelation) {
        selectOptions.createTag = function() {
          return undefined;
        };
      }

      $(el).on('select2:select', onItemAdded);
      $(el).on('select2:unselect', onItemRemoved);
      $(el).select2(selectOptions);

      function getSelectedItems() {
        var choices = $(el).parent('li.input').find('.select2-selection__choice');
        return $.map(choices, function(item) {
          return $(item).attr('title');
        });
      }

      function fillHiddenInput() {
          var id_target = original_name.replace("[","_").replace("]","").replace("virtual_","").replace("_attr]","]");
          console.log(id_target);
          var hiddenInput = $("input#" + id_target);
        hiddenInput.val(getSelectedItems().join());
      }

      function onItemRemoved(event) {
        if (isRelation) {
          var itemId = '[id=\'' + prefix + '_' + event.params.data.id + '\']';
          $(itemId).remove();
        } else {
          fillHiddenInput();
        }
      }

      function onItemAdded(event) {
        if (isRelation) {
          var value = event.params.data.id;
          var selectedItemsContainer = $("[id='" + prefix + "_selected_values']");
          // take 
          var itemName = original_name.replace("virtual_","").replace("_attr","");
          var itemId = prefix + '_' + value;
            console.log(itemId);
            console.log(itemName);
          $('<input>').attr({
            id: itemId,
            name: itemName,
            type: 'hidden',
            value: value,
          }).appendTo(selectedItemsContainer);
        } else {
          fillHiddenInput();
        }
      }
    });
  }
};

$(initializer);
$(document).on('turbolinks:load', initializer);
