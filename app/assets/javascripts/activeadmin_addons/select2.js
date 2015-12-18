//= require select2
//= require_self

$(function() {

  setupSelect2();

  $(document).on('has_many_add:after', setupSelect2);

  function setupSelect2() {
    $('.select2-tags').each(function(i, el) {
      $(el).select2({
        width: '80%',
        tags: $(el).data('collection')
      });
    });

    $('select:not(.default-select)').each(function(i, el) {
      if ($(el).closest('.filter_form').length > 0) {
        $(el).select2({
          width: 'resolve'
        });
      } else {
        $(el).select2({
          width: '80%'
        });
      }
    });

    $('.select2-ajax').each(function(i, el) {
      var url = $(el).data('url');
      var fields = $(el).data('fields');
      var displayName = $(el).data('display_name');
      var parent = $(el).data('parent');
      var model = $(el).data('model');
      var minimumInputLength = $(el).data('minimum_input_length');
      var order = fields[0] + "_desc";
      var parentId = null;
      var selectInstance;

      if (parent) {
        var parentSelector = '#' + model + '_' + parent + '_id' ;

        $(parentSelector).on("change", function(e) {
          selectInstance.val(null).trigger("change");
          parentId = e.val;
        });
      }

      selectInstance = $(el).select2({
        width: '80%',
        initSelection: function(element, callback) {
          var id = $(element).val();
          var text = $(element).data("selected") || "";
          callback({
            id: id,
            text: text
          });
        },
        ajax: {
          url: url,
          dataType: 'json',
          delay: 250,
          data: function (term) {
            var textQuery = {m: "or"};
            fields.forEach(function(field) {
              textQuery[field + "_contains"] = term;
            });

            var query =  {
              order: order,
              q: {
                groupings: [textQuery],
                combinator: 'and'
              }
            };

            if (parentId) {
              query.q[parent + '_eq'] = parentId;
            }

            return query;
          },
          results: function (data, page) {
            return {
              results: jQuery.map(data, function(resource) {
                return {
                  id: resource.id,
                  text: resource[displayName]
                };
              })
            };
          },
          cache: true
        },
        minimumInputLength: minimumInputLength
      });
    });
  }

});
