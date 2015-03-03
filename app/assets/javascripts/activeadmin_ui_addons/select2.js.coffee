#= require select2
#= require_self

$ ->
  $('select:not(.default-select)').each (i, el) ->
    if $(el).closest('.filter_form').length > 0
      $(el).select2(width: 'resolve')
    else
      $(el).select2(width: '80%')
