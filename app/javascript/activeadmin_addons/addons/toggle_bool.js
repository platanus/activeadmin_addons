var initializer = function() {
  $('.toggle-bool-switch').off('click.toggleBool').on('click.toggleBool', function(e) {
    var boolSwitch = $(e.target);

    var value = boolSwitch.data('value');
    var confirmMessage = boolSwitch.data('confirm_message');
    var confirmTrigger = boolSwitch.data('confirm_message_trigger') || 'both';
    
    if (confirmMessage) {
      var shouldConfirm = 
        (confirmTrigger === 'both') || 
        (confirmTrigger === 'on' && !value) || 
        (confirmTrigger === 'off' && value);
    
      if (shouldConfirm && !confirm(confirmMessage)) {
        return false;
      }
    }
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
