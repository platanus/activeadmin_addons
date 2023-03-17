import merge from 'lodash.merge';

function parseObjectToQuery(obj, prefix) {
  let queryArray = [];
  Object.keys(obj).forEach(key => {
    const value = obj[key];
    const prefixedKey = prefix ? `${prefix}[${key}]` : key;
    if (Array.isArray(value)) {
      value.forEach((v, i) => {
        queryArray = [...queryArray, parseObjectToQuery(v, `${prefixedKey}[${i}]`)];
      });
    } else if (typeof value === 'object') {
      queryArray = [...queryArray, parseObjectToQuery(value, prefixedKey)];
    } else {
      queryArray.push(`${prefixedKey}=${encodeURIComponent(value)}`);
    }
  });

  return queryArray.join('&');
}

export function ransackSearch(search, currentData, settings) {
  return new Promise((resolve, reject) => {
    if (search.length < settings.minimumInputLength) {
      reject(`Please enter ${settings.minimumInputLength} or more characters`);
    }

    const defaultQuery = {
      order: settings.order,
      q: {
        groupings: [settings.textQuery],
        combinator: 'and',
      },
    };

    const finalQuery = merge({}, defaultQuery, settings.query);
    const csrfTokenEl = document.querySelector('meta[name="csrf-token"]');
    const csrfToken = csrfTokenEl ? csrfTokenEl.getAttribute('content') : null;

    const queryString = parseObjectToQuery(finalQuery);
    fetch(`${settings.url}?${queryString}`, {
      method: 'GET',
      headers: {
        'X-CSRF-TOKEN': csrfToken,
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    })
      .then((response) => response.json())
      .then((res) => {
        let data = res;
        if (data.constructor === Object) {
          data = data[settings.responseRoot];
        }

        const options = data.map(resource => {
          if (!resource[settings.displayName]) {
            resource[settings.displayName] = `No display name for id #${resource.id.toString()}`;
          }

          return {
            value: resource.id,
            text: resource[settings.displayName],
          };
        });

        resolve(options);
      });
  });
}
