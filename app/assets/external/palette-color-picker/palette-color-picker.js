/**
 * JQuery Palette Color Picker v1.01 by Carlos Cabo ( @putuko )
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
        position: 'upside',  // upside | downside
        insert: 'before',    // default
        clear_btn: 'first',  // default
        timeout: 2000        // default
      };

    // Init
    plugin.init = function() {
      // Extand settings with user options
      plugin.settings = $.extend({}, defaults, options);

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


        // console.log(key + '===' +  current_value + ' - > '+(key === current_value)+' - t -'+(typeof key)+' '+(typeof current_value));
        if ( key === current_value ) {
          $sw.addClass('active');
          $button.css('background', col);
        }

        $sw.appendTo( $bubble );
      });

      // Create clear button
      var
        $clear_btn = $('<span>').addClass('swatch clear').attr('title', 'Clear selection');
      if (plugin.settings.clear_btn === 'last') {
        $clear_btn.addClass('last').appendTo( $bubble );
      } else {
        $clear_btn.prependTo( $bubble );
      }

      // Public
      plugin.destroy = function() {
        $button.remove();
        $.removeData( $el[0] );
      };

      // Events
      // Simple click
      $button.append( $bubble ).on('click', function(){
        var $b = $( this );
        $b.toggleClass('active').find('.'+ns+'-bubble').fadeToggle();
        if ($b.hasClass('active')) {
          clearTimeout(plugin.timer);
          plugin.timer = setTimeout(function(){
            $b.trigger('pcp.fadeout');
          }, plugin.settings.timeout);
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
      .on('click', 'span.swatch', function(e){
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
        $( '[name="'+$button.attr('data-target')+'"]' ).val( name );
      })['insert'+plugin.settings.insert]( $el );

      // Upside / downside, default is upside
      if ( plugin.settings.position === 'downside' || ($el.offset().top) + 20 < $bubble.outerHeight() ) {
        $bubble.addClass('downside');
      }

    };

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
