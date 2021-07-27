var initializer = function() {
  configureInteractiveSelect(document);

  $(document).on('has_many_add:after', function(event, container) {
    configureInteractiveSelect(container);
  });

  function configureInteractiveSelect(container) {
    $('.interactive-tag-select select', container).each(function(i, el) {
      setupSelect2(el);
    });

    function setupSelect2(select) {
      var selectConfig = {
        placeholder: '',
        allowClear: false,
        width: '125px',
      };

      $(select).select2(selectConfig);

      // Related with https://github.com/select2/select2/issues/3320
      $(select).on('select2:unselecting', function() {
        $(this).data('unselecting', true);
      }).on('select2:open', function() {
        if ($(this).data('unselecting')) {
          $(this).select2('close').removeData('unselecting');
        }
      });
    }
  }

  $('.interactive-tag').click(function(e) {
    var tag = $(e.target).parent();
    var model = tag.data('model');
    var objectId = tag.data('object_id');
    var field = tag.data('field');
    var selectTag = $('.' + model + '-' + field + '-' + objectId + '-select');
    selectTag.removeClass('select-container-hidden');
    tag.addClass('interactive-tag-hidden');
    selectTag.find('select').select2('open');
  });

  $('.interactive-tag-select').on('select2:close', function(e) {
    var selectTag = $(e.target).parent();

    var model = selectTag.data('model');
    var objectId = selectTag.data('object_id');
    var field = selectTag.data('field');

    var tagContainer = $('.' + model + '-' + field + '-' + objectId + '-tag');
    var statusTag = tagContainer.find('.status_tag');

    var newValue = e.target.value;
    var newText = e.target.selectedOptions[0].text;
    var oldValue = selectTag.data('value');

    if (newValue === oldValue) {
      selectTag.addClass('select-container-hidden');
      tagContainer.removeClass('interactive-tag-hidden');
    } else {
      var url = tagContainer.data('url');
      var data = { id: objectId };
      data[model] = {};
      data[model][field] = newValue;

      $.ajax({
        url: url,
        data: data,
        dataType: 'json',
        headers: { 'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content') },
        error: function() {
          var errorMsg = 'Error: Update Unsuccessful';
          console.log(errorMsg);
        },
        success: function() {
          statusTag.text(newText);
          statusTag.removeClass(oldValue);
          statusTag.addClass(newValue);

          tagContainer.data('value', newValue);
          selectTag.data('value', newValue);
        },
        complete: function() {
          selectTag.addClass('select-container-hidden');
          tagContainer.removeClass('interactive-tag-hidden');
        },
        type: 'PATCH',
      });
    }
  });
};

$(initializer);
$(document).on('turbolinks:load turbo:load', initializer);
