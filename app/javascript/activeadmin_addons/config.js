const loadEvents = ['turbo:load', 'turbolinks:load', 'DOMContentLoaded'];

function initializer() {
  window.ActiveadminAddons = {
    config: {
      defaultSelect: document.querySelector('body').dataset.defaultSelect,
    },
  };
}

loadEvents.forEach((event) => {
  document.addEventListener(event, initializer);
});
