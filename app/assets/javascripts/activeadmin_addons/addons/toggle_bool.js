$(function() {
  $('.toggle-bool-switch').click(function(e) {
    var boolSwitch = $(e.target);
    var model = boolSwitch.data('model');
    var objectId = boolSwitch.data('object_id');
    var field = boolSwitch.data('field');
    var value = boolSwitch.data('value');
    var otherValue = String(value) !== 'true';
    var switchId = boolSwitch.attr('id');
    var otherSwitch = $('#' + switchId.substr(0, switchId.lastIndexOf('-') + 1) + otherValue);
    var url = boolSwitch.data('url');
    var successMessage = boolSwitch.data('success_message');
    var data = { id: objectId };
    data[model] = {};
    data[model][field] = otherValue;
    $.ajax({
      url: url,
      data: data,
      dataType: 'json',
      error: function() {
        var errorMsg = 'Error: Update Unsuccessful';
        alert(errorMsg);
      },
      success: function() {
        boolSwitch.addClass('hidden-switch');
        otherSwitch.removeClass('hidden-switch');
        if (!boolSwitch.hasClass('notify-success')) return;
        $(function() {
          var successMsg = 'Update Successful!';
          setTimeout(alert(successMessage), 500);
        });
      },
      type: 'PATCH',
    });
  });
});
