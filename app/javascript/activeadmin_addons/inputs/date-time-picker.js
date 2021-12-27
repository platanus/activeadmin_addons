var initializer = function() {
  setupDateTimePicker(document);

  $(document).on('has_many_add:after', '.has_many_container', function(event, fieldset) {
    return setupDateTimePicker(fieldset);
  });

  function setupDateTimePicker(container) {
    var defaults = {
      formatDate: 'y-m-d',
      format: 'Y-m-d H:i',
      allowBlank: true,
      defaultSelect: false,
      validateOnBlur: false,
      scrollInput: false,
    };

    var entries = $(container).find('input.date-time-picker-input');
    return entries.each(function(index, entry) {
      var options = $(entry).data('picker-options');
      var mixedOptions = $.extend(defaults, options);
      return $(entry).datetimepicker(mixedOptions);
    });
  }
};

$(initializer);
$(document).on('turbolinks:load turbo:load', initializer);
