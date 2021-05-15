const { environment } = require('@rails/webpacker')
const jquery = require('./plugins/jquery')

environment.plugins.prepend('jquery', jquery)
module.exports = environment
