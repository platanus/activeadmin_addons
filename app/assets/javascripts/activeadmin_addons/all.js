/* eslint-disable */
/**
 * Warning: This file is auto-generated, do not modify. Instead, make your changes in 'app/javascript/activeadmin_addons/' and run `yarn build`
 */
//= require jquery.xdan.datetimepicker.full

(function(factory) {
  typeof define === "function" && define.amd ? define([ "jquery-datetimepicker" ], factory) : factory();
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
  const loadEvents = [ "turbo:load", "turbolinks:load", "DOMContentLoaded" ];
  function initializer$3() {
    window.ActiveadminAddons = {
      config: {
        defaultSelect: document.querySelector("body").dataset.defaultSelect
      }
    };
  }
  loadEvents.forEach(event => {
    document.addEventListener(event, initializer$3);
  });
  function generateID() {
    return Math.random().toString(36).substring(2, 10);
  }
  function hasClassInTree(element, className) {
    function hasClass(e, c) {
      if (c && e && e.classList && e.classList.contains(c)) {
        return e;
      }
      if (c && e && e.dataset && e.dataset.id && e.dataset.id === className) {
        return e;
      }
      return null;
    }
    function parentByClass(e, c) {
      if (!e || e === document) {
        return null;
      } else if (hasClass(e, c)) {
        return e;
      } else {
        return parentByClass(e.parentNode, c);
      }
    }
    return hasClass(element, className) || parentByClass(element, className);
  }
  function debounce(func, wait = 50, immediate = false) {
    let timeout;
    return function(...args) {
      const context = self;
      const later = () => {
        timeout = null;
        if (!immediate) {
          func.apply(context, args);
        }
      };
      const callNow = immediate && !timeout;
      clearTimeout(timeout);
      timeout = setTimeout(later, wait);
      if (callNow) {
        func.apply(context, args);
      }
    };
  }
  function isEqual(a, b) {
    return JSON.stringify(a) === JSON.stringify(b);
  }
  function kebabCase(str) {
    const result = str.replace(/[A-Z\u00C0-\u00D6\u00D8-\u00DE]/g, match => "-" + match.toLowerCase());
    return str[0] === str[0].toUpperCase() ? result.substring(1) : result;
  }
  class Settings {
    constructor(settings) {
      this.id = "";
      this.style = "";
      this.class = [];
      this.isMultiple = false;
      this.isOpen = false;
      this.isWindowFocused = true;
      this.triggerFocus = true;
      this.intervalMove = null;
      if (!settings) {
        settings = {};
      }
      this.id = "ss-" + generateID();
      this.style = settings.style || "";
      this.class = settings.class || [];
      this.disabled = settings.disabled !== undefined ? settings.disabled : false;
      this.alwaysOpen = settings.alwaysOpen !== undefined ? settings.alwaysOpen : false;
      this.showSearch = settings.showSearch !== undefined ? settings.showSearch : true;
      this.searchPlaceholder = settings.searchPlaceholder || "Search";
      this.searchText = settings.searchText || "No Results";
      this.searchingText = settings.searchingText || "Searching...";
      this.searchHighlight = settings.searchHighlight !== undefined ? settings.searchHighlight : false;
      this.closeOnSelect = settings.closeOnSelect !== undefined ? settings.closeOnSelect : true;
      this.contentLocation = settings.contentLocation || document.body;
      this.contentPosition = settings.contentPosition || "absolute";
      this.openPosition = settings.openPosition || "auto";
      this.placeholderText = settings.placeholderText !== undefined ? settings.placeholderText : "Select Value";
      this.allowDeselect = settings.allowDeselect !== undefined ? settings.allowDeselect : false;
      this.hideSelected = settings.hideSelected !== undefined ? settings.hideSelected : false;
      this.showOptionTooltips = settings.showOptionTooltips !== undefined ? settings.showOptionTooltips : false;
      this.minSelected = settings.minSelected || 0;
      this.maxSelected = settings.maxSelected || 1e3;
      this.timeoutDelay = settings.timeoutDelay || 200;
      this.maxValuesShown = settings.maxValuesShown || 20;
      this.maxValuesMessage = settings.maxValuesMessage || "{number} selected";
    }
  }
  class Optgroup {
    constructor(optgroup) {
      this.id = !optgroup.id || optgroup.id === "" ? generateID() : optgroup.id;
      this.label = optgroup.label || "";
      this.selectAll = optgroup.selectAll === undefined ? false : optgroup.selectAll;
      this.closable = optgroup.closable || "off";
      this.options = [];
      if (optgroup.options) {
        for (const o of optgroup.options) {
          this.options.push(new Option(o));
        }
      }
    }
  }
  class Option {
    constructor(option) {
      this.id = !option.id || option.id === "" ? generateID() : option.id;
      this.value = option.value === undefined ? option.text : option.value;
      this.text = option.text || "";
      this.html = option.html || "";
      this.selected = option.selected !== undefined ? option.selected : false;
      this.display = option.display !== undefined ? option.display : true;
      this.disabled = option.disabled !== undefined ? option.disabled : false;
      this.mandatory = option.mandatory !== undefined ? option.mandatory : false;
      this.placeholder = option.placeholder !== undefined ? option.placeholder : false;
      this.class = option.class || "";
      this.style = option.style || "";
      this.data = option.data || {};
    }
  }
  class Store {
    constructor(type, data) {
      this.selectType = "single";
      this.data = [];
      this.selectType = type;
      this.setData(data);
    }
    validateDataArray(data) {
      if (!Array.isArray(data)) {
        return new Error("Data must be an array");
      }
      for (let dataObj of data) {
        if (dataObj instanceof Optgroup || "label" in dataObj) {
          if (!("label" in dataObj)) {
            return new Error("Optgroup must have a label");
          }
          if ("options" in dataObj && dataObj.options) {
            for (let option of dataObj.options) {
              return this.validateOption(option);
            }
          }
        } else if (dataObj instanceof Option || "text" in dataObj) {
          return this.validateOption(dataObj);
        } else {
          return new Error("Data object must be a valid optgroup or option");
        }
      }
      return null;
    }
    validateOption(option) {
      if (!("text" in option)) {
        return new Error("Option must have a text");
      }
      return null;
    }
    partialToFullData(data) {
      let dataFinal = [];
      data.forEach(dataObj => {
        if (dataObj instanceof Optgroup || "label" in dataObj) {
          let optOptions = [];
          if ("options" in dataObj && dataObj.options) {
            dataObj.options.forEach(option => {
              optOptions.push(new Option(option));
            });
          }
          if (optOptions.length > 0) {
            dataFinal.push(new Optgroup(dataObj));
          }
        }
        if (dataObj instanceof Option || "text" in dataObj) {
          dataFinal.push(new Option(dataObj));
        }
      });
      return dataFinal;
    }
    setData(data) {
      this.data = this.partialToFullData(data);
      if (this.selectType === "single") {
        this.setSelectedBy("value", this.getSelected());
      }
    }
    getData() {
      return this.filter(null, true);
    }
    getDataOptions() {
      return this.filter(null, false);
    }
    addOption(option) {
      this.setData(this.getData().concat(new Option(option)));
    }
    setSelectedBy(selectedType, selectedValues) {
      let firstOption = null;
      let hasSelected = false;
      for (let dataObj of this.data) {
        if (dataObj instanceof Optgroup) {
          for (let option of dataObj.options) {
            if (!firstOption) {
              firstOption = option;
            }
            option.selected = hasSelected ? false : selectedValues.includes(option[selectedType]);
            if (option.selected && this.selectType === "single") {
              hasSelected = true;
            }
          }
        }
        if (dataObj instanceof Option) {
          if (!firstOption) {
            firstOption = dataObj;
          }
          dataObj.selected = hasSelected ? false : selectedValues.includes(dataObj[selectedType]);
          if (dataObj.selected && this.selectType === "single") {
            hasSelected = true;
          }
        }
      }
      if (this.selectType === "single" && firstOption && !hasSelected) {
        firstOption.selected = true;
      }
    }
    getSelected() {
      let selectedOptions = this.getSelectedOptions();
      let selectedValues = [];
      selectedOptions.forEach(option => {
        selectedValues.push(option.value);
      });
      return selectedValues;
    }
    getSelectedOptions() {
      return this.filter(opt => {
        return opt.selected;
      }, false);
    }
    getSelectedIDs() {
      let selectedOptions = this.getSelectedOptions();
      let selectedIDs = [];
      selectedOptions.forEach(op => {
        selectedIDs.push(op.id);
      });
      return selectedIDs;
    }
    getOptgroupByID(id) {
      for (let dataObj of this.data) {
        if (dataObj instanceof Optgroup && dataObj.id === id) {
          return dataObj;
        }
      }
      return null;
    }
    getOptionByID(id) {
      let options = this.filter(opt => {
        return opt.id === id;
      }, false);
      return options.length ? options[0] : null;
    }
    search(search, searchFilter) {
      search = search.trim();
      if (search === "") {
        return this.getData();
      }
      return this.filter(opt => {
        return searchFilter(opt, search);
      }, true);
    }
    filter(filter, includeOptgroup) {
      const dataSearch = [];
      this.data.forEach(dataObj => {
        if (dataObj instanceof Optgroup) {
          let optOptions = [];
          dataObj.options.forEach(option => {
            if (!filter || filter(option)) {
              if (!includeOptgroup) {
                dataSearch.push(new Option(option));
              } else {
                optOptions.push(new Option(option));
              }
            }
          });
          if (optOptions.length > 0) {
            let optgroup = new Optgroup(dataObj);
            optgroup.options = optOptions;
            dataSearch.push(optgroup);
          }
        }
        if (dataObj instanceof Option) {
          if (!filter || filter(dataObj)) {
            dataSearch.push(new Option(dataObj));
          }
        }
      });
      return dataSearch;
    }
  }
  class Render {
    constructor(settings, store, callbacks) {
      this.classes = {
        main: "ss-main",
        placeholder: "ss-placeholder",
        values: "ss-values",
        single: "ss-single",
        max: "ss-max",
        value: "ss-value",
        valueText: "ss-value-text",
        valueDelete: "ss-value-delete",
        valueOut: "ss-value-out",
        deselect: "ss-deselect",
        deselectPath: "M10,10 L90,90 M10,90 L90,10",
        arrow: "ss-arrow",
        arrowClose: "M10,30 L50,70 L90,30",
        arrowOpen: "M10,70 L50,30 L90,70",
        content: "ss-content",
        openAbove: "ss-open-above",
        openBelow: "ss-open-below",
        search: "ss-search",
        searchHighlighter: "ss-search-highlight",
        searching: "ss-searching",
        addable: "ss-addable",
        addablePath: "M50,10 L50,90 M10,50 L90,50",
        list: "ss-list",
        optgroup: "ss-optgroup",
        optgroupLabel: "ss-optgroup-label",
        optgroupLabelText: "ss-optgroup-label-text",
        optgroupActions: "ss-optgroup-actions",
        optgroupSelectAll: "ss-selectall",
        optgroupSelectAllBox: "M60,10 L10,10 L10,90 L90,90 L90,50",
        optgroupSelectAllCheck: "M30,45 L50,70 L90,10",
        optgroupClosable: "ss-closable",
        option: "ss-option",
        optionDelete: "M10,10 L90,90 M10,90 L90,10",
        highlighted: "ss-highlighted",
        open: "ss-open",
        close: "ss-close",
        selected: "ss-selected",
        error: "ss-error",
        disabled: "ss-disabled",
        hide: "ss-hide"
      };
      this.store = store;
      this.settings = settings;
      this.callbacks = callbacks;
      this.main = this.mainDiv();
      this.content = this.contentDiv();
      this.updateClassStyles();
      this.settings.contentLocation.appendChild(this.content.main);
    }
    enable() {
      this.main.main.classList.remove(this.classes.disabled);
      this.content.search.input.disabled = false;
    }
    disable() {
      this.main.main.classList.add(this.classes.disabled);
      this.content.search.input.disabled = true;
    }
    open() {
      this.main.arrow.path.setAttribute("d", this.classes.arrowOpen);
      this.main.main.classList.add(this.settings.openPosition === "up" ? this.classes.openAbove : this.classes.openBelow);
      this.moveContent();
      const selectedOptions = this.store.getSelectedOptions();
      if (selectedOptions.length) {
        const selectedId = selectedOptions[selectedOptions.length - 1].id;
        const selectedOption = this.content.list.querySelector('[data-id="' + selectedId + '"]');
        if (selectedOption) {
          this.ensureElementInView(this.content.list, selectedOption);
        }
      }
    }
    close() {
      this.main.main.classList.remove(this.classes.openAbove);
      this.main.main.classList.remove(this.classes.openBelow);
      this.content.main.classList.remove(this.classes.openAbove);
      this.content.main.classList.remove(this.classes.openBelow);
      this.main.arrow.path.setAttribute("d", this.classes.arrowClose);
    }
    updateClassStyles() {
      this.main.main.className = "";
      this.main.main.removeAttribute("style");
      this.content.main.className = "";
      this.content.main.removeAttribute("style");
      this.main.main.classList.add(this.classes.main);
      this.content.main.classList.add(this.classes.content);
      if (this.settings.style !== "") {
        this.content.main.style.cssText = this.settings.style;
      }
      if (this.settings.class.length) {
        for (const c of this.settings.class) {
          if (c.trim() !== "") {
            this.main.main.classList.add(c.trim());
            this.content.main.classList.add(c.trim());
          }
        }
      }
      if (this.settings.contentPosition === "relative") {
        this.content.main.classList.add("ss-" + this.settings.contentPosition);
      }
    }
    mainDiv() {
      const main = document.createElement("div");
      main.dataset.id = this.settings.id;
      main.tabIndex = 0;
      main.onfocus = () => {
        if (this.settings.triggerFocus && this.settings.isWindowFocused) {
          this.callbacks.open();
        }
      };
      main.onkeydown = e => {
        switch (e.key) {
         case "ArrowUp":
         case "ArrowDown":
          this.callbacks.open();
          e.key === "ArrowDown" ? this.highlight("down") : this.highlight("up");
          return false;

         case "Tab":
          this.callbacks.close();
          return true;

         case "Enter":
          const highlighted = this.content.list.querySelector("." + this.classes.highlighted);
          if (highlighted) {
            highlighted.click();
          }
          return false;

         case "Escape":
          this.callbacks.close();
          return false;
        }
      };
      main.onclick = e => {
        if (this.settings.disabled) {
          return;
        }
        this.settings.isOpen ? this.callbacks.close() : this.callbacks.open();
      };
      const values = document.createElement("div");
      values.classList.add(this.classes.values);
      main.appendChild(values);
      const deselect = document.createElement("div");
      deselect.classList.add(this.classes.deselect);
      if (!this.settings.allowDeselect || this.settings.isMultiple) {
        deselect.classList.add(this.classes.hide);
      }
      deselect.onclick = e => {
        e.stopPropagation();
        if (this.settings.disabled) {
          return;
        }
        let shouldDelete = true;
        const before = this.store.getSelectedOptions();
        const after = [];
        if (this.callbacks.beforeChange) {
          shouldDelete = this.callbacks.beforeChange(after, before) === true;
        }
        if (shouldDelete) {
          this.callbacks.setSelected([ "" ], false);
          if (this.settings.closeOnSelect) {
            this.callbacks.close();
          }
          if (this.callbacks.afterChange) {
            this.callbacks.afterChange(after);
          }
        }
      };
      const deselectSvg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
      deselectSvg.setAttribute("viewBox", "0 0 100 100");
      const deselectPath = document.createElementNS("http://www.w3.org/2000/svg", "path");
      deselectPath.setAttribute("d", this.classes.deselectPath);
      deselectSvg.appendChild(deselectPath);
      deselect.appendChild(deselectSvg);
      main.appendChild(deselect);
      const arrow = document.createElementNS("http://www.w3.org/2000/svg", "svg");
      arrow.classList.add(this.classes.arrow);
      arrow.setAttribute("viewBox", "0 0 100 100");
      const arrowPath = document.createElementNS("http://www.w3.org/2000/svg", "path");
      arrowPath.setAttribute("d", this.classes.arrowClose);
      if (this.settings.alwaysOpen) {
        arrow.classList.add(this.classes.hide);
      }
      arrow.appendChild(arrowPath);
      main.appendChild(arrow);
      return {
        main: main,
        values: values,
        deselect: {
          main: deselect,
          svg: deselectSvg,
          path: deselectPath
        },
        arrow: {
          main: arrow,
          path: arrowPath
        }
      };
    }
    mainFocus(trigger) {
      if (!trigger) {
        this.settings.triggerFocus = false;
      }
      this.main.main.focus({
        preventScroll: true
      });
      this.settings.triggerFocus = true;
    }
    placeholder() {
      const placeholderOption = this.store.filter(o => o.placeholder, false);
      let placeholderText = this.settings.placeholderText;
      if (placeholderOption.length) {
        if (placeholderOption[0].html !== "") {
          placeholderText = placeholderOption[0].html;
        } else if (placeholderOption[0].text !== "") {
          placeholderText = placeholderOption[0].text;
        }
      }
      const placeholder = document.createElement("div");
      placeholder.classList.add(this.classes.placeholder);
      placeholder.innerHTML = placeholderText;
      return placeholder;
    }
    renderValues() {
      if (!this.settings.isMultiple) {
        this.renderSingleValue();
        return;
      }
      this.renderMultipleValues();
    }
    renderSingleValue() {
      const selected = this.store.filter(o => {
        return o.selected && !o.placeholder;
      }, false);
      const selectedSingle = selected.length > 0 ? selected[0] : null;
      if (!selectedSingle) {
        this.main.values.innerHTML = this.placeholder().outerHTML;
      } else {
        const singleValue = document.createElement("div");
        singleValue.classList.add(this.classes.single);
        singleValue.innerHTML = selectedSingle.html ? selectedSingle.html : selectedSingle.text;
        this.main.values.innerHTML = singleValue.outerHTML;
      }
      if (!this.settings.allowDeselect || !selected.length) {
        this.main.deselect.main.classList.add(this.classes.hide);
      } else {
        this.main.deselect.main.classList.remove(this.classes.hide);
      }
    }
    renderMultipleValues() {
      let currentNodes = this.main.values.childNodes;
      let selectedOptions = this.store.filter(opt => {
        return opt.selected && opt.display;
      }, false);
      if (selectedOptions.length === 0) {
        this.main.values.innerHTML = this.placeholder().outerHTML;
        return;
      } else {
        const placeholder = this.main.values.querySelector("." + this.classes.placeholder);
        if (placeholder) {
          placeholder.remove();
        }
      }
      if (selectedOptions.length > this.settings.maxValuesShown) {
        const singleValue = document.createElement("div");
        singleValue.classList.add(this.classes.max);
        singleValue.textContent = this.settings.maxValuesMessage.replace("{number}", selectedOptions.length.toString());
        this.main.values.innerHTML = singleValue.outerHTML;
        return;
      } else {
        const maxValuesMessage = this.main.values.querySelector("." + this.classes.max);
        if (maxValuesMessage) {
          maxValuesMessage.remove();
        }
      }
      let removeNodes = [];
      for (let i = 0; i < currentNodes.length; i++) {
        const node = currentNodes[i];
        const id = node.getAttribute("data-id");
        if (id) {
          const found = selectedOptions.filter(opt => {
            return opt.id === id;
          }, false);
          if (!found.length) {
            removeNodes.push(node);
          }
        }
      }
      for (const n of removeNodes) {
        n.classList.add(this.classes.valueOut);
        setTimeout(() => {
          this.main.values.removeChild(n);
        }, 100);
      }
      currentNodes = this.main.values.childNodes;
      for (let d = 0; d < selectedOptions.length; d++) {
        let shouldAdd = true;
        for (let i = 0; i < currentNodes.length; i++) {
          if (selectedOptions[d].id === String(currentNodes[i].dataset.id)) {
            shouldAdd = false;
          }
        }
        if (shouldAdd) {
          if (currentNodes.length === 0) {
            this.main.values.appendChild(this.multipleValue(selectedOptions[d]));
          } else if (d === 0) {
            this.main.values.insertBefore(this.multipleValue(selectedOptions[d]), currentNodes[d]);
          } else {
            currentNodes[d - 1].insertAdjacentElement("afterend", this.multipleValue(selectedOptions[d]));
          }
        }
      }
    }
    multipleValue(option) {
      const value = document.createElement("div");
      value.classList.add(this.classes.value);
      value.dataset.id = option.id;
      const text = document.createElement("div");
      text.classList.add(this.classes.valueText);
      text.innerHTML = option.text;
      value.appendChild(text);
      if (!option.mandatory) {
        const deleteDiv = document.createElement("div");
        deleteDiv.classList.add(this.classes.valueDelete);
        deleteDiv.onclick = e => {
          e.preventDefault();
          e.stopPropagation();
          if (this.settings.disabled) {
            return;
          }
          let shouldDelete = true;
          const before = this.store.getSelectedOptions();
          const after = before.filter(o => {
            return o.selected && o.id !== option.id;
          }, true);
          if (this.settings.minSelected && after.length < this.settings.minSelected) {
            return;
          }
          if (this.callbacks.beforeChange) {
            shouldDelete = this.callbacks.beforeChange(after, before) === true;
          }
          if (shouldDelete) {
            let selectedValues = [];
            for (const o of after) {
              if (o instanceof Optgroup) {
                for (const c of o.options) {
                  selectedValues.push(c.value);
                }
              }
              if (o instanceof Option) {
                selectedValues.push(o.value);
              }
            }
            this.callbacks.setSelected(selectedValues, false);
            if (this.settings.closeOnSelect) {
              this.callbacks.close();
            }
            if (this.callbacks.afterChange) {
              this.callbacks.afterChange(after);
            }
          }
        };
        const deleteSvg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
        deleteSvg.setAttribute("viewBox", "0 0 100 100");
        const deletePath = document.createElementNS("http://www.w3.org/2000/svg", "path");
        deletePath.setAttribute("d", this.classes.optionDelete);
        deleteSvg.appendChild(deletePath);
        deleteDiv.appendChild(deleteSvg);
        value.appendChild(deleteDiv);
      }
      return value;
    }
    contentDiv() {
      const main = document.createElement("div");
      main.dataset.id = this.settings.id;
      const search = this.searchDiv();
      main.appendChild(search.main);
      const list = this.listDiv();
      main.appendChild(list);
      return {
        main: main,
        search: search,
        list: list
      };
    }
    moveContent() {
      if (this.settings.contentPosition === "relative") {
        this.moveContentBelow();
        return;
      }
      if (this.settings.openPosition === "down") {
        this.moveContentBelow();
        return;
      } else if (this.settings.openPosition === "up") {
        this.moveContentAbove();
        return;
      }
      if (this.putContent() === "up") {
        this.moveContentAbove();
      } else {
        this.moveContentBelow();
      }
    }
    searchDiv() {
      const main = document.createElement("div");
      const input = document.createElement("input");
      const addable = document.createElement("div");
      main.classList.add(this.classes.search);
      const searchReturn = {
        main: main,
        input: input
      };
      if (!this.settings.showSearch) {
        main.classList.add(this.classes.hide);
        input.readOnly = true;
      }
      input.type = "search";
      input.placeholder = this.settings.searchPlaceholder;
      input.tabIndex = -1;
      input.setAttribute("aria-label", this.settings.searchPlaceholder);
      input.setAttribute("autocapitalize", "off");
      input.setAttribute("autocomplete", "off");
      input.setAttribute("autocorrect", "off");
      input.oninput = debounce(e => {
        this.callbacks.search(e.target.value);
      }, 100);
      input.onkeydown = e => {
        switch (e.key) {
         case "ArrowUp":
         case "ArrowDown":
          this.callbacks.open();
          e.key === "ArrowDown" ? this.highlight("down") : this.highlight("up");
          return false;

         case "Tab":
          this.callbacks.close();
          return true;

         case "Escape":
          this.callbacks.close();
          return false;

         case "Enter":
          if (this.callbacks.addable && e.ctrlKey) {
            addable.click();
          } else {
            const highlighted = this.content.list.querySelector("." + this.classes.highlighted);
            if (highlighted) {
              highlighted.click();
            }
          }
          return false;
        }
      };
      input.onfocus = () => {
        if (this.settings.isOpen) {
          return;
        }
        this.callbacks.open();
      };
      main.appendChild(input);
      if (this.callbacks.addable) {
        addable.classList.add(this.classes.addable);
        const plus = document.createElementNS("http://www.w3.org/2000/svg", "svg");
        plus.setAttribute("viewBox", "0 0 100 100");
        const plusPath = document.createElementNS("http://www.w3.org/2000/svg", "path");
        plusPath.setAttribute("d", this.classes.addablePath);
        plus.appendChild(plusPath);
        addable.appendChild(plus);
        addable.onclick = e => {
          e.preventDefault();
          e.stopPropagation();
          if (!this.callbacks.addable) {
            return;
          }
          const inputValue = this.content.search.input.value.trim();
          if (inputValue === "") {
            this.content.search.input.focus();
            return;
          }
          const runFinish = oo => {
            let newOption = new Option(oo);
            this.callbacks.addOption(newOption);
            if (this.settings.isMultiple) {
              let values = this.store.getSelected();
              values.push(newOption.value);
              this.callbacks.setSelected(values, true);
            } else {
              this.callbacks.setSelected([ newOption.value ], true);
            }
            this.callbacks.search("");
            if (this.settings.closeOnSelect) {
              setTimeout(() => {
                this.callbacks.close();
              }, 100);
            }
          };
          const addableValue = this.callbacks.addable(inputValue);
          if (addableValue instanceof Promise) {
            addableValue.then(value => {
              if (typeof value === "string") {
                runFinish({
                  text: value,
                  value: value
                });
              } else {
                runFinish(value);
              }
            });
          } else if (typeof addableValue === "string") {
            runFinish({
              text: addableValue,
              value: addableValue
            });
          } else {
            runFinish(addableValue);
          }
          return;
        };
        main.appendChild(addable);
        searchReturn.addable = {
          main: addable,
          svg: plus,
          path: plusPath
        };
      }
      return searchReturn;
    }
    searchFocus(trigger) {
      if (!trigger) {
        this.settings.triggerFocus = false;
      }
      this.content.search.input.focus();
      this.settings.triggerFocus = true;
    }
    getOptions(notPlaceholder = false, notDisabled = false, notHidden = false) {
      let query = "." + this.classes.option;
      if (notPlaceholder) {
        query += ":not(." + this.classes.placeholder + ")";
      }
      if (notDisabled) {
        query += ":not(." + this.classes.disabled + ")";
      }
      if (notHidden) {
        query += ":not(." + this.classes.hide + ")";
      }
      return Array.from(this.content.list.querySelectorAll(query));
    }
    highlight(dir) {
      const options = this.getOptions(true, true, true);
      if (options.length === 0) {
        return;
      }
      if (options.length === 1) {
        if (!options[0].classList.contains(this.classes.highlighted)) {
          options[0].classList.add(this.classes.highlighted);
          return;
        }
      }
      for (let i = 0; i < options.length; i++) {
        if (options[i].classList.contains(this.classes.highlighted)) {
          const prevOption = options[i];
          prevOption.classList.remove(this.classes.highlighted);
          const prevParent = prevOption.parentElement;
          if (prevParent && prevParent.classList.contains(this.classes.open)) {
            const optgroupLabel = prevParent.querySelector("." + this.classes.optgroupLabel);
            if (optgroupLabel) {
              optgroupLabel.click();
            }
          }
          let selectOption = options[dir === "down" ? i + 1 < options.length ? i + 1 : 0 : i - 1 >= 0 ? i - 1 : options.length - 1];
          selectOption.classList.add(this.classes.highlighted);
          this.ensureElementInView(this.content.list, selectOption);
          const selectParent = selectOption.parentElement;
          if (selectParent && selectParent.classList.contains(this.classes.close)) {
            const optgroupLabel = selectParent.querySelector("." + this.classes.optgroupLabel);
            if (optgroupLabel) {
              optgroupLabel.click();
            }
          }
          return;
        }
      }
      options[dir === "down" ? 0 : options.length - 1].classList.add(this.classes.highlighted);
      this.ensureElementInView(this.content.list, options[dir === "down" ? 0 : options.length - 1]);
    }
    listDiv() {
      const options = document.createElement("div");
      options.classList.add(this.classes.list);
      options.setAttribute("role", "listbox");
      return options;
    }
    renderError(error) {
      this.content.list.innerHTML = "";
      const errorDiv = document.createElement("div");
      errorDiv.classList.add(this.classes.error);
      errorDiv.textContent = error;
      this.content.list.appendChild(errorDiv);
    }
    renderSearching() {
      this.content.list.innerHTML = "";
      const searchingDiv = document.createElement("div");
      searchingDiv.classList.add(this.classes.searching);
      searchingDiv.textContent = this.settings.searchingText;
      this.content.list.appendChild(searchingDiv);
    }
    renderOptions(data) {
      this.content.list.innerHTML = "";
      if (data.length === 0) {
        const noResults = document.createElement("div");
        noResults.classList.add(this.classes.search);
        noResults.innerHTML = this.settings.searchText;
        this.content.list.appendChild(noResults);
        return;
      }
      for (const d of data) {
        if (d instanceof Optgroup) {
          const optgroupEl = document.createElement("div");
          optgroupEl.classList.add(this.classes.optgroup);
          const optgroupLabel = document.createElement("div");
          optgroupLabel.classList.add(this.classes.optgroupLabel);
          optgroupEl.appendChild(optgroupLabel);
          const optgroupLabelText = document.createElement("div");
          optgroupLabelText.classList.add(this.classes.optgroupLabelText);
          optgroupLabelText.textContent = d.label;
          optgroupLabel.appendChild(optgroupLabelText);
          const optgroupActions = document.createElement("div");
          optgroupActions.classList.add(this.classes.optgroupActions);
          optgroupLabel.appendChild(optgroupActions);
          if (this.settings.isMultiple && d.selectAll) {
            const selectAll = document.createElement("div");
            selectAll.classList.add(this.classes.optgroupSelectAll);
            let allSelected = true;
            for (const o of d.options) {
              if (!o.selected) {
                allSelected = false;
                break;
              }
            }
            if (allSelected) {
              selectAll.classList.add(this.classes.selected);
            }
            const selectAllText = document.createElement("span");
            selectAllText.textContent = "Select All";
            selectAll.appendChild(selectAllText);
            const selectAllSvg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
            selectAllSvg.setAttribute("viewBox", "0 0 100 100");
            selectAll.appendChild(selectAllSvg);
            const selectAllBox = document.createElementNS("http://www.w3.org/2000/svg", "path");
            selectAllBox.setAttribute("d", this.classes.optgroupSelectAllBox);
            selectAllSvg.appendChild(selectAllBox);
            const selectAllCheck = document.createElementNS("http://www.w3.org/2000/svg", "path");
            selectAllCheck.setAttribute("d", this.classes.optgroupSelectAllCheck);
            selectAllSvg.appendChild(selectAllCheck);
            selectAll.addEventListener("click", e => {
              e.preventDefault();
              e.stopPropagation();
              const currentSelected = this.store.getSelected();
              if (allSelected) {
                const newSelected = currentSelected.filter(s => {
                  for (const o of d.options) {
                    if (s === o.value) {
                      return false;
                    }
                  }
                  return true;
                });
                this.callbacks.setSelected(newSelected, true);
                return;
              } else {
                const newSelected = currentSelected.concat(d.options.map(o => o.value));
                this.callbacks.setSelected(newSelected, true);
              }
            });
            optgroupActions.appendChild(selectAll);
          }
          if (d.closable !== "off") {
            const optgroupClosable = document.createElement("div");
            optgroupClosable.classList.add(this.classes.optgroupClosable);
            const optgroupClosableSvg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
            optgroupClosableSvg.setAttribute("viewBox", "0 0 100 100");
            optgroupClosableSvg.classList.add(this.classes.arrow);
            optgroupClosable.appendChild(optgroupClosableSvg);
            const optgroupClosableArrow = document.createElementNS("http://www.w3.org/2000/svg", "path");
            optgroupClosableSvg.appendChild(optgroupClosableArrow);
            if (d.options.some(o => o.selected) || this.content.search.input.value.trim() !== "") {
              optgroupClosable.classList.add(this.classes.open);
              optgroupClosableArrow.setAttribute("d", this.classes.arrowOpen);
            } else if (d.closable === "open") {
              optgroupEl.classList.add(this.classes.open);
              optgroupClosableArrow.setAttribute("d", this.classes.arrowOpen);
            } else if (d.closable === "close") {
              optgroupEl.classList.add(this.classes.close);
              optgroupClosableArrow.setAttribute("d", this.classes.arrowClose);
            }
            optgroupLabel.addEventListener("click", e => {
              e.preventDefault();
              e.stopPropagation();
              if (optgroupEl.classList.contains(this.classes.close)) {
                optgroupEl.classList.remove(this.classes.close);
                optgroupEl.classList.add(this.classes.open);
                optgroupClosableArrow.setAttribute("d", this.classes.arrowOpen);
              } else {
                optgroupEl.classList.remove(this.classes.open);
                optgroupEl.classList.add(this.classes.close);
                optgroupClosableArrow.setAttribute("d", this.classes.arrowClose);
              }
            });
            optgroupActions.appendChild(optgroupClosable);
          }
          optgroupEl.appendChild(optgroupLabel);
          for (const o of d.options) {
            optgroupEl.appendChild(this.option(o));
          }
          this.content.list.appendChild(optgroupEl);
        }
        if (d instanceof Option) {
          this.content.list.appendChild(this.option(d));
        }
      }
    }
    option(option) {
      if (option.placeholder) {
        const placeholder = document.createElement("div");
        placeholder.classList.add(this.classes.option);
        placeholder.classList.add(this.classes.hide);
        return placeholder;
      }
      const optionEl = document.createElement("div");
      optionEl.dataset.id = option.id;
      optionEl.classList.add(this.classes.option);
      optionEl.setAttribute("role", "option");
      if (option.class) {
        option.class.split(" ").forEach(dataClass => {
          optionEl.classList.add(dataClass);
        });
      }
      if (option.style) {
        optionEl.style.cssText = option.style;
      }
      if (this.settings.searchHighlight && this.content.search.input.value.trim() !== "") {
        optionEl.innerHTML = this.highlightText(option.html !== "" ? option.html : option.text, this.content.search.input.value, this.classes.searchHighlighter);
      } else if (option.html !== "") {
        optionEl.innerHTML = option.html;
      } else {
        optionEl.textContent = option.text;
      }
      if (this.settings.showOptionTooltips && optionEl.textContent) {
        optionEl.setAttribute("title", optionEl.textContent);
      }
      if (!option.display) {
        optionEl.classList.add(this.classes.hide);
      }
      if (option.disabled) {
        optionEl.classList.add(this.classes.disabled);
      }
      if (option.selected && this.settings.hideSelected) {
        optionEl.classList.add(this.classes.hide);
      }
      if (option.selected) {
        optionEl.classList.add(this.classes.selected);
      } else {
        optionEl.classList.remove(this.classes.selected);
      }
      optionEl.addEventListener("click", e => {
        e.preventDefault();
        e.stopPropagation();
        const selectedOptions = this.store.getSelected();
        const element = e.currentTarget;
        const elementID = String(element.dataset.id);
        if (option.disabled || option.selected && !this.settings.allowDeselect) {
          return;
        }
        if (this.settings.isMultiple && this.settings.maxSelected <= selectedOptions.length && !option.selected || this.settings.isMultiple && this.settings.minSelected >= selectedOptions.length && option.selected) {
          return;
        }
        let shouldUpdate = false;
        const before = this.store.getSelectedOptions();
        let after = [];
        if (this.settings.isMultiple) {
          if (option.selected) {
            after = before.filter(o => o.id !== elementID);
          } else {
            after = before.concat(option);
          }
        }
        if (!this.settings.isMultiple) {
          if (option.selected) {
            after = [];
          } else {
            after = [ option ];
          }
        }
        if (!this.callbacks.beforeChange) {
          shouldUpdate = true;
        }
        if (this.callbacks.beforeChange) {
          if (this.callbacks.beforeChange(after, before) === false) {
            shouldUpdate = false;
          } else {
            shouldUpdate = true;
          }
        }
        if (shouldUpdate) {
          if (!this.store.getOptionByID(elementID)) {
            this.callbacks.addOption(option);
          }
          this.callbacks.setSelected(after.map(o => o.value), false);
          if (this.settings.closeOnSelect) {
            this.callbacks.close();
          }
          if (this.callbacks.afterChange) {
            this.callbacks.afterChange(after);
          }
        }
      });
      return optionEl;
    }
    destroy() {
      this.main.main.remove();
      this.content.main.remove();
    }
    highlightText(str, search, className) {
      let completedString = str;
      const regex = new RegExp("(" + search.trim() + ")(?![^<]*>[^<>]*</)", "i");
      if (!str.match(regex)) {
        return str;
      }
      const matchStartPosition = str.match(regex).index;
      const matchEndPosition = matchStartPosition + str.match(regex)[0].toString().length;
      const originalTextFoundByRegex = str.substring(matchStartPosition, matchEndPosition);
      completedString = completedString.replace(regex, `<mark class="${className}">${originalTextFoundByRegex}</mark>`);
      return completedString;
    }
    moveContentAbove() {
      const mainHeight = this.main.main.offsetHeight;
      const contentHeight = this.content.main.offsetHeight;
      this.main.main.classList.remove(this.classes.openBelow);
      this.main.main.classList.add(this.classes.openAbove);
      this.content.main.classList.remove(this.classes.openBelow);
      this.content.main.classList.add(this.classes.openAbove);
      const containerRect = this.main.main.getBoundingClientRect();
      this.content.main.style.margin = "-" + (mainHeight + contentHeight - 1) + "px 0px 0px 0px";
      this.content.main.style.top = containerRect.top + containerRect.height + window.scrollY + "px";
      this.content.main.style.left = containerRect.left + window.scrollX + "px";
      this.content.main.style.width = containerRect.width + "px";
    }
    moveContentBelow() {
      this.main.main.classList.remove(this.classes.openAbove);
      this.main.main.classList.add(this.classes.openBelow);
      this.content.main.classList.remove(this.classes.openAbove);
      this.content.main.classList.add(this.classes.openBelow);
      const containerRect = this.main.main.getBoundingClientRect();
      this.content.main.style.margin = "-1px 0px 0px 0px";
      if (this.settings.contentPosition !== "relative") {
        this.content.main.style.top = containerRect.top + containerRect.height + window.scrollY + "px";
        this.content.main.style.left = containerRect.left + window.scrollX + "px";
        this.content.main.style.width = containerRect.width + "px";
      }
    }
    ensureElementInView(container, element) {
      const cTop = container.scrollTop + container.offsetTop;
      const cBottom = cTop + container.clientHeight;
      const eTop = element.offsetTop;
      const eBottom = eTop + element.clientHeight;
      if (eTop < cTop) {
        container.scrollTop -= cTop - eTop;
      } else if (eBottom > cBottom) {
        container.scrollTop += eBottom - cBottom;
      }
    }
    putContent() {
      const mainHeight = this.main.main.offsetHeight;
      const mainRect = this.main.main.getBoundingClientRect();
      const contentHeight = this.content.main.offsetHeight;
      const spaceBelow = window.innerHeight - (mainRect.top + mainHeight);
      if (spaceBelow <= contentHeight) {
        if (mainRect.top > contentHeight) {
          return "up";
        } else {
          return "down";
        }
      }
      return "down";
    }
  }
  class Select {
    constructor(select) {
      this.listen = false;
      this.observer = null;
      this.select = select;
      this.select.addEventListener("change", this.valueChange.bind(this), {
        passive: true
      });
      this.observer = new MutationObserver(this.observeCall.bind(this));
      this.changeListen(true);
    }
    enable() {
      this.select.disabled = false;
    }
    disable() {
      this.select.disabled = true;
    }
    hideUI() {
      this.select.tabIndex = -1;
      this.select.style.display = "none";
      this.select.setAttribute("aria-hidden", "true");
    }
    showUI() {
      this.select.removeAttribute("tabindex");
      this.select.style.display = "";
      this.select.removeAttribute("aria-hidden");
    }
    changeListen(listen) {
      this.listen = listen;
      if (listen) {
        if (this.observer) {
          this.observer.observe(this.select, {
            subtree: true,
            childList: true,
            attributes: true
          });
        }
      }
      if (!listen) {
        if (this.observer) {
          this.observer.disconnect();
        }
      }
    }
    valueChange(ev) {
      if (this.listen && this.onValueChange) {
        this.onValueChange(this.getSelectedValues());
      }
      return true;
    }
    observeCall(mutations) {
      if (!this.listen) {
        return;
      }
      let classChanged = false;
      let disabledChanged = false;
      let optgroupOptionChanged = false;
      for (const m of mutations) {
        if (m.target === this.select) {
          if (m.attributeName === "disabled") {
            disabledChanged = true;
          }
          if (m.attributeName === "class") {
            classChanged = true;
          }
        }
        if (m.target.nodeName === "OPTGROUP" || m.target.nodeName === "OPTION") {
          optgroupOptionChanged = true;
        }
      }
      if (classChanged && this.onClassChange) {
        this.onClassChange(this.select.className.split(" "));
      }
      if (disabledChanged && this.onDisabledChange) {
        this.changeListen(false);
        this.onDisabledChange(this.select.disabled);
        this.changeListen(true);
      }
      if (optgroupOptionChanged && this.onOptionsChange) {
        this.changeListen(false);
        this.onOptionsChange(this.getData());
        this.changeListen(true);
      }
    }
    getData() {
      let data = [];
      const nodes = this.select.childNodes;
      for (const n of nodes) {
        if (n.nodeName === "OPTGROUP") {
          data.push(this.getDataFromOptgroup(n));
        }
        if (n.nodeName === "OPTION") {
          data.push(this.getDataFromOption(n));
        }
      }
      return data;
    }
    getDataFromOptgroup(optgroup) {
      let data = {
        id: optgroup.id,
        label: optgroup.label,
        selectAll: optgroup.dataset ? optgroup.dataset.selectall === "true" : false,
        closable: optgroup.dataset ? optgroup.dataset.closable : "off",
        options: []
      };
      const options = optgroup.childNodes;
      for (const o of options) {
        if (o.nodeName === "OPTION") {
          data.options.push(this.getDataFromOption(o));
        }
      }
      return data;
    }
    getDataFromOption(option) {
      return {
        id: option.id,
        value: option.value,
        text: option.text,
        html: option.dataset && option.dataset.html ? option.dataset.html : "",
        selected: option.selected,
        display: option.style.display === "none" ? false : true,
        disabled: option.disabled,
        mandatory: option.dataset ? option.dataset.mandatory === "true" : false,
        placeholder: option.dataset.placeholder === "true",
        class: option.className,
        style: option.style.cssText,
        data: option.dataset
      };
    }
    getSelectedValues() {
      let values = [];
      const options = this.select.childNodes;
      for (const o of options) {
        if (o.nodeName === "OPTGROUP") {
          const optgroupOptions = o.childNodes;
          for (const oo of optgroupOptions) {
            if (oo.nodeName === "OPTION") {
              const option = oo;
              if (option.selected) {
                values.push(option.value);
              }
            }
          }
        }
        if (o.nodeName === "OPTION") {
          const option = o;
          if (option.selected) {
            values.push(option.value);
          }
        }
      }
      return values;
    }
    setSelected(value) {
      this.changeListen(false);
      const options = this.select.childNodes;
      for (const o of options) {
        if (o.nodeName === "OPTGROUP") {
          const optgroup = o;
          const optgroupOptions = optgroup.childNodes;
          for (const oo of optgroupOptions) {
            if (oo.nodeName === "OPTION") {
              const option = oo;
              option.selected = value.includes(option.value);
            }
          }
        }
        if (o.nodeName === "OPTION") {
          const option = o;
          option.selected = value.includes(option.value);
        }
      }
      this.changeListen(true);
    }
    updateSelect(id, style, classes) {
      this.changeListen(false);
      if (id) {
        this.select.dataset.id = id;
      }
      if (style) {
        this.select.style.cssText = style;
      }
      if (classes) {
        this.select.className = "";
        classes.forEach(c => {
          if (c.trim() !== "") {
            this.select.classList.add(c.trim());
          }
        });
      }
      this.changeListen(true);
    }
    updateOptions(data) {
      this.changeListen(false);
      this.select.innerHTML = "";
      for (const d of data) {
        if (d instanceof Optgroup) {
          this.select.appendChild(this.createOptgroup(d));
        }
        if (d instanceof Option) {
          this.select.appendChild(this.createOption(d));
        }
      }
      this.select.dispatchEvent(new Event("change"));
      this.changeListen(true);
    }
    createOptgroup(optgroup) {
      const optgroupEl = document.createElement("optgroup");
      optgroupEl.id = optgroup.id;
      optgroupEl.label = optgroup.label;
      if (optgroup.selectAll) {
        optgroupEl.dataset.selectAll = "true";
      }
      if (optgroup.closable !== "off") {
        optgroupEl.dataset.closable = optgroup.closable;
      }
      if (optgroup.options) {
        for (const o of optgroup.options) {
          optgroupEl.appendChild(this.createOption(o));
        }
      }
      return optgroupEl;
    }
    createOption(info) {
      const optionEl = document.createElement("option");
      optionEl.id = info.id;
      optionEl.value = info.value;
      optionEl.innerHTML = info.text;
      if (info.html !== "") {
        optionEl.setAttribute("data-html", info.html);
      }
      if (info.selected) {
        optionEl.selected = info.selected;
      }
      if (info.disabled) {
        optionEl.disabled = true;
      }
      if (info.display === false) {
        optionEl.style.display = "none";
      }
      if (info.placeholder) {
        optionEl.setAttribute("data-placeholder", "true");
      }
      if (info.mandatory) {
        optionEl.setAttribute("data-mandatory", "true");
      }
      if (info.class) {
        info.class.split(" ").forEach(optionClass => {
          optionEl.classList.add(optionClass);
        });
      }
      if (info.data && typeof info.data === "object") {
        Object.keys(info.data).forEach(key => {
          optionEl.setAttribute("data-" + kebabCase(key), info.data[key]);
        });
      }
      return optionEl;
    }
    destroy() {
      this.changeListen(false);
      this.select.removeEventListener("change", this.valueChange.bind(this));
      if (this.observer) {
        this.observer.disconnect();
        this.observer = null;
      }
      delete this.select.dataset.id;
      this.showUI();
    }
  }
  class SlimSelect {
    constructor(config) {
      var _a;
      this.events = {
        search: undefined,
        searchFilter: (opt, search) => {
          return opt.text.toLowerCase().indexOf(search.toLowerCase()) !== -1;
        },
        addable: undefined,
        beforeChange: undefined,
        afterChange: undefined,
        beforeOpen: undefined,
        afterOpen: undefined,
        beforeClose: undefined,
        afterClose: undefined
      };
      this.windowResize = debounce(() => {
        if (!this.settings.isOpen) {
          return;
        }
        this.render.moveContent();
      });
      this.windowScroll = debounce(() => {
        if (!this.settings.isOpen) {
          return;
        }
        this.render.moveContent();
      });
      this.documentClick = e => {
        if (!this.settings.isOpen) {
          return;
        }
        if (e.target && !hasClassInTree(e.target, this.settings.id)) {
          this.close();
        }
      };
      this.windowVisibilityChange = () => {
        if (document.hidden) {
          this.settings.isWindowFocused = false;
          this.close();
        } else {
          setTimeout(() => {
            this.settings.isWindowFocused = true;
          }, 20);
        }
      };
      this.selectEl = typeof config.select === "string" ? document.querySelector(config.select) : config.select;
      if (!this.selectEl) {
        if (config.events && config.events.error) {
          config.events.error(new Error("Could not find select element"));
        }
        return;
      }
      if (this.selectEl.tagName !== "SELECT") {
        if (config.events && config.events.error) {
          config.events.error(new Error("Element isnt of type select"));
        }
        return;
      }
      if (this.selectEl.dataset.ssid) {
        this.destroy();
      }
      this.settings = new Settings(config.settings);
      const debounceEvents = [ "afterChange", "beforeOpen", "afterOpen", "beforeClose", "afterClose" ];
      for (const key in config.events) {
        if (!config.events.hasOwnProperty(key)) {
          continue;
        }
        if (debounceEvents.indexOf(key) !== -1) {
          this.events[key] = debounce(config.events[key], 100);
        } else {
          this.events[key] = config.events[key];
        }
      }
      this.settings.disabled = ((_a = config.settings) === null || _a === void 0 ? void 0 : _a.disabled) ? config.settings.disabled : this.selectEl.disabled;
      this.settings.isMultiple = this.selectEl.multiple;
      this.settings.style = this.selectEl.style.cssText;
      this.settings.class = this.selectEl.className.split(" ");
      this.select = new Select(this.selectEl);
      this.select.updateSelect(this.settings.id, this.settings.style, this.settings.class);
      this.select.hideUI();
      this.select.onValueChange = values => {
        this.setSelected(values);
      };
      this.select.onClassChange = classes => {
        this.settings.class = classes;
        this.render.updateClassStyles();
      };
      this.select.onDisabledChange = disabled => {
        if (disabled) {
          this.disable();
        } else {
          this.enable();
        }
      };
      this.select.onOptionsChange = data => {
        this.setData(data);
      };
      this.store = new Store(this.settings.isMultiple ? "multiple" : "single", config.data ? config.data : this.select.getData());
      if (config.data) {
        this.select.updateOptions(this.store.getData());
      }
      const callbacks = {
        open: this.open.bind(this),
        close: this.close.bind(this),
        addable: this.events.addable ? this.events.addable : undefined,
        setSelected: this.setSelected.bind(this),
        addOption: this.addOption.bind(this),
        search: this.search.bind(this),
        beforeChange: this.events.beforeChange,
        afterChange: this.events.afterChange
      };
      this.render = new Render(this.settings, this.store, callbacks);
      this.render.renderValues();
      this.render.renderOptions(this.store.getData());
      if (this.selectEl.parentNode) {
        this.selectEl.parentNode.insertBefore(this.render.main.main, this.selectEl.nextSibling);
      }
      document.addEventListener("click", this.documentClick);
      window.addEventListener("resize", this.windowResize, false);
      if (this.settings.openPosition === "auto") {
        window.addEventListener("scroll", this.windowScroll, false);
      }
      document.addEventListener("visibilitychange", this.windowVisibilityChange);
      if (this.settings.disabled) {
        this.disable();
      }
      if (this.settings.alwaysOpen) {
        this.open();
      }
      this.selectEl.slim = this;
    }
    enable() {
      this.settings.disabled = false;
      this.select.enable();
      this.render.enable();
    }
    disable() {
      this.settings.disabled = true;
      this.select.disable();
      this.render.disable();
    }
    getData() {
      return this.store.getData();
    }
    setData(data) {
      const selected = this.store.getSelected();
      const err = this.store.validateDataArray(data);
      if (err) {
        if (this.events.error) {
          this.events.error(err);
        }
        return;
      }
      this.store.setData(data);
      const dataClean = this.store.getData();
      this.select.updateOptions(dataClean);
      this.render.renderValues();
      this.render.renderOptions(dataClean);
      if (this.events.afterChange && !isEqual(selected, this.store.getSelected())) {
        this.events.afterChange(this.store.getSelectedOptions());
      }
    }
    getSelected() {
      return this.store.getSelected();
    }
    setSelected(value, runAfterChange = true) {
      const selected = this.store.getSelected();
      this.store.setSelectedBy("value", Array.isArray(value) ? value : [ value ]);
      const data = this.store.getData();
      this.select.updateOptions(data);
      this.render.renderValues();
      if (this.render.content.search.input.value !== "") {
        this.search(this.render.content.search.input.value);
      } else {
        this.render.renderOptions(data);
      }
      if (runAfterChange && this.events.afterChange && !isEqual(selected, this.store.getSelected())) {
        this.events.afterChange(this.store.getSelectedOptions());
      }
    }
    addOption(option) {
      const selected = this.store.getSelected();
      if (!this.store.getDataOptions().some(o => {
        var _a;
        return o.value === ((_a = option.value) !== null && _a !== void 0 ? _a : option.text);
      })) {
        this.store.addOption(option);
      }
      const data = this.store.getData();
      this.select.updateOptions(data);
      this.render.renderValues();
      this.render.renderOptions(data);
      if (this.events.afterChange && !isEqual(selected, this.store.getSelected())) {
        this.events.afterChange(this.store.getSelectedOptions());
      }
    }
    open() {
      if (this.settings.disabled || this.settings.isOpen) {
        return;
      }
      if (this.events.beforeOpen) {
        this.events.beforeOpen();
      }
      this.render.open();
      if (this.settings.showSearch) {
        this.render.searchFocus(false);
      }
      setTimeout(() => {
        if (this.events.afterOpen) {
          this.events.afterOpen();
        }
        this.settings.isOpen = true;
      }, this.settings.timeoutDelay);
      if (this.settings.contentPosition === "absolute") {
        if (this.settings.intervalMove) {
          clearInterval(this.settings.intervalMove);
        }
        this.settings.intervalMove = setInterval(this.render.moveContent.bind(this.render), 500);
      }
    }
    close() {
      if (!this.settings.isOpen || this.settings.alwaysOpen) {
        return;
      }
      if (this.events.beforeClose) {
        this.events.beforeClose();
      }
      this.render.close();
      if (this.render.content.search.input.value !== "") {
        this.search("");
      }
      this.render.mainFocus(false);
      setTimeout(() => {
        if (this.events.afterClose) {
          this.events.afterClose();
        }
        this.settings.isOpen = false;
      }, this.settings.timeoutDelay);
      if (this.settings.intervalMove) {
        clearInterval(this.settings.intervalMove);
      }
    }
    search(value) {
      if (this.render.content.search.input.value !== value) {
        this.render.content.search.input.value = value;
      }
      if (!this.events.search) {
        this.render.renderOptions(value === "" ? this.store.getData() : this.store.search(value, this.events.searchFilter));
        return;
      }
      this.render.renderSearching();
      const searchResp = this.events.search(value, this.store.getSelectedOptions());
      if (searchResp instanceof Promise) {
        searchResp.then(data => {
          this.render.renderOptions(this.store.partialToFullData(data));
        }).catch(err => {
          this.render.renderError(typeof err === "string" ? err : err.message);
        });
        return;
      } else if (Array.isArray(searchResp)) {
        this.render.renderOptions(this.store.partialToFullData(searchResp));
      } else {
        this.render.renderError("Search event must return a promise or an array of data");
      }
    }
    destroy() {
      document.removeEventListener("click", this.documentClick);
      window.removeEventListener("resize", this.windowResize, false);
      if (this.settings.openPosition === "auto") {
        window.removeEventListener("scroll", this.windowScroll, false);
      }
      document.removeEventListener("visibilitychange", this.windowVisibilityChange);
      this.store.setData([]);
      this.render.destroy();
      this.select.destroy();
    }
  }
  var commonjsGlobal = typeof globalThis !== "undefined" ? globalThis : typeof window !== "undefined" ? window : typeof global !== "undefined" ? global : typeof self !== "undefined" ? self : {};
  function createCommonjsModule(fn, module) {
    return module = {
      exports: {}
    }, fn(module, module.exports), module.exports;
  }
  var lodash_merge = createCommonjsModule(function(module, exports) {
    var LARGE_ARRAY_SIZE = 200;
    var HASH_UNDEFINED = "__lodash_hash_undefined__";
    var HOT_COUNT = 800, HOT_SPAN = 16;
    var MAX_SAFE_INTEGER = 9007199254740991;
    var argsTag = "[object Arguments]", arrayTag = "[object Array]", asyncTag = "[object AsyncFunction]", boolTag = "[object Boolean]", dateTag = "[object Date]", errorTag = "[object Error]", funcTag = "[object Function]", genTag = "[object GeneratorFunction]", mapTag = "[object Map]", numberTag = "[object Number]", nullTag = "[object Null]", objectTag = "[object Object]", proxyTag = "[object Proxy]", regexpTag = "[object RegExp]", setTag = "[object Set]", stringTag = "[object String]", undefinedTag = "[object Undefined]", weakMapTag = "[object WeakMap]";
    var arrayBufferTag = "[object ArrayBuffer]", dataViewTag = "[object DataView]", float32Tag = "[object Float32Array]", float64Tag = "[object Float64Array]", int8Tag = "[object Int8Array]", int16Tag = "[object Int16Array]", int32Tag = "[object Int32Array]", uint8Tag = "[object Uint8Array]", uint8ClampedTag = "[object Uint8ClampedArray]", uint16Tag = "[object Uint16Array]", uint32Tag = "[object Uint32Array]";
    var reRegExpChar = /[\\^$.*+?()[\]{}|]/g;
    var reIsHostCtor = /^\[object .+?Constructor\]$/;
    var reIsUint = /^(?:0|[1-9]\d*)$/;
    var typedArrayTags = {};
    typedArrayTags[float32Tag] = typedArrayTags[float64Tag] = typedArrayTags[int8Tag] = typedArrayTags[int16Tag] = typedArrayTags[int32Tag] = typedArrayTags[uint8Tag] = typedArrayTags[uint8ClampedTag] = typedArrayTags[uint16Tag] = typedArrayTags[uint32Tag] = true;
    typedArrayTags[argsTag] = typedArrayTags[arrayTag] = typedArrayTags[arrayBufferTag] = typedArrayTags[boolTag] = typedArrayTags[dataViewTag] = typedArrayTags[dateTag] = typedArrayTags[errorTag] = typedArrayTags[funcTag] = typedArrayTags[mapTag] = typedArrayTags[numberTag] = typedArrayTags[objectTag] = typedArrayTags[regexpTag] = typedArrayTags[setTag] = typedArrayTags[stringTag] = typedArrayTags[weakMapTag] = false;
    var freeGlobal = typeof commonjsGlobal == "object" && commonjsGlobal && commonjsGlobal.Object === Object && commonjsGlobal;
    var freeSelf = typeof self == "object" && self && self.Object === Object && self;
    var root = freeGlobal || freeSelf || Function("return this")();
    var freeExports = exports && !exports.nodeType && exports;
    var freeModule = freeExports && "object" == "object" && module && !module.nodeType && module;
    var moduleExports = freeModule && freeModule.exports === freeExports;
    var freeProcess = moduleExports && freeGlobal.process;
    var nodeUtil = function() {
      try {
        var types = freeModule && freeModule.require && freeModule.require("util").types;
        if (types) {
          return types;
        }
        return freeProcess && freeProcess.binding && freeProcess.binding("util");
      } catch (e) {}
    }();
    var nodeIsTypedArray = nodeUtil && nodeUtil.isTypedArray;
    function apply(func, thisArg, args) {
      switch (args.length) {
       case 0:
        return func.call(thisArg);

       case 1:
        return func.call(thisArg, args[0]);

       case 2:
        return func.call(thisArg, args[0], args[1]);

       case 3:
        return func.call(thisArg, args[0], args[1], args[2]);
      }
      return func.apply(thisArg, args);
    }
    function baseTimes(n, iteratee) {
      var index = -1, result = Array(n);
      while (++index < n) {
        result[index] = iteratee(index);
      }
      return result;
    }
    function baseUnary(func) {
      return function(value) {
        return func(value);
      };
    }
    function getValue(object, key) {
      return object == null ? undefined : object[key];
    }
    function overArg(func, transform) {
      return function(arg) {
        return func(transform(arg));
      };
    }
    var arrayProto = Array.prototype, funcProto = Function.prototype, objectProto = Object.prototype;
    var coreJsData = root["__core-js_shared__"];
    var funcToString = funcProto.toString;
    var hasOwnProperty = objectProto.hasOwnProperty;
    var maskSrcKey = function() {
      var uid = /[^.]+$/.exec(coreJsData && coreJsData.keys && coreJsData.keys.IE_PROTO || "");
      return uid ? "Symbol(src)_1." + uid : "";
    }();
    var nativeObjectToString = objectProto.toString;
    var objectCtorString = funcToString.call(Object);
    var reIsNative = RegExp("^" + funcToString.call(hasOwnProperty).replace(reRegExpChar, "\\$&").replace(/hasOwnProperty|(function).*?(?=\\\()| for .+?(?=\\\])/g, "$1.*?") + "$");
    var Buffer = moduleExports ? root.Buffer : undefined, Symbol = root.Symbol, Uint8Array = root.Uint8Array, allocUnsafe = Buffer ? Buffer.allocUnsafe : undefined, getPrototype = overArg(Object.getPrototypeOf, Object), objectCreate = Object.create, propertyIsEnumerable = objectProto.propertyIsEnumerable, splice = arrayProto.splice, symToStringTag = Symbol ? Symbol.toStringTag : undefined;
    var defineProperty = function() {
      try {
        var func = getNative(Object, "defineProperty");
        func({}, "", {});
        return func;
      } catch (e) {}
    }();
    var nativeIsBuffer = Buffer ? Buffer.isBuffer : undefined, nativeMax = Math.max, nativeNow = Date.now;
    var Map = getNative(root, "Map"), nativeCreate = getNative(Object, "create");
    var baseCreate = function() {
      function object() {}
      return function(proto) {
        if (!isObject(proto)) {
          return {};
        }
        if (objectCreate) {
          return objectCreate(proto);
        }
        object.prototype = proto;
        var result = new object();
        object.prototype = undefined;
        return result;
      };
    }();
    function Hash(entries) {
      var index = -1, length = entries == null ? 0 : entries.length;
      this.clear();
      while (++index < length) {
        var entry = entries[index];
        this.set(entry[0], entry[1]);
      }
    }
    function hashClear() {
      this.__data__ = nativeCreate ? nativeCreate(null) : {};
      this.size = 0;
    }
    function hashDelete(key) {
      var result = this.has(key) && delete this.__data__[key];
      this.size -= result ? 1 : 0;
      return result;
    }
    function hashGet(key) {
      var data = this.__data__;
      if (nativeCreate) {
        var result = data[key];
        return result === HASH_UNDEFINED ? undefined : result;
      }
      return hasOwnProperty.call(data, key) ? data[key] : undefined;
    }
    function hashHas(key) {
      var data = this.__data__;
      return nativeCreate ? data[key] !== undefined : hasOwnProperty.call(data, key);
    }
    function hashSet(key, value) {
      var data = this.__data__;
      this.size += this.has(key) ? 0 : 1;
      data[key] = nativeCreate && value === undefined ? HASH_UNDEFINED : value;
      return this;
    }
    Hash.prototype.clear = hashClear;
    Hash.prototype["delete"] = hashDelete;
    Hash.prototype.get = hashGet;
    Hash.prototype.has = hashHas;
    Hash.prototype.set = hashSet;
    function ListCache(entries) {
      var index = -1, length = entries == null ? 0 : entries.length;
      this.clear();
      while (++index < length) {
        var entry = entries[index];
        this.set(entry[0], entry[1]);
      }
    }
    function listCacheClear() {
      this.__data__ = [];
      this.size = 0;
    }
    function listCacheDelete(key) {
      var data = this.__data__, index = assocIndexOf(data, key);
      if (index < 0) {
        return false;
      }
      var lastIndex = data.length - 1;
      if (index == lastIndex) {
        data.pop();
      } else {
        splice.call(data, index, 1);
      }
      --this.size;
      return true;
    }
    function listCacheGet(key) {
      var data = this.__data__, index = assocIndexOf(data, key);
      return index < 0 ? undefined : data[index][1];
    }
    function listCacheHas(key) {
      return assocIndexOf(this.__data__, key) > -1;
    }
    function listCacheSet(key, value) {
      var data = this.__data__, index = assocIndexOf(data, key);
      if (index < 0) {
        ++this.size;
        data.push([ key, value ]);
      } else {
        data[index][1] = value;
      }
      return this;
    }
    ListCache.prototype.clear = listCacheClear;
    ListCache.prototype["delete"] = listCacheDelete;
    ListCache.prototype.get = listCacheGet;
    ListCache.prototype.has = listCacheHas;
    ListCache.prototype.set = listCacheSet;
    function MapCache(entries) {
      var index = -1, length = entries == null ? 0 : entries.length;
      this.clear();
      while (++index < length) {
        var entry = entries[index];
        this.set(entry[0], entry[1]);
      }
    }
    function mapCacheClear() {
      this.size = 0;
      this.__data__ = {
        hash: new Hash(),
        map: new (Map || ListCache)(),
        string: new Hash()
      };
    }
    function mapCacheDelete(key) {
      var result = getMapData(this, key)["delete"](key);
      this.size -= result ? 1 : 0;
      return result;
    }
    function mapCacheGet(key) {
      return getMapData(this, key).get(key);
    }
    function mapCacheHas(key) {
      return getMapData(this, key).has(key);
    }
    function mapCacheSet(key, value) {
      var data = getMapData(this, key), size = data.size;
      data.set(key, value);
      this.size += data.size == size ? 0 : 1;
      return this;
    }
    MapCache.prototype.clear = mapCacheClear;
    MapCache.prototype["delete"] = mapCacheDelete;
    MapCache.prototype.get = mapCacheGet;
    MapCache.prototype.has = mapCacheHas;
    MapCache.prototype.set = mapCacheSet;
    function Stack(entries) {
      var data = this.__data__ = new ListCache(entries);
      this.size = data.size;
    }
    function stackClear() {
      this.__data__ = new ListCache();
      this.size = 0;
    }
    function stackDelete(key) {
      var data = this.__data__, result = data["delete"](key);
      this.size = data.size;
      return result;
    }
    function stackGet(key) {
      return this.__data__.get(key);
    }
    function stackHas(key) {
      return this.__data__.has(key);
    }
    function stackSet(key, value) {
      var data = this.__data__;
      if (data instanceof ListCache) {
        var pairs = data.__data__;
        if (!Map || pairs.length < LARGE_ARRAY_SIZE - 1) {
          pairs.push([ key, value ]);
          this.size = ++data.size;
          return this;
        }
        data = this.__data__ = new MapCache(pairs);
      }
      data.set(key, value);
      this.size = data.size;
      return this;
    }
    Stack.prototype.clear = stackClear;
    Stack.prototype["delete"] = stackDelete;
    Stack.prototype.get = stackGet;
    Stack.prototype.has = stackHas;
    Stack.prototype.set = stackSet;
    function arrayLikeKeys(value, inherited) {
      var isArr = isArray(value), isArg = !isArr && isArguments(value), isBuff = !isArr && !isArg && isBuffer(value), isType = !isArr && !isArg && !isBuff && isTypedArray(value), skipIndexes = isArr || isArg || isBuff || isType, result = skipIndexes ? baseTimes(value.length, String) : [], length = result.length;
      for (var key in value) {
        if ((inherited || hasOwnProperty.call(value, key)) && !(skipIndexes && (key == "length" || isBuff && (key == "offset" || key == "parent") || isType && (key == "buffer" || key == "byteLength" || key == "byteOffset") || isIndex(key, length)))) {
          result.push(key);
        }
      }
      return result;
    }
    function assignMergeValue(object, key, value) {
      if (value !== undefined && !eq(object[key], value) || value === undefined && !(key in object)) {
        baseAssignValue(object, key, value);
      }
    }
    function assignValue(object, key, value) {
      var objValue = object[key];
      if (!(hasOwnProperty.call(object, key) && eq(objValue, value)) || value === undefined && !(key in object)) {
        baseAssignValue(object, key, value);
      }
    }
    function assocIndexOf(array, key) {
      var length = array.length;
      while (length--) {
        if (eq(array[length][0], key)) {
          return length;
        }
      }
      return -1;
    }
    function baseAssignValue(object, key, value) {
      if (key == "__proto__" && defineProperty) {
        defineProperty(object, key, {
          configurable: true,
          enumerable: true,
          value: value,
          writable: true
        });
      } else {
        object[key] = value;
      }
    }
    var baseFor = createBaseFor();
    function baseGetTag(value) {
      if (value == null) {
        return value === undefined ? undefinedTag : nullTag;
      }
      return symToStringTag && symToStringTag in Object(value) ? getRawTag(value) : objectToString(value);
    }
    function baseIsArguments(value) {
      return isObjectLike(value) && baseGetTag(value) == argsTag;
    }
    function baseIsNative(value) {
      if (!isObject(value) || isMasked(value)) {
        return false;
      }
      var pattern = isFunction(value) ? reIsNative : reIsHostCtor;
      return pattern.test(toSource(value));
    }
    function baseIsTypedArray(value) {
      return isObjectLike(value) && isLength(value.length) && !!typedArrayTags[baseGetTag(value)];
    }
    function baseKeysIn(object) {
      if (!isObject(object)) {
        return nativeKeysIn(object);
      }
      var isProto = isPrototype(object), result = [];
      for (var key in object) {
        if (!(key == "constructor" && (isProto || !hasOwnProperty.call(object, key)))) {
          result.push(key);
        }
      }
      return result;
    }
    function baseMerge(object, source, srcIndex, customizer, stack) {
      if (object === source) {
        return;
      }
      baseFor(source, function(srcValue, key) {
        stack || (stack = new Stack());
        if (isObject(srcValue)) {
          baseMergeDeep(object, source, key, srcIndex, baseMerge, customizer, stack);
        } else {
          var newValue = customizer ? customizer(safeGet(object, key), srcValue, key + "", object, source, stack) : undefined;
          if (newValue === undefined) {
            newValue = srcValue;
          }
          assignMergeValue(object, key, newValue);
        }
      }, keysIn);
    }
    function baseMergeDeep(object, source, key, srcIndex, mergeFunc, customizer, stack) {
      var objValue = safeGet(object, key), srcValue = safeGet(source, key), stacked = stack.get(srcValue);
      if (stacked) {
        assignMergeValue(object, key, stacked);
        return;
      }
      var newValue = customizer ? customizer(objValue, srcValue, key + "", object, source, stack) : undefined;
      var isCommon = newValue === undefined;
      if (isCommon) {
        var isArr = isArray(srcValue), isBuff = !isArr && isBuffer(srcValue), isTyped = !isArr && !isBuff && isTypedArray(srcValue);
        newValue = srcValue;
        if (isArr || isBuff || isTyped) {
          if (isArray(objValue)) {
            newValue = objValue;
          } else if (isArrayLikeObject(objValue)) {
            newValue = copyArray(objValue);
          } else if (isBuff) {
            isCommon = false;
            newValue = cloneBuffer(srcValue, true);
          } else if (isTyped) {
            isCommon = false;
            newValue = cloneTypedArray(srcValue, true);
          } else {
            newValue = [];
          }
        } else if (isPlainObject(srcValue) || isArguments(srcValue)) {
          newValue = objValue;
          if (isArguments(objValue)) {
            newValue = toPlainObject(objValue);
          } else if (!isObject(objValue) || isFunction(objValue)) {
            newValue = initCloneObject(srcValue);
          }
        } else {
          isCommon = false;
        }
      }
      if (isCommon) {
        stack.set(srcValue, newValue);
        mergeFunc(newValue, srcValue, srcIndex, customizer, stack);
        stack["delete"](srcValue);
      }
      assignMergeValue(object, key, newValue);
    }
    function baseRest(func, start) {
      return setToString(overRest(func, start, identity), func + "");
    }
    var baseSetToString = !defineProperty ? identity : function(func, string) {
      return defineProperty(func, "toString", {
        configurable: true,
        enumerable: false,
        value: constant(string),
        writable: true
      });
    };
    function cloneBuffer(buffer, isDeep) {
      if (isDeep) {
        return buffer.slice();
      }
      var length = buffer.length, result = allocUnsafe ? allocUnsafe(length) : new buffer.constructor(length);
      buffer.copy(result);
      return result;
    }
    function cloneArrayBuffer(arrayBuffer) {
      var result = new arrayBuffer.constructor(arrayBuffer.byteLength);
      new Uint8Array(result).set(new Uint8Array(arrayBuffer));
      return result;
    }
    function cloneTypedArray(typedArray, isDeep) {
      var buffer = isDeep ? cloneArrayBuffer(typedArray.buffer) : typedArray.buffer;
      return new typedArray.constructor(buffer, typedArray.byteOffset, typedArray.length);
    }
    function copyArray(source, array) {
      var index = -1, length = source.length;
      array || (array = Array(length));
      while (++index < length) {
        array[index] = source[index];
      }
      return array;
    }
    function copyObject(source, props, object, customizer) {
      var isNew = !object;
      object || (object = {});
      var index = -1, length = props.length;
      while (++index < length) {
        var key = props[index];
        var newValue = customizer ? customizer(object[key], source[key], key, object, source) : undefined;
        if (newValue === undefined) {
          newValue = source[key];
        }
        if (isNew) {
          baseAssignValue(object, key, newValue);
        } else {
          assignValue(object, key, newValue);
        }
      }
      return object;
    }
    function createAssigner(assigner) {
      return baseRest(function(object, sources) {
        var index = -1, length = sources.length, customizer = length > 1 ? sources[length - 1] : undefined, guard = length > 2 ? sources[2] : undefined;
        customizer = assigner.length > 3 && typeof customizer == "function" ? (length--, 
        customizer) : undefined;
        if (guard && isIterateeCall(sources[0], sources[1], guard)) {
          customizer = length < 3 ? undefined : customizer;
          length = 1;
        }
        object = Object(object);
        while (++index < length) {
          var source = sources[index];
          if (source) {
            assigner(object, source, index, customizer);
          }
        }
        return object;
      });
    }
    function createBaseFor(fromRight) {
      return function(object, iteratee, keysFunc) {
        var index = -1, iterable = Object(object), props = keysFunc(object), length = props.length;
        while (length--) {
          var key = props[fromRight ? length : ++index];
          if (iteratee(iterable[key], key, iterable) === false) {
            break;
          }
        }
        return object;
      };
    }
    function getMapData(map, key) {
      var data = map.__data__;
      return isKeyable(key) ? data[typeof key == "string" ? "string" : "hash"] : data.map;
    }
    function getNative(object, key) {
      var value = getValue(object, key);
      return baseIsNative(value) ? value : undefined;
    }
    function getRawTag(value) {
      var isOwn = hasOwnProperty.call(value, symToStringTag), tag = value[symToStringTag];
      try {
        value[symToStringTag] = undefined;
        var unmasked = true;
      } catch (e) {}
      var result = nativeObjectToString.call(value);
      if (unmasked) {
        if (isOwn) {
          value[symToStringTag] = tag;
        } else {
          delete value[symToStringTag];
        }
      }
      return result;
    }
    function initCloneObject(object) {
      return typeof object.constructor == "function" && !isPrototype(object) ? baseCreate(getPrototype(object)) : {};
    }
    function isIndex(value, length) {
      var type = typeof value;
      length = length == null ? MAX_SAFE_INTEGER : length;
      return !!length && (type == "number" || type != "symbol" && reIsUint.test(value)) && value > -1 && value % 1 == 0 && value < length;
    }
    function isIterateeCall(value, index, object) {
      if (!isObject(object)) {
        return false;
      }
      var type = typeof index;
      if (type == "number" ? isArrayLike(object) && isIndex(index, object.length) : type == "string" && index in object) {
        return eq(object[index], value);
      }
      return false;
    }
    function isKeyable(value) {
      var type = typeof value;
      return type == "string" || type == "number" || type == "symbol" || type == "boolean" ? value !== "__proto__" : value === null;
    }
    function isMasked(func) {
      return !!maskSrcKey && maskSrcKey in func;
    }
    function isPrototype(value) {
      var Ctor = value && value.constructor, proto = typeof Ctor == "function" && Ctor.prototype || objectProto;
      return value === proto;
    }
    function nativeKeysIn(object) {
      var result = [];
      if (object != null) {
        for (var key in Object(object)) {
          result.push(key);
        }
      }
      return result;
    }
    function objectToString(value) {
      return nativeObjectToString.call(value);
    }
    function overRest(func, start, transform) {
      start = nativeMax(start === undefined ? func.length - 1 : start, 0);
      return function() {
        var args = arguments, index = -1, length = nativeMax(args.length - start, 0), array = Array(length);
        while (++index < length) {
          array[index] = args[start + index];
        }
        index = -1;
        var otherArgs = Array(start + 1);
        while (++index < start) {
          otherArgs[index] = args[index];
        }
        otherArgs[start] = transform(array);
        return apply(func, this, otherArgs);
      };
    }
    function safeGet(object, key) {
      if (key === "constructor" && typeof object[key] === "function") {
        return;
      }
      if (key == "__proto__") {
        return;
      }
      return object[key];
    }
    var setToString = shortOut(baseSetToString);
    function shortOut(func) {
      var count = 0, lastCalled = 0;
      return function() {
        var stamp = nativeNow(), remaining = HOT_SPAN - (stamp - lastCalled);
        lastCalled = stamp;
        if (remaining > 0) {
          if (++count >= HOT_COUNT) {
            return arguments[0];
          }
        } else {
          count = 0;
        }
        return func.apply(undefined, arguments);
      };
    }
    function toSource(func) {
      if (func != null) {
        try {
          return funcToString.call(func);
        } catch (e) {}
        try {
          return func + "";
        } catch (e) {}
      }
      return "";
    }
    function eq(value, other) {
      return value === other || value !== value && other !== other;
    }
    var isArguments = baseIsArguments(function() {
      return arguments;
    }()) ? baseIsArguments : function(value) {
      return isObjectLike(value) && hasOwnProperty.call(value, "callee") && !propertyIsEnumerable.call(value, "callee");
    };
    var isArray = Array.isArray;
    function isArrayLike(value) {
      return value != null && isLength(value.length) && !isFunction(value);
    }
    function isArrayLikeObject(value) {
      return isObjectLike(value) && isArrayLike(value);
    }
    var isBuffer = nativeIsBuffer || stubFalse;
    function isFunction(value) {
      if (!isObject(value)) {
        return false;
      }
      var tag = baseGetTag(value);
      return tag == funcTag || tag == genTag || tag == asyncTag || tag == proxyTag;
    }
    function isLength(value) {
      return typeof value == "number" && value > -1 && value % 1 == 0 && value <= MAX_SAFE_INTEGER;
    }
    function isObject(value) {
      var type = typeof value;
      return value != null && (type == "object" || type == "function");
    }
    function isObjectLike(value) {
      return value != null && typeof value == "object";
    }
    function isPlainObject(value) {
      if (!isObjectLike(value) || baseGetTag(value) != objectTag) {
        return false;
      }
      var proto = getPrototype(value);
      if (proto === null) {
        return true;
      }
      var Ctor = hasOwnProperty.call(proto, "constructor") && proto.constructor;
      return typeof Ctor == "function" && Ctor instanceof Ctor && funcToString.call(Ctor) == objectCtorString;
    }
    var isTypedArray = nodeIsTypedArray ? baseUnary(nodeIsTypedArray) : baseIsTypedArray;
    function toPlainObject(value) {
      return copyObject(value, keysIn(value));
    }
    function keysIn(object) {
      return isArrayLike(object) ? arrayLikeKeys(object, true) : baseKeysIn(object);
    }
    var merge = createAssigner(function(object, source, srcIndex) {
      baseMerge(object, source, srcIndex);
    });
    function constant(value) {
      return function() {
        return value;
      };
    }
    function identity(value) {
      return value;
    }
    function stubFalse() {
      return false;
    }
    module.exports = merge;
  });
  function parseObjectToQuery(obj, prefix) {
    let queryArray = [];
    Object.keys(obj).forEach(key => {
      const value = obj[key];
      const prefixedKey = prefix ? `${prefix}[${key}]` : key;
      if (Array.isArray(value)) {
        value.forEach((v, i) => {
          queryArray = [ ...queryArray, parseObjectToQuery(v, `${prefixedKey}[${i}]`) ];
        });
      } else if (typeof value === "object") {
        queryArray = [ ...queryArray, parseObjectToQuery(value, prefixedKey) ];
      } else {
        queryArray.push(`${prefixedKey}=${encodeURIComponent(value)}`);
      }
    });
    return queryArray.join("&");
  }
  function ransackSearch(search, currentData, settings) {
    return new Promise((resolve, reject) => {
      if (search.length < settings.minimumInputLength) {
        reject(`Please enter ${settings.minimumInputLength} or more characters`);
      }
      const defaultQuery = {
        order: settings.order,
        q: {
          groupings: [ settings.textQuery ],
          combinator: "and"
        }
      };
      const finalQuery = lodash_merge({}, defaultQuery, settings.query);
      const csrfTokenEl = document.querySelector('meta[name="csrf-token"]');
      const csrfToken = csrfTokenEl ? csrfTokenEl.getAttribute("content") : null;
      const queryString = parseObjectToQuery(finalQuery);
      fetch(`${settings.url}?${queryString}`, {
        method: "GET",
        headers: {
          "X-CSRF-TOKEN": csrfToken,
          Accept: "application/json",
          "Content-Type": "application/json"
        }
      }).then(response => response.json()).then(res => {
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
            text: resource[settings.displayName]
          };
        });
        resolve(options);
      });
    });
  }
  const classes$4 = [ "search-select-input", "search-select-filter-input", "ajax-filter-input" ];
  function settings$4(el) {
    const url = el.dataset.url;
    const fields = JSON.parse(el.dataset.fields);
    const predicate = el.dataset.predicate;
    const displayName = el.dataset.displayName;
    const responseRoot = el.dataset.responseRoot;
    const minimumInputLength = el.dataset.minimumInputLength;
    const order = el.dataset.order;
    const args = {
      url: url,
      fields: fields,
      predicate: predicate,
      displayName: displayName,
      responseRoot: responseRoot,
      minimumInputLength: minimumInputLength,
      order: order
    };
    return {
      events: {
        search: (search, currentData) => {
          args.textQuery = {
            m: "or"
          };
          args.fields.forEach(field => {
            if (field === "id") {
              args.textQuery[`${field}_eq`] = search;
            } else {
              args.textQuery[`${field}_${args.predicate}`] = search;
            }
          });
          return ransackSearch(search, currentData, args);
        }
      }
    };
  }
  var searchSelect = {
    settings: settings$4,
    classes: classes$4
  };
  const classes$3 = [ "simple-tags-input" ];
  function init$2(el) {
    el.multiple = true;
    if (!el.value) {
      el.value = null;
    }
  }
  function settings$3() {
    return {
      events: {
        addable: value => value
      }
    };
  }
  var simpleTagsSelect = {
    classes: classes$3,
    init: init$2,
    settings: settings$3
  };
  const classes$2 = [ "nested-level-input" ];
  function ajaxSearch(search, currentData, args) {
    args.fields.forEach(field => {
      if (field === "id") {
        args.textQuery[`${field}_eq`] = search;
      } else {
        args.textQuery[`${field}_${args.predicate}`] = search;
      }
    });
    if (!!args.parent) {
      args.query.q[`${args.parent}_eq`] = args.parentId;
    }
    args.query.q = {
      ...args.query.q,
      ...args.filters
    };
    return ransackSearch(search, currentData, args);
  }
  function collectionSearch(search, args, collection) {
    if (search.length < args.minimumInputLength) {
      return Promise.reject("Search term too short");
    }
    const data = JSON.parse(collection).map(item => ({
      value: String(item.id),
      text: item.text
    })).filter(item => item.text.toLowerCase().includes(search.toLowerCase()));
    return Promise.resolve(data);
  }
  function settings$2(el) {
    return {
      settings: {
        allowDeselect: true
      },
      events: {
        beforeOpen: () => {
          if (Number(el.dataset.minimumInputLength) === 0) {
            el.slim.search("");
          }
        },
        afterChange: () => {
          const {
            model,
            association
          } = el.dataset;
          const child = el.closest(".nested_level").parentNode.querySelector(`.nested_level [data-model=${model}][data-parent=${association}_id]`);
          if (child) {
            child.slim.setSelected();
            child.slim.setData([]);
            if (child.slim.events.afterChange) {
              child.slim.events.afterChange();
            }
            child.dispatchEvent(new Event("change"));
            child.dataset.parentId = el.value;
          }
        },
        search(search, currentData) {
          const args = {
            url: el.dataset.url,
            fields: el.dataset.fields && JSON.parse(el.dataset.fields) || {},
            predicate: el.dataset.predicate,
            filters: el.dataset.filters && JSON.parse(el.dataset.filters) || {},
            displayName: el.dataset.displayName,
            parent: el.dataset.parent,
            parentId: el.dataset.parentId,
            responseRoot: el.dataset.responseRoot,
            minimumInputLength: el.dataset.minimumInputLength,
            order: el.dataset.order,
            textQuery: {
              m: "or"
            },
            query: {
              q: {}
            }
          };
          if (el.dataset.collection) {
            return collectionSearch(search, args, el.dataset.collection);
          }
          return ajaxSearch(search, currentData, args);
        }
      }
    };
  }
  var nestedSelect = {
    settings: settings$2,
    classes: classes$2
  };
  const classes$1 = [ "selected-list-input" ];
  function settings$1(el) {
    const url = el.dataset.url;
    const fields = JSON.parse(el.dataset.fields);
    const predicate = el.dataset.predicate;
    const displayName = el.dataset.displayName;
    const method = el.dataset.method;
    const model = el.dataset.model;
    const prefix = `${model}_${method}`;
    const responseRoot = el.dataset.responseRoot;
    const minimumInputLength = el.dataset.minimumInputLength;
    const order = el.dataset.order;
    const args = {
      url: url,
      fields: fields,
      predicate: predicate,
      displayName: displayName,
      responseRoot: responseRoot,
      minimumInputLength: minimumInputLength,
      order: order
    };
    return {
      events: {
        afterChange: newVal => {
          const selectedItemsContainer = document.querySelector(`[id='${prefix}_selected_values']`);
          const itemName = `${model}[${method}][]`;
          newVal.forEach(data => {
            const itemId = `${prefix}_${data.value}`;
            if (document.querySelectorAll(`#${itemId}`).length > 0) {
              return;
            }
            const item = document.createElement("div");
            item.id = itemId;
            item.textContent = data.text;
            item.classList.add("selected-item");
            const hiddenInput = document.createElement("input");
            hiddenInput.name = itemName;
            hiddenInput.type = "hidden";
            hiddenInput.value = data.value;
            item.appendChild(hiddenInput);
            selectedItemsContainer.appendChild(item);
          });
        },
        search: (search, currentData) => {
          args.textQuery = {
            m: "or"
          };
          args.fields.forEach(field => {
            args.textQuery[`${field}_${predicate}`] = search;
          });
          return ransackSearch(search, currentData, args);
        }
      }
    };
  }
  function setupSelectedList(containerEl) {
    containerEl.addEventListener("click", event => {
      const item = event.target;
      if (item.classList.contains("selected-item")) {
        item.remove();
      }
    });
  }
  function setupSelectedLists(node) {
    node.querySelectorAll(".selected-list-container").forEach(setupSelectedList);
  }
  function mutationObserver() {
    return new MutationObserver(mutations => {
      mutations.forEach(mutation => {
        if (mutation.type === "childList") {
          mutation.addedNodes.forEach(node => {
            if (node instanceof Element) {
              setupSelectedLists(node);
            }
          });
        }
      });
    });
  }
  function init$1() {
    setupSelectedLists(document);
    mutationObserver();
  }
  var selectedListSelect = {
    settings: settings$1,
    classes: classes$1,
    init: init$1
  };
  const classes = [ "tags-input" ];
  function settings(el) {
    const model = el.dataset.model;
    const method = el.dataset.method;
    const prefix = `${model}_${method}`;
    const isRelation = el.dataset.relation === "true";
    const collection = el.dataset.collection ? JSON.parse(el.dataset.collection) : null;
    const parsedCollection = collection && collection.map(item => {
      const {
        id,
        ...rest
      } = item;
      return {
        ...rest,
        value: item.id,
        selected: !!item.selected
      };
    });
    function fillHiddenInput(values) {
      const hiddenInput = document.querySelector(`#${prefix}`);
      hiddenInput.value = values.map(val => val.value).join();
    }
    const events = {
      afterChange: newVal => {
        if (isRelation) {
          const selectedItemsContainer = document.querySelector(`#${prefix}_selected_values`);
          const itemName = `${model}[${method}][]`;
          selectedItemsContainer.innerHTML = "";
          newVal.forEach(data => {
            const itemId = `${prefix}_${data.value}`;
            if (document.querySelectorAll(`#${itemId}`).length > 0) {
              return;
            }
            const hiddenInput = document.createElement("input");
            hiddenInput.id = itemId;
            hiddenInput.name = itemName;
            hiddenInput.value = data.value;
            hiddenInput.type = "hidden";
            hiddenInput.textContent = data.text;
            selectedItemsContainer.appendChild(hiddenInput);
          });
        } else {
          fillHiddenInput(newVal);
        }
      }
    };
    if (!isRelation) {
      events.addable = value => value;
    }
    return {
      data: parsedCollection,
      events: events
    };
  }
  function init(el) {
    el.multiple = true;
  }
  var tagsSelect = {
    settings: settings,
    classes: classes,
    init: init
  };
  const SELECT_CLASS = "select:not(.default-select)";
  const SLIM_SELECT_CLASS = "select.slim-select";
  const selectTypes = {
    searchSelect: searchSelect,
    simpleTagsSelect: simpleTagsSelect,
    nestedSelect: nestedSelect,
    selectedListSelect: selectedListSelect,
    tagsSelect: tagsSelect
  };
  function setupSelect$1(el) {
    const emptyOption = el.querySelector('option[value=""]');
    if (emptyOption) emptyOption.dataset.placeholder = true;
    el.style.width = el.dataset.width || "80%";
    let settings = {
      select: el,
      settings: {
        placeholderText: "Select Value"
      }
    };
    Object.keys(selectTypes).forEach(type => {
      if (selectTypes[type].classes.some(className => el.classList.contains(className))) {
        settings = lodash_merge({}, settings, selectTypes[type].settings(el));
        if (selectTypes[type].init) {
          selectTypes[type].init(el);
        }
      }
    });
    const slim = new SlimSelect(settings);
    el.dataset.slimSelectId = slim.settings.id;
  }
  function initSelects(node = document) {
    if (document.querySelector("body").dataset.defaultSelect === "slim-select") {
      node.querySelectorAll(SELECT_CLASS).forEach(setupSelect$1);
    }
    node.querySelectorAll(SLIM_SELECT_CLASS).forEach(setupSelect$1);
  }
  const observer = new MutationObserver(mutations => {
    mutations.forEach(mutation => {
      if (mutation.type === "childList") {
        mutation.addedNodes.forEach(node => {
          if (node instanceof Element) {
            initSelects(node);
          }
        });
      }
    });
  });
  window.addEventListener("load", () => {
    initSelects();
    observer.observe(document.querySelector("body"), {
      attributes: false,
      childList: true,
      subtree: true
    });
  });
  var initializer$2 = function() {
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
  $(initializer$2);
  $(document).on("turbolinks:load turbo:load", initializer$2);
  var initializer$1 = function() {
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
  $(initializer$1);
  $(document).on("turbolinks:load turbo:load", initializer$1);
  var initializer = function() {
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
  $(initializer);
  $(document).on("turbolinks:load turbo:load", initializer);
  function updateTag(url, data) {
    return fetch(url, {
      method: "PATCH",
      headers: {
        "X-CSRF-TOKEN": document.querySelector('meta[name="csrf-token"]').content,
        Accept: "application/json",
        "Content-Type": "application/json"
      },
      body: JSON.stringify(data)
    });
  }
  function setupSelect(el) {
    if (el.slim) {
      el.slim.destroy();
    }
    return new SlimSelect({
      select: el,
      events: {
        afterClose: () => {
          const containerEl = el.closest(".tag-select-container");
          const selectContainer = containerEl.querySelector(".interactive-tag-select");
          const tagContainer = containerEl.querySelector(".interactive-tag");
          const model = tagContainer.dataset.model;
          const objectId = tagContainer.dataset.objectId;
          const field = tagContainer.dataset.field;
          if (el.value === tagContainer.dataset.value) {
            selectContainer.classList.add("select-container-hidden");
            containerEl.querySelector(".interactive-tag").classList.remove("interactive-tag-hidden");
          } else {
            const data = {
              id: objectId
            };
            data[model] = {};
            data[model][field] = el.value;
            updateTag(tagContainer.dataset.url, data).then(() => {
              const statusTag = tagContainer.querySelector(".status_tag");
              statusTag.innerText = el.selectedOptions[0].text;
              statusTag.classList.remove(tagContainer.dataset.value);
              statusTag.classList.add(el.value);
              tagContainer.dataset.value = el.value;
              selectContainer.dataset.value = el.value;
            }).catch(() => {
              const errorMsg = "Error: Update Unsuccessful";
              console.log(errorMsg);
            }).finally(() => {
              selectContainer.classList.add("select-container-hidden");
              containerEl.querySelector(".interactive-tag").classList.remove("interactive-tag-hidden");
            });
          }
        }
      }
    });
  }
  function setupInteractiveTag(containerEl) {
    const selectContainer = containerEl.querySelector(".interactive-tag-select");
    const slimSelect = setupSelect(selectContainer.querySelector("select"));
    const tag = containerEl.querySelector(".interactive-tag");
    tag.addEventListener("click", () => {
      selectContainer.classList.remove("select-container-hidden");
      tag.classList.add("interactive-tag-hidden");
      slimSelect.open();
    });
  }
  window.addEventListener("load", () => {
    document.querySelectorAll(".tag-select-container").forEach(setupInteractiveTag);
  });
});
