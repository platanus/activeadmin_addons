var initializer = function() {
  $('.toggle-bool-switch').click(function(e) {
    var boolSwitch = $(e.target);

    var objectId = boolSwitch.data('object_id');
    var model = boolSwitch.data('model');
    var field = boolSwitch.data('field');

    var url = boolSwitch.data('url');
    var value = boolSwitch.data('value');
    var successMessage = boolSwitch.data('success_message');
    var data = { id: objectId };
    data[model] = {};
    data[model][field] = !value;

    $.ajax({
      url: url,
      data: data,
      dataType: 'json',
      headers : {'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')},
      error: function() {
        var errorMsg = 'Error: Update Unsuccessful';
        alert(errorMsg);
      },
      success: function() {
        boolSwitch.data('value', !value);
        boolSwitch.toggleClass('on');
        if (!boolSwitch.hasClass('notify-success')) return;
        $(function() {
          setTimeout(alert(successMessage), 500);
        });
      },
      type: 'PATCH',
    });
  });
};

$(initializer);
$(document).on('turbolinks:load turbo:load', initializer);
