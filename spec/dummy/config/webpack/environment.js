const { environment } = require('@rails/webpacker')
environment.config.set('externals', {
    $: 'jquery',
    jquery: 'jQuery',
});
module.exports = environment;
