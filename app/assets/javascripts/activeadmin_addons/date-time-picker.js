//= require jquery.xdan.datetimepicker.full

$(function() {
  setupDateTimePicker(document);

  $(document).on('has_many_add:after', '.has_many_container', function(event, fieldset) {
    return setupDateTimePicker(fieldset);
  });

  function setupDateTimePicker(container) {
    var defaults, entries;
    defaults = {
      formatDate: 'y-m-d',
      format: 'Y-m-d H:i',
      allowBlank: true,
      defaultSelect: false,
      validateOnBlur: false
    };
    entries = $(container).find('input.date-time-picker');
    return entries.each(function(index, entry) {
      var options = $(entry).data('picker-options');
      return $(entry).datetimepicker($.extend(defaults, options));
    });
  }
});
