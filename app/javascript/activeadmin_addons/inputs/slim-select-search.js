import { ransackSearch } from './slim-select-utils';

const classes = ['search-select-input', 'search-select-filter-input', 'ajax-filter-input'];

function settings(el) {
  const url = el.dataset.url;
  const fields = JSON.parse(el.dataset.fields);
  const predicate = el.dataset.predicate;
  const displayName = el.dataset.displayName;
  const responseRoot = el.dataset.responseRoot;
  const minimumInputLength = el.dataset.minimumInputLength;
  const order = el.dataset.order;

  const args = { url, fields, predicate, displayName, responseRoot, minimumInputLength, order };

  return {
    events: {
      search: (search, currentData) => {
        args.textQuery = { m: 'or' };
        args.fields.forEach((field) => {
          if (field === 'id') {
            args.textQuery[`${field}_eq`] = search;
          } else {
            args.textQuery[`${field}_${args.predicate}`] = search;
          }
        });

        return ransackSearch(search, currentData, args);
      },
    },
  };
}

export {
  settings,
  classes,
};
