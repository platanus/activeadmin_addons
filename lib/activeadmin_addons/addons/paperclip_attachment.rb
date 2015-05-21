module ActiveAdminAddons
  module PaperclipAttachment
    class << self
      KNOWN_EXTENSIONS = %w{
        3gp 7z ace ai aif aiff amr asf asx bat bin bmp bup cab cbr cda cdl cdr chm
        dat divx dll dmg doc docx dss dvf dwg eml eps exe fla flv gif gz hqx htm html
        ifo indd iso jar jpeg jpg lnk log m4a m4b m4p m4v mcd mdb mid mov mp2 mp4
        mpeg mpg msi mswmm ogg pdf png pps ppt pptx ps psd pst ptb pub qbb qbw qxd ram
        rar rm rmvb rtf sea ses sit sitx ss swf tgz thm tif tmp torrent ttf txt
        vcd vob wav wma wmv wps xls xlsx xpi zip
      }

      def icon_for_filename filename
        for_ext File.extname(filename)
      end

      def for_ext file_extension
        ext = file_extension.start_with?('.') ? file_extension[1..-1] : file_extension
        ext.downcase!
        ext = "unknown" unless KNOWN_EXTENSIONS.include?(ext)
        "fileicons/file_extension_#{ext}.png"
      end

      def link(context, model, attribute, options)
        options[:truncate] = options.fetch(:truncate, true)
        doc = model.send(attribute)
        raise 'you need to pass a paperclip attribute' unless doc.respond_to?(:url)

        icon = icon_for_filename(doc.original_filename)
        icon_img = context.image_tag(icon, width: "20", height: "20", style: "margin-right: 5px; vertical-align: middle;")
        file_name = (options[:truncate] == true) ? context.truncate(doc.original_filename) : doc.original_filename
        label_text = options.fetch(:label, file_name)
        label = context.content_tag(:span) do
          context.concat(icon_img)
          context.safe_concat(label_text)
        end

        context.link_to(label, doc.url, { target: "_blank" }) if doc.exists?
      end
    end
  end

  module ::ActiveAdmin
    module Views
      class TableFor
        def attachment_column(attribute, options = {})
          column(attribute) { |model| PaperclipAttachment.link(self, model, attribute, options) }
        end
      end
      class AttributesTable
        def attachment_row(attribute, options = {})
          row(attribute) { |model| PaperclipAttachment.link(self, model, attribute, options) }
        end
      end
    end
  end
end
