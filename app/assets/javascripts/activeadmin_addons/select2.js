$(function() {
  configureSelect2(document);

  $(document).on('has_many_add:after', function(event, container) {
    configureSelect2(container);
  });

  function configureSelect2(container) {
    if (ActiveadminAddons.config.defaultSelect == 'select2') {
      $('select:not(.default-select)', container).each(function(i, el) {
        setupSelect2(el);
      });
    }

    $('select.select2', container).each(function(i, el) {
      setupSelect2(el);
    });

    function setupSelect2(select) {
      var firstOption = $('option', select).first();
      var allowClear = false;
      var placeholder = '';

      if (firstOption.val() === '' && firstOption.text() === '') {
        allowClear = true;
      }

      if ($(select).closest('.filter_form').length > 0) {
        $(select).select2({
          width: 'resolve',
          placeholder: placeholder,
          allowClear: allowClear,
        });
      } else {
        $(select).select2({
          width: '80%',
          placeholder: placeholder,
          allowClear: allowClear,
        });
      }
    }
  }
});
