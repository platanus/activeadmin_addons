const classes = ['tags-input'];

// eslint-disable-next-line max-statements
function settings(el) {
  const isRelation = el.dataset.relation === 'true';
  const collection = el.dataset.collection ? JSON.parse(el.dataset.collection) : null;

  const parsedCollection = collection && collection.map((item) => {
    const { id, ...rest } = item;

    return { ...rest, value: id, selected: !!item.selected };
  });

  const events = {};
  if (!isRelation) {
    events.addable = (value) => value;
  }

  return {
    data: parsedCollection,
    events,
  };
}

export {
  settings,
  classes,
};
