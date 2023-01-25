import SlimSelect from 'slim-select';
import merge from 'lodash.merge';

const SELECT_CLASS = 'select:not(.default-select)';
const SLIM_SELECT_CLASS = 'select.slim-select';

const selectTypes = {};

// eslint-disable-next-line max-statements
function setupSelect(el) {
  const emptyOption = el.querySelector('option[value=""]');
  if (emptyOption) emptyOption.dataset.placeholder = true;

  el.style.width = el.dataset.width || '80%';
  let settings = {
    select: el,
    settings: {
      placeholderText: 'Select Value',
    },
  };

  Object.keys(selectTypes).forEach((type) => {
    if (selectTypes[type].classes.some((className) => el.classList.contains(className))) {
      settings = merge({}, settings, selectTypes[type].settings(el));
      if (selectTypes[type].init) {
        selectTypes[type].init(el);
      }
    }
  });

  const slim = new SlimSelect(settings);
  el.dataset.slimSelectId = slim.settings.id;
}

function initSelects(node = document) {
  if (document.querySelector('body').dataset.defaultSelect === 'slim-select') {
    node.querySelectorAll(SELECT_CLASS).forEach(setupSelect);
  }

  node.querySelectorAll(SLIM_SELECT_CLASS).forEach(setupSelect);
}

// mutation observer to add slim select to new elements
const observer = new MutationObserver((mutations) => {
  mutations.forEach((mutation) => {
    if (mutation.type === 'childList') {
      mutation.addedNodes.forEach((node) => {
        if (node instanceof Element) {
          initSelects(node);
        }
      });
    }
  });
});

window.addEventListener('load', () => {
  initSelects();
  observer.observe(document.querySelector('body'), { attributes: false, childList: true, subtree: true });
});
