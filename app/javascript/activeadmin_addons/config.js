var initializer = function() {
  ActiveadminAddons = {
    config: {
      defaultSelect: $('body').data('default-select'),
    },
  };
};

$(initializer);
$(document).on('turbolinks:load', initializer);
