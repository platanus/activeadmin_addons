import SlimSelect from 'slim-select';

function updateTag(url, data) {
  return fetch(url, {
    method: 'PATCH',
    headers: {
      'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content,
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(data),
  });
}

function setupSelect(el) {
  if (el.slim) {
    el.slim.destroy();
  }

  return new SlimSelect({
    select: el,
    events: {
      // eslint-disable-next-line max-statements
      afterClose: () => {
        const containerEl = el.closest('.tag-select-container');
        const selectContainer = containerEl.querySelector('.interactive-tag-select');
        const tagContainer = containerEl.querySelector('.interactive-tag');
        const model = tagContainer.dataset.model;
        const objectId = tagContainer.dataset.objectId;
        const field = tagContainer.dataset.field;

        if (el.value === tagContainer.dataset.value) {
          selectContainer.classList.add('select-container-hidden');
          containerEl.querySelector('.interactive-tag').classList.remove('interactive-tag-hidden');
        } else {
          const data = { id: objectId };
          data[model] = {};
          data[model][field] = el.value;
          updateTag(tagContainer.dataset.url, data)
            .then(() => {
              const statusTag = tagContainer.querySelector('.status_tag');
              statusTag.innerText = el.selectedOptions[0].text;
              statusTag.classList.remove(tagContainer.dataset.value);
              statusTag.classList.add(el.value);
              tagContainer.dataset.value = el.value;
              selectContainer.dataset.value = el.value;
            })
            .catch(() => {
              const errorMsg = 'Error: Update Unsuccessful';
              console.log(errorMsg);
            })
            .finally(() => {
              selectContainer.classList.add('select-container-hidden');
              containerEl.querySelector('.interactive-tag').classList.remove('interactive-tag-hidden');
            });
        }
      },
    },
  });
}

function setupInteractiveTag(containerEl) {
  const selectContainer = containerEl.querySelector('.interactive-tag-select');
  const slimSelect = setupSelect(selectContainer.querySelector('select'));
  const tag = containerEl.querySelector('.interactive-tag');

  tag.addEventListener('click', () => {
    selectContainer.classList.remove('select-container-hidden');
    tag.classList.add('interactive-tag-hidden');
    window.setTimeout(() => {
      slimSelect.open();
    }, 0);
  });
}

window.addEventListener('load', () => {
  document.querySelectorAll('.tag-select-container').forEach(setupInteractiveTag);
});
