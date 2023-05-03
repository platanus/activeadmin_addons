import { ransackSearch } from './slim-select-utils';

const classes = ['nested-level-input'];

function ajaxSearch(search, currentData, args) {
  args.fields.forEach((field) => {
    if (field === 'id') {
      args.textQuery[`${field}_eq`] = search;
    } else {
      args.textQuery[`${field}_${args.predicate}`] = search;
    }
  });

  if (!!args.parent) {
    args.query.q[`${args.parent}_id_eq`] = args.parentId;
  }

  args.query.q = { ...args.query.q, ...args.filters };

  return ransackSearch(search, currentData, args);
}

function collectionSearch(search, args, collection) {
  if (search.length < args.minimumInputLength) {
    return Promise.reject('Search term too short');
  }

  const data = JSON.parse(collection).filter(
    (item) => (!args.parent || item[args.parent] === Number(args.parentId)) &&
      String(item.text).toLowerCase().includes(search.toLowerCase()),
  ).map(
    (item) => ({ value: String(item.id), text: item.text }),
  );

  return Promise.resolve(data);
}

function settings(el) {
  return {
    settings: {
      allowDeselect: true,
    },
    events: {
      beforeOpen: () => {
        if (Number(el.dataset.minimumInputLength) === 0) {
          el.slim.search('');
        }
      },
      afterChange: () => {
        const { model, association } = el.dataset;
        const child = el.closest('.nested_level')
          .parentNode
          .querySelector(`.nested_level [data-model=${model}][data-parent=${association}]`);

        if (child) {
          child.slim.setSelected();
          child.slim.setData([]);
          if (child.slim.events.afterChange) {
            child.slim.events.afterChange();
          }
          child.dispatchEvent(new Event('change'));
          child.dataset.parentId = el.value;
        }
      },
      search(search, currentData) {
        const args = {
          url: el.dataset.url,
          fields: el.dataset.fields && JSON.parse(el.dataset.fields) || {},
          predicate: el.dataset.predicate,
          filters: el.dataset.filters && JSON.parse(el.dataset.filters) || {},
          displayName: el.dataset.displayName,
          parent: el.dataset.parent,
          parentId: el.dataset.parentId,
          responseRoot: el.dataset.responseRoot,
          minimumInputLength: el.dataset.minimumInputLength,
          order: el.dataset.order,
          textQuery: { m: 'or' },
          query: { q: {} },
        };

        if (el.dataset.collection) {
          return collectionSearch(search, args, el.dataset.collection);
        }

        return ajaxSearch(search, currentData, args);
      },
    },
  };
}

export {
  settings,
  classes,
};

