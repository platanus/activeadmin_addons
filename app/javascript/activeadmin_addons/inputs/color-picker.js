var initializer = function() {
  setupColorPicker();

  $(document).on('has_many_add:after', setupColorPicker);

  function setupColorPicker() {
    $('.color-picker-input').each(function(i, el) {
      $(el).paletteColorPicker({
        'clear_btn': 'last',
      });
    });
  }
};

$(initializer);
$(document).on('turbolinks:load turbo:load', initializer);
