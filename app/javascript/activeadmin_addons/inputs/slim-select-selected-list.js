import { ransackSearch } from './slim-select-utils';

const classes = ['selected-list-input'];

// eslint-disable-next-line max-statements
function settings(el) {
  const url = el.dataset.url;
  const fields = JSON.parse(el.dataset.fields);
  const predicate = el.dataset.predicate;
  const displayName = el.dataset.displayName;
  const method = el.dataset.method;
  const model = el.dataset.model;
  const prefix = `${model}_${method}`;
  const responseRoot = el.dataset.responseRoot;
  const minimumInputLength = el.dataset.minimumInputLength;
  const order = el.dataset.order;

  const args = { url, fields, predicate, displayName, responseRoot, minimumInputLength, order };

  return {
    settings: {
      allowDeselect: false,
    },
    events: {
      // eslint-disable-next-line max-statements
      afterChange: (newVal) => {
        if (!newVal || newVal[0] && !newVal[0].value) return;

        const selectedItemsContainer = document.querySelector(`[id='${prefix}_selected_values']`);
        const itemName = `${model}[${method}][]`;

        // eslint-disable-next-line max-statements
        newVal.forEach((data) => {
          const itemId = `${prefix}_${data.value}`;
          if (!!document.querySelector(`#${itemId}`)) {
            return;
          }

          const item = document.createElement('div');
          item.id = itemId;
          item.textContent = data.text;
          item.classList.add('selected-item');

          const hiddenInput = document.createElement('input');
          hiddenInput.name = itemName;
          hiddenInput.type = 'hidden';
          hiddenInput.value = data.value;

          item.appendChild(hiddenInput);
          selectedItemsContainer.appendChild(item);
        });
        el.slim.setSelected();
      },
      search: (search, currentData) => {
        args.textQuery = { m: 'or' };
        args.fields.forEach((field) => {
          args.textQuery[`${field}_${predicate}`] = search;
        });

        return ransackSearch(search, currentData, args);
      },
    },
  };
}

function setupSelectedList(containerEl) {
  containerEl.addEventListener('click', (event) => {
    const item = event.target;
    if (item.classList.contains('selected-item')) {
      item.remove();
    }
  });
}

function setupSelectedLists(node) {
  node.querySelectorAll('.selected-list-container').forEach(setupSelectedList);
}

function mutationObserver() {
  return new MutationObserver((mutations) => {
    mutations.forEach((mutation) => {
      if (mutation.type === 'childList') {
        mutation.addedNodes.forEach((node) => {
          if (node instanceof Element) {
            setupSelectedLists(node);
          }
        });
      }
    });
  });
}

function init() {
  setupSelectedLists(document);
  mutationObserver();
}

export {
  settings,
  classes,
  init,
};

