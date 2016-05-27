module ActiveAdminAddons
  class PaperclipAttachmentBuilder < CustomBuilder
    KNOWN_EXTENSIONS = %w{
      3gp 7z ace ai aif aiff amr asf asx bat bin bmp bup cab cbr cda cdl cdr chm
      dat divx dll dmg doc docx dss dvf dwg eml eps exe fla flv gif gz hqx htm html
      ifo indd iso jar jpeg jpg lnk log m4a m4b m4p m4v mcd mdb mid mov mp2 mp3 mp4
      mpeg mpg msi mswmm ogg pdf png pps ppt pptx ps psd pst ptb pub qbb qbw qxd ram
      rar rm rmvb rtf sea ses sit sitx ss swf tgz thm tif tmp torrent ttf txt
      vcd vob wav wma wmv wps xls xlsx xpi zip
    }

    def icon_for_filename(filename)
      for_ext File.extname(filename.to_s)
    end

    def for_ext(file_extension)
      ext = file_extension.start_with?('.') ? file_extension[1..-1] : file_extension
      ext.downcase!
      ext = "unknown" unless KNOWN_EXTENSIONS.include?(ext)
      "fileicons/file_extension_#{ext}.png"
    end

    def build_label
      icon = icon_for_filename(data.original_filename)
      style = { width: "20", height: "20", style: "margin-right: 5px; vertical-align: middle;" }
      icon_img = context.image_tag(icon, style)
      file_name = data.original_filename
      file_name = context.truncate(data.original_filename) if options[:truncate] == true
      label_text = options.fetch(:label, file_name)

      context.content_tag(:span) do
        context.concat(icon_img)
        context.safe_concat(label_text)
      end
    end

    def render
      raise 'you need to pass a paperclip attribute' unless data.respond_to?(:url)
      options[:truncate] = options.fetch(:truncate, true)
      return nil unless data.exists?
      context.link_to(build_label, data.url, target: "_blank", class: "attachment-link")
    end
  end

  module ::ActiveAdmin
    module Views
      class TableFor
        def attachment_column(*args, &block)
          column(*args) { |model| PaperclipAttachmentBuilder.render(self, model, *args, &block) }
        end
      end
      class AttributesTable
        def attachment_row(*args, &block)
          row(*args) { |model| PaperclipAttachmentBuilder.render(self, model, *args, &block) }
        end
      end
    end
  end
end
