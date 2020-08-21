/*!
 * JQuery Palette Color Picker v1.13 by Carlos Cabo ( @putuko )
 * https://github.com/carloscabo/jquery-palette-color-picker
 */
(function($) {
  // La magia aquí
  'use strict';

  // Public core
  $.paletteColorPicker = function( el, options ) {
    var
      ns = 'palette-color-picker', // Base attr / class
      $el = $(el),
      plugin = this,
      timer = null,
      current_value = $el.val(),
      target = $el.attr('name'),
      $button = $('<div>')
                  .addClass(ns+'-button')
                  .attr('data-target', target),
      $bubble = $('<div>')
                  .addClass(ns+'-bubble'),

      // Final settings will be stored here
      settings = {},

      // Default settings
      defaults = {
        custom_class: null,
        colors: null,
        position: 'upside',   // upside | downside
        insert: 'before',     // default
        clear_btn: 'first',   // default
        timeout: 2000,        // default
        set_background: false, // default
        close_all_but_this: false // default
      },

      click_handler = ('ontouchstart' in document.documentElement ? 'touchstart click' : 'click');

    // Init
    plugin.init = function() {
      // Extand settings with user options
      plugin.settings = $.extend({}, defaults, options);

      // If input has not value add it
      var
        val = $el.attr('value');
      if (typeof val === typeof undefined || val === false) {
        val = '';
        $el.attr('value', val);
      }

      // Backup initial value
      $el.attr('data-initialvalue', $el.attr('value') );

      // If color were not passed as options get them from data-palette attribute
      if (plugin.settings.colors === null) {
        plugin.settings.colors = $el.data('palette');
      }

      // If color is array of string, convert to obj
      if (typeof plugin.settings.colors[0] === 'string') {
        plugin.settings.colors = $.map(plugin.settings.colors, function(el, idx) {
          var b = {}; b[el] = el; return b;
        });
      }

      // Capitalize position
      plugin.settings.insert = plugin.settings.insert.charAt(0).toUpperCase() + plugin.settings.insert.slice(1);

      // Add custom_class
      if (plugin.settings.custom_class) {
        $bubble.addClass(plugin.settings.custom_class);
      }

      // Create color swatches
      $.each( plugin.settings.colors, function( idx, obj ) {
        var
          key = Object.keys( obj )[0],
          col = obj[key],
          $sw = $('<span>').addClass('swatch')
            .attr({
              'title': key,
              'data-color': col,
              'data-name': key
            }).css('background-color', col);

        if ( key === current_value ) {
          $sw.addClass('active');
          $button.css('background', col);
        }

        $sw.appendTo( $bubble );
      });

      // Create clear button if not null
      if (plugin.settings.clear_btn !== null) {
        var
        $clear_btn = $('<span>').addClass('swatch clear').attr('title', 'Clear selection');
        if (plugin.settings.clear_btn === 'last') {
          $clear_btn.addClass('last').appendTo( $bubble );
        } else {
          $clear_btn.prependTo( $bubble );
        }
      }

      // Public
      plugin.destroy = function() {
        $button.remove();
        $.removeData( $el[0] );
      };

      // Clears all
      plugin.clear = function() {
        $bubble.find('.active').removeClass('active');
        $button.removeAttr('style');
        $el.val('');
      };

      // Reset to initial value
      plugin.reset = function() {
        // Dont had initial value
        if ( $el.attr('data-initialvalue') === '' ) {
          plugin.clear();
        } else {
          // Had initial value
          var iv = $el.attr('data-initialvalue');
          $bubble.find('[data-name="'+iv+'"]').trigger('click');
        }
      };

      // reload value after it has been changed programatically
      plugin.reload = function() {

        var newVal = $el.val();
        if (  newVal === '' || typeof newVal === typeof undefined || newVal === false ) {
          // Doesn't have the value to load so loading initial value
          plugin.reset();
        } else {
          // setting the value to new value
          if($bubble.find('[data-name="'+newVal+'"]').length) {
            // value will only be set if the color exists in options
            $bubble.find('[data-name="'+newVal+'"]').trigger('click');
          } else {
            // setting to the initial value if color does not exists
            plugin.reset();
          }
        }
      };

      // Events
      // Simple click
      $button.append( $bubble ).on( click_handler, function(e){
        e.preventDefault();
        e.stopPropagation();
        var $b = $( this );

        // don't close on clicking the bubble
        if (!$(e.target).hasClass(ns+'-bubble')) {

          // Call the callback, if set
          if (typeof plugin.settings.onbeforeshow_callback === 'function') {
            plugin.settings.onbeforeshow_callback(this);
          }

          $b.toggleClass('active');
          var $current_bubble = $b.find('.'+ns+'-bubble');
          // Forces hiding other bubbles
          if (plugin.settings.close_all_but_this) {
            $('.'+ns+'-bubble').not($current_bubble).fadeOut();
          }
          $current_bubble.fadeToggle();

          if ($b.hasClass('active')) {
            clearTimeout(plugin.timer);
            plugin.timer = setTimeout(function(){
              $b.trigger('pcp.fadeout');
            }, plugin.settings.timeout);
          }
        }
      })
      // Fade timer
      .on('pcp.fadeout', function() {
        $( this ).removeClass('active').find('.'+ns+'-bubble').fadeOut();
      })
      // Enter bubble
      .on('mouseenter', '.'+ns+'-bubble', function() {
        clearTimeout(plugin.timer);
      })
      // Leave bubble
      .on('mouseleave', '.'+ns+'-bubble', function() {
        plugin.timer = setTimeout(function(){
          $button.trigger('pcp.fadeout');
        }, plugin.settings.timeout);
      })
      // Click on swatches
      .on(click_handler, '.'+ns+'-bubble span.swatch', function(e){
        e.preventDefault();
        e.stopPropagation();
        var
          col = $( this ).attr('data-color'),
          name = $( this ).attr('data-name'),
          // Select all button in document with same data target to keep them synconized
          $button = $('.'+ns+'-button[data-target="' + $( this ).closest( '.'+ns+'-button' ).attr('data-target') + '"]'),
          $bubble = $( this ).closest( '.'+ns+'-bubble' );

        // console.log('.'+ns+'-button [data-target="' + $( this ).closest( '.'+ns+'-button' ).attr('data-target') + '"]');
        $bubble.find('.active').removeClass('active');

        // Set background on color
        // User clicked in the clear swatch
        if ( $(e.target).is('.clear') ) {
          $button.removeAttr('style');
          col = '';
        } else {
          $(this).addClass('active');
          $button.css('background', col);
        }

        // Call the callback, if set
        if (typeof plugin.settings.onchange_callback === "function") {
          plugin.settings.onchange_callback(col);
        }

        if( plugin.settings.set_background === false ) {
          $('[name="' + $button.attr('data-target') + '"]').val(name);
        } else {
          $('[name="' + $button.attr('data-target') + '"]').css({'background-color' : col});
        }
      })['insert'+plugin.settings.insert]( $el );

      // Upside / downside, default is upside
      if ( plugin.settings.position === 'downside' || ($el.offset().top) + 20 < $bubble.outerHeight() ) {
        $bubble.addClass('downside');
      }

    };

    // Close on clicking outside the palette
    $('body').on(click_handler,function(event) {
      if (!$(event.target).hasClass(ns+'-button')) {
        $( $button ).removeClass('active').find('.'+ns+'-bubble').fadeOut();
      }
    });

    // Start
    plugin.init();
  };

  // add the plugin to the jQuery.fn object
  $.fn.paletteColorPicker = function(options) {
    return this.each(function() {
      if (typeof $(this).data('paletteColorPickerPlugin') === 'undefined') {
        $(this).data('paletteColorPickerPlugin', new $.paletteColorPicker(this, options));
      }
    });
  };

})(jQuery);

// Sample usage
// $(function() {
//   $('[data-palette-color-picker]').paletteColorPicker();
// });
