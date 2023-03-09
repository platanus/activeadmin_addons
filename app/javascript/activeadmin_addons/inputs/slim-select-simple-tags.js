const classes = ['simple-tags-input'];

function init(el) {
  el.multiple = true;
  if (!el.value) {
    el.value = null;
  }
}

function settings() {
  return {
    events: {
      addable: (value) => value,
    },
  };
}

export {
  classes,
  init,
  settings,
};
