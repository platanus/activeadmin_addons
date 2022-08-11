/* eslint-disable */
/**
 * Warning: This file is auto-generated, do not modify. Instead, make your changes in 'app/javascript/activeadmin_addons/' and run `yarn build`
 */
//= require select2.full
//= require jquery.xdan.datetimepicker.full

(function(factory) {
  typeof define === "function" && define.amd ? define([ "select2", "jquery-datetimepicker" ], factory) : factory();
})(function() {
  "use strict";
  (function($) {
    $.paletteColorPicker = function(el, options) {
      var ns = "palette-color-picker", $el = $(el), plugin = this, current_value = $el.val(), target = $el.attr("name"), $button = $("<div>").addClass(ns + "-button").attr("data-target", target), $bubble = $("<div>").addClass(ns + "-bubble"), defaults = {
        custom_class: null,
        colors: null,
        position: "upside",
        insert: "before",
        clear_btn: "first",
        timeout: 2e3,
        set_background: false,
        close_all_but_this: false
      }, click_handler = "ontouchstart" in document.documentElement ? "touchstart click" : "click";
      plugin.init = function() {
        plugin.settings = $.extend({}, defaults, options);
        var val = $el.attr("value");
        if (typeof val === typeof undefined || val === false) {
          val = "";
          $el.attr("value", val);
        }
        $el.attr("data-initialvalue", $el.attr("value"));
        if (plugin.settings.colors === null) {
          plugin.settings.colors = $el.data("palette");
        }
        if (typeof plugin.settings.colors[0] === "string") {
          plugin.settings.colors = $.map(plugin.settings.colors, function(el, idx) {
            var b = {};
            b[el] = el;
            return b;
          });
        }
        plugin.settings.insert = plugin.settings.insert.charAt(0).toUpperCase() + plugin.settings.insert.slice(1);
        if (plugin.settings.custom_class) {
          $bubble.addClass(plugin.settings.custom_class);
        }
        $.each(plugin.settings.colors, function(idx, obj) {
          var key = Object.keys(obj)[0], col = obj[key], $sw = $("<span>").addClass("swatch").attr({
            title: key,
            "data-color": col,
            "data-name": key
          }).css("background-color", col);
          if (key === current_value) {
            $sw.addClass("active");
            $button.css("background", col);
          }
          $sw.appendTo($bubble);
        });
        if (plugin.settings.clear_btn !== null) {
          var $clear_btn = $("<span>").addClass("swatch clear").attr("title", "Clear selection");
          if (plugin.settings.clear_btn === "last") {
            $clear_btn.addClass("last").appendTo($bubble);
          } else {
            $clear_btn.prependTo($bubble);
          }
        }
        plugin.destroy = function() {
          $button.remove();
          $.removeData($el[0]);
        };
        plugin.clear = function() {
          $bubble.find(".active").removeClass("active");
          $button.removeAttr("style");
          $el.val("");
        };
        plugin.reset = function() {
          if ($el.attr("data-initialvalue") === "") {
            plugin.clear();
          } else {
            var iv = $el.attr("data-initialvalue");
            $bubble.find('[data-name="' + iv + '"]').trigger("click");
          }
        };
        plugin.reload = function() {
          var newVal = $el.val();
          if (newVal === "" || typeof newVal === typeof undefined || newVal === false) {
            plugin.reset();
          } else {
            if ($bubble.find('[data-name="' + newVal + '"]').length) {
              $bubble.find('[data-name="' + newVal + '"]').trigger("click");
            } else {
              plugin.reset();
            }
          }
        };
        $button.append($bubble).on(click_handler, function(e) {
          e.preventDefault();
          e.stopPropagation();
          var $b = $(this);
          if (!$(e.target).hasClass(ns + "-bubble")) {
            if (typeof plugin.settings.onbeforeshow_callback === "function") {
              plugin.settings.onbeforeshow_callback(this);
            }
            $b.toggleClass("active");
            var $current_bubble = $b.find("." + ns + "-bubble");
            if (plugin.settings.close_all_but_this) {
              $("." + ns + "-bubble").not($current_bubble).fadeOut();
            }
            $current_bubble.fadeToggle();
            if ($b.hasClass("active")) {
              clearTimeout(plugin.timer);
              plugin.timer = setTimeout(function() {
                $b.trigger("pcp.fadeout");
              }, plugin.settings.timeout);
            }
          }
        }).on("pcp.fadeout", function() {
          $(this).removeClass("active").find("." + ns + "-bubble").fadeOut();
        }).on("mouseenter", "." + ns + "-bubble", function() {
          clearTimeout(plugin.timer);
        }).on("mouseleave", "." + ns + "-bubble", function() {
          plugin.timer = setTimeout(function() {
            $button.trigger("pcp.fadeout");
          }, plugin.settings.timeout);
        }).on(click_handler, "." + ns + "-bubble span.swatch", function(e) {
          e.preventDefault();
          e.stopPropagation();
          var col = $(this).attr("data-color"), name = $(this).attr("data-name"), $button = $("." + ns + '-button[data-target="' + $(this).closest("." + ns + "-button").attr("data-target") + '"]'), $bubble = $(this).closest("." + ns + "-bubble");
          $bubble.find(".active").removeClass("active");
          if ($(e.target).is(".clear")) {
            $button.removeAttr("style");
            col = "";
          } else {
            $(this).addClass("active");
            $button.css("background", col);
          }
          if (typeof plugin.settings.onchange_callback === "function") {
            plugin.settings.onchange_callback(col);
          }
          if (plugin.settings.set_background === false) {
            $('[name="' + $button.attr("data-target") + '"]').val(name);
          } else {
            $('[name="' + $button.attr("data-target") + '"]').css({
              "background-color": col
            });
          }
        })["insert" + plugin.settings.insert]($el);
        if (plugin.settings.position === "downside" || $el.offset().top + 20 < $bubble.outerHeight()) {
          $bubble.addClass("downside");
        }
      };
      $("body").on(click_handler, function(event) {
        if (!$(event.target).hasClass(ns + "-button")) {
          $($button).removeClass("active").find("." + ns + "-bubble").fadeOut();
        }
      });
      plugin.init();
    };
    $.fn.paletteColorPicker = function(options) {
      return this.each(function() {
        if (typeof $(this).data("paletteColorPickerPlugin") === "undefined") {
          $(this).data("paletteColorPickerPlugin", new $.paletteColorPicker(this, options));
        }
      });
    };
  })(jQuery);
  var initializer$9 = function() {
    window.ActiveadminAddons = {
      config: {
        defaultSelect: $("body").data("default-select")
      }
    };
  };
  $(initializer$9);
  $(document).on("turbolinks:load turbo:load", initializer$9);
  var initializer$8 = function() {
    configureSelect2(document);
    $(document).on("has_many_add:after", function(event, container) {
      configureSelect2(container);
    });
    function configureSelect2(container) {
      if (window.ActiveadminAddons.config.defaultSelect == "select2") {
        $("select:not(.default-select)", container).each(function(i, el) {
          setupSelect2(el);
        });
      }
      $("select.select2", container).each(function(i, el) {
        setupSelect2(el);
      });
      function setupSelect2(select) {
        var selectConfig = {
          placeholder: "",
          width: "80%",
          allowClear: true
        };
        function isFilter(path) {
          return $(select).closest(path).length > 0;
        }
        if (isFilter(".select_and_search")) {
          selectConfig.width = "resolve";
          selectConfig.allowClear = false;
        } else if (isFilter(".filter_select")) {
          selectConfig.width = "resolve";
        }
        $(select).select2(selectConfig);
        $(select).on("select2:unselecting", function() {
          $(this).data("unselecting", true);
        }).on("select2:open", function() {
          if ($(this).data("unselecting")) {
            $(this).select2("close").removeData("unselecting");
          }
        });
      }
    }
  };
  $(initializer$8);
  $(document).on("turbolinks:load turbo:load", initializer$8);
  var initializer$7 = function() {
    setupSearchSelect(document);
    $(document).on("has_many_add:after", function(event, container) {
      setupSearchSelect(container);
    });
    function setupSearchSelect(container) {
      $(".search-select-input, .search-select-filter-input, ajax-filter-input", container).each(function(i, el) {
        var element = $(el);
        var url = element.data("url");
        var fields = element.data("fields");
        var predicate = element.data("predicate");
        var displayName = element.data("display-name");
        var width = element.data("width");
        var responseRoot = element.data("response-root");
        var minimumInputLength = element.data("minimum-input-length");
        var order = element.data("order");
        var selectOptions = {
          width: width,
          minimumInputLength: minimumInputLength,
          placeholder: "",
          allowClear: true,
          ajax: {
            url: url,
            dataType: "json",
            delay: 250,
            cache: true,
            data: function(params) {
              var textQuery = {
                m: "or"
              };
              fields.forEach(function(field) {
                if (field == "id") {
                  textQuery[field + "_eq"] = params.term;
                } else {
                  textQuery[field + "_" + predicate] = params.term;
                }
              });
              var query = {
                order: order,
                q: {
                  groupings: [ textQuery ],
                  combinator: "and"
                }
              };
              return query;
            },
            processResults: function(data) {
              if (data.constructor == Object) {
                data = data[responseRoot];
              }
              return {
                results: jQuery.map(data, function(resource) {
                  if (!resource[displayName]) {
                    resource[displayName] = "No display name for id #" + resource.id.toString();
                  }
                  return {
                    id: resource.id,
                    text: resource[displayName].toString()
                  };
                })
              };
            }
          }
        };
        $(el).select2(selectOptions);
      });
    }
  };
  $(initializer$7);
  $(document).on("turbolinks:load turbo:load", initializer$7);
  $.fn.select2.amd.define("select2/data/nestedCustomAdapter", [ "select2/data/array", "select2/utils" ], function(ArrayData, Utils) {
    function CustomData($element, options) {
      CustomData.__super__.constructor.call(this, $element, options);
    }
    Utils.Extend(CustomData, ArrayData);
    CustomData.prototype.query = function(params, callback) {
      var data = {
        results: []
      };
      var element = this.$element;
      var collection = element.data("collection");
      var parent = element.data("parent");
      var parentId = element.data("parent-id");
      collection.forEach(function(record) {
        var regex = new RegExp(params.term, "i");
        var matched = !!record.text.match(regex);
        if ((!parent || record[parent] == parentId) && matched) {
          data.results.push(record);
        }
      });
      callback(data);
    };
    CustomData.prototype.current = function(callback) {
      var currentOption = null;
      var element = this.$element;
      var selectedOption = element.data("selected");
      var collection = element.data("collection");
      var data = [];
      $.each(collection, function(index, option) {
        if (!!selectedOption && option.id == selectedOption.id) {
          currentOption = option;
          element.data("selected", null);
          return;
        }
        if (element.val() == option.id) {
          currentOption = option;
          return;
        }
      });
      if (currentOption) {
        data.push(currentOption);
      }
      callback(data);
    };
    return CustomData;
  });
  var initializer$6 = function() {
    configureSelect2(document);
    $(document).on("has_many_add:after", function(event, container) {
      configureSelect2(container);
    });
    function configureSelect2(container) {
      var INVALID_PARENT_ID = -1;
      $(".nested-level-input", container).each(function(i, el) {
        var element = $(el);
        var url = element.data("url");
        var fields = element.data("fields");
        var predicate = element.data("predicate");
        var filters = element.data("filters");
        var displayName = element.data("display-name");
        var parent = element.data("parent");
        var width = element.data("width");
        var model = element.data("model");
        var responseRoot = element.data("response-root");
        var collection = element.data("collection");
        var minimumInputLength = element.data("minimum-input-length");
        var order = element.data("order");
        var parentId = element.data("parent-id");
        var selectInstance;
        var select2Config = {
          width: width,
          minimumInputLength: minimumInputLength,
          placeholder: "",
          allowClear: true
        };
        if (collection) {
          select2Config.dataAdapter = $.fn.select2.amd.require("select2/data/nestedCustomAdapter");
        } else {
          var ajaxConfig = {
            url: url,
            dataType: "json",
            delay: 250,
            cache: true,
            data: function(params) {
              var textQuery = {
                m: "or"
              };
              fields.forEach(function(field) {
                if (field == "id") {
                  textQuery[field + "_eq"] = params.term;
                } else {
                  textQuery[field + "_" + predicate] = params.term;
                }
              });
              var query = {
                order: order,
                q: {
                  groupings: [ textQuery ],
                  combinator: "and"
                }
              };
              if (!!parent) {
                query.q[parent + "_eq"] = parentId;
              }
              Object.assign(query.q, filters);
              return query;
            },
            processResults: function(data) {
              if (data.constructor == Object) {
                data = data[responseRoot];
              }
              return {
                results: jQuery.map(data, function(resource) {
                  if (!resource[displayName]) {
                    resource[displayName] = "No display name for id #" + resource.id.toString();
                  }
                  return {
                    id: resource.id,
                    text: resource[displayName].toString()
                  };
                })
              };
            }
          };
          select2Config.ajax = ajaxConfig;
        }
        selectInstance = element.select2(select2Config);
        function setParentValue(e) {
          selectInstance.val(null).trigger("select2:select").trigger("change");
          parentId = e.params && e.params.data.id ? e.params.data.id : INVALID_PARENT_ID;
          element.data("parent-id", parentId);
        }
        if (!!parent) {
          var parentSelectorId = "#" + model + "_" + parent;
          if (!$(parentSelectorId).length) {
            parentSelectorId = $(container).find("*[id*=" + parent + "]")[0];
          }
          var parentSelector = $(parentSelectorId)[0];
          $(parentSelector).on("select2:select", setParentValue);
          $(parentSelector).on("select2:unselect", setParentValue);
        }
      });
    }
  };
  $(initializer$6);
  $(document).on("turbolinks:load turbo:load", initializer$6);
  var initializer$5 = function() {
    setupTags(document);
    $(document).on("has_many_add:after", function(event, container) {
      setupTags(container);
    });
    function setupTags(container) {
      $(".tags-input", container).each(function(i, el) {
        var model = $(el).data("model");
        var method = $(el).data("method");
        var prefix = model + "_" + method;
        var isRelation = !!$(el).data("relation");
        var collection = $(el).data("collection");
        var width = $(el).data("width");
        var selectOptions = {
          width: width,
          multiple: true,
          tags: true,
          data: collection,
          tokenSeparators: $(el).data("tokenSeparators") || [ "," ]
        };
        if (!!isRelation) {
          selectOptions.createTag = function() {
            return undefined;
          };
        }
        $(el).on("select2:select", onItemAdded);
        $(el).on("select2:unselect", onItemRemoved);
        $(el).select2(selectOptions);
        function getSelectedItems() {
          var choices = $(el).parent("li.input").find(".select2-selection__choice");
          return $.map(choices, function(item) {
            return $(item).attr("title");
          });
        }
        function fillHiddenInput() {
          var hiddenInput = $("#" + prefix);
          hiddenInput.val(getSelectedItems().join());
        }
        function onItemRemoved(event) {
          if (isRelation) {
            var itemId = "[id='" + prefix + "_" + event.params.data.id + "']";
            $(itemId).remove();
          } else {
            fillHiddenInput();
          }
        }
        function onItemAdded(event) {
          if (isRelation) {
            var value = event.params.data.id;
            var selectedItemsContainer = $("[id='" + prefix + "_selected_values']");
            var itemName = model + "[" + method + "][]";
            var itemId = prefix + "_" + value;
            $("<input>").attr({
              id: itemId,
              name: itemName,
              type: "hidden",
              value: value
            }).appendTo(selectedItemsContainer);
          } else {
            fillHiddenInput();
          }
        }
      });
    }
  };
  $(initializer$5);
  $(document).on("turbolinks:load turbo:load", initializer$5);
  var initializer$4 = function() {
    setupSelectedList(document);
    $(document).on("has_many_add:after", function(event, container) {
      setupSelectedList(container);
    });
    function setupSelectedList(container) {
      $(".selected-list-container").click(function(event) {
        var item = $(event.target);
        if (item.hasClass("selected-item")) {
          item.remove();
        }
      });
      $(".selected-list-input", container).each(function(i, el) {
        var element = $(el);
        var url = element.data("url");
        var fields = element.data("fields");
        var predicate = element.data("predicate");
        var displayName = element.data("display-name");
        var method = element.data("method");
        var model = element.data("model");
        var prefix = model + "_" + method;
        var responseRoot = element.data("response-root");
        var minimumInputLength = element.data("minimum-input-length");
        var order = element.data("order");
        var selectOptions = {
          minimumInputLength: minimumInputLength,
          allowClear: true,
          ajax: {
            url: url,
            dataType: "json",
            delay: 250,
            cache: true,
            data: function(params) {
              var textQuery = {
                m: "or"
              };
              fields.forEach(function(field) {
                textQuery[field + "_" + predicate] = params.term;
              });
              var query = {
                order: order,
                q: {
                  groupings: [ textQuery ],
                  combinator: "and"
                }
              };
              return query;
            },
            processResults: function(data) {
              if (data.constructor == Object) {
                data = data[responseRoot];
              }
              return {
                results: jQuery.map(data, function(resource) {
                  return {
                    id: resource.id,
                    text: resource[displayName].toString()
                  };
                })
              };
            }
          }
        };
        $(el).on("select2:select", onItemSelected);
        $(el).on("select2:close", onSelectClosed);
        $(el).select2(selectOptions);
        function onItemSelected(event) {
          var data = event.params.data;
          var selectedItemsContainer = $("[id='" + prefix + "_selected_values']");
          var itemName = model + "[" + method + "][]";
          var itemId = prefix + "_" + data.id;
          if ($("#" + itemId).length > 0) {
            return;
          }
          var item = $("<div>" + data.text + "</div>").attr({
            class: "selected-item",
            id: itemId
          });
          var hiddenInput = $("<input>").attr({
            name: itemName,
            type: "hidden",
            value: data.id
          });
          item.appendTo(selectedItemsContainer);
          hiddenInput.appendTo(item);
        }
        function onSelectClosed() {
          $(el).val(null).trigger("change");
        }
      });
    }
  };
  $(initializer$4);
  $(document).on("turbolinks:load turbo:load", initializer$4);
  var initializer$3 = function() {
    setupDateTimePicker(document);
    $(document).on("has_many_add:after", ".has_many_container", function(event, fieldset) {
      return setupDateTimePicker(fieldset);
    });
    function setupDateTimePicker(container) {
      var defaults = {
        formatDate: "y-m-d",
        format: "Y-m-d H:i",
        allowBlank: true,
        defaultSelect: false,
        validateOnBlur: false,
        scrollInput: false
      };
      var entries = $(container).find("input.date-time-picker-input");
      return entries.each(function(index, entry) {
        var options = $(entry).data("picker-options");
        var mixedOptions = $.extend(defaults, options);
        return $(entry).datetimepicker(mixedOptions);
      });
    }
  };
  $(initializer$3);
  $(document).on("turbolinks:load turbo:load", initializer$3);
  var initializer$2 = function() {
    setupColorPicker();
    $(document).on("has_many_add:after", setupColorPicker);
    function setupColorPicker() {
      $(".color-picker-input").each(function(i, el) {
        $(el).paletteColorPicker({
          clear_btn: "last"
        });
      });
    }
  };
  $(initializer$2);
  $(document).on("turbolinks:load turbo:load", initializer$2);
  var initializer$1 = function() {
    $(".toggle-bool-switch").click(function(e) {
      var boolSwitch = $(e.target);
      var objectId = boolSwitch.data("object_id");
      var model = boolSwitch.data("model");
      var field = boolSwitch.data("field");
      var url = boolSwitch.data("url");
      var value = boolSwitch.data("value");
      var successMessage = boolSwitch.data("success_message");
      var data = {
        id: objectId
      };
      data[model] = {};
      data[model][field] = !value;
      $.ajax({
        url: url,
        data: data,
        dataType: "json",
        headers: {
          "X-CSRF-TOKEN": $('meta[name="csrf-token"]').attr("content")
        },
        error: function() {
          var errorMsg = "Error: Update Unsuccessful";
          alert(errorMsg);
        },
        success: function() {
          boolSwitch.data("value", !value);
          boolSwitch.toggleClass("on");
          if (!boolSwitch.hasClass("notify-success")) return;
          $(function() {
            setTimeout(alert(successMessage), 500);
          });
        },
        type: "PATCH"
      });
    });
  };
  $(initializer$1);
  $(document).on("turbolinks:load turbo:load", initializer$1);
  var initializer = function() {
    configureInteractiveSelect(document);
    $(document).on("has_many_add:after", function(event, container) {
      configureInteractiveSelect(container);
    });
    function configureInteractiveSelect(container) {
      $(".interactive-tag-select select", container).each(function(i, el) {
        setupSelect2(el);
      });
      function setupSelect2(select) {
        var selectConfig = {
          placeholder: "",
          allowClear: false,
          width: "125px"
        };
        $(select).select2(selectConfig);
        $(select).on("select2:unselecting", function() {
          $(this).data("unselecting", true);
        }).on("select2:open", function() {
          if ($(this).data("unselecting")) {
            $(this).select2("close").removeData("unselecting");
          }
        });
      }
    }
    $(".interactive-tag").click(function(e) {
      var tag = $(e.target).parent();
      var model = tag.data("model");
      var objectId = tag.data("object_id");
      var field = tag.data("field");
      var selectTag = $("." + model + "-" + field + "-" + objectId + "-select");
      selectTag.removeClass("select-container-hidden");
      tag.addClass("interactive-tag-hidden");
      selectTag.find("select").select2("open");
    });
    $(".interactive-tag-select").on("select2:close", function(e) {
      var selectTag = $(e.target).parent();
      var model = selectTag.data("model");
      var objectId = selectTag.data("object_id");
      var field = selectTag.data("field");
      var tagContainer = $("." + model + "-" + field + "-" + objectId + "-tag");
      var statusTag = tagContainer.find(".status_tag");
      var newValue = e.target.value;
      var newText = e.target.selectedOptions[0].text;
      var oldValue = selectTag.data("value");
      if (newValue === oldValue) {
        selectTag.addClass("select-container-hidden");
        tagContainer.removeClass("interactive-tag-hidden");
      } else {
        var url = tagContainer.data("url");
        var data = {
          id: objectId
        };
        data[model] = {};
        data[model][field] = newValue;
        $.ajax({
          url: url,
          data: data,
          dataType: "json",
          headers: {
            "X-CSRF-TOKEN": $('meta[name="csrf-token"]').attr("content")
          },
          error: function() {
            var errorMsg = "Error: Update Unsuccessful";
            console.log(errorMsg);
          },
          success: function() {
            statusTag.text(newText);
            statusTag.removeClass(oldValue);
            statusTag.addClass(newValue);
            tagContainer.data("value", newValue);
            selectTag.data("value", newValue);
          },
          complete: function() {
            selectTag.addClass("select-container-hidden");
            tagContainer.removeClass("interactive-tag-hidden");
          },
          type: "PATCH"
        });
      }
    });
  };
  $(initializer);
  $(document).on("turbolinks:load turbo:load", initializer);
});
