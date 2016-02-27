//= require palette-color-picker
//= require_self

$(function() {

  setupColorPicker();

  $(document).on('has_many_add:after', setupColorPicker);

  function setupColorPicker() {
    $('.color-picker').each(function(i, el) {
      $(el).paletteColorPicker({
        clear_btn: 'last'
      });
    });
  }
});
