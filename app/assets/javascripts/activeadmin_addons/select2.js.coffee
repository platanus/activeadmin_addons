#= require select2
#= require_self

$ ->
  $('.select2-tags').each (i, el) ->
    $(el).select2
      width: '80%'
      tags: $(el).data('collection')

  $('select:not(.default-select)').each (i, el) ->
    if $(el).closest('.filter_form').length > 0
      $(el).select2(width: 'resolve')
    else
      $(el).select2(width: '80%')
