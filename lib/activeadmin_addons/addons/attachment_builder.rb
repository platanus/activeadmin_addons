module ActiveAdminAddons
  class AttachmentBuilder < CustomBuilder
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
      ext = file_extension.start_with?(".") ? file_extension[1..-1] : file_extension
      ext.downcase!
      ext = "unknown" unless KNOWN_EXTENSIONS.include?(ext)
      "fileicons/file_extension_#{ext}.png"
    end

    def build_label
      icon = icon_for_filename(file.original_filename)
      style = { width: "20", height: "20", style: "margin-right: 5px; vertical-align: middle;" }
      icon_img = context.image_tag(icon, style)
      text = label_text

      context.content_tag(:span) do
        context.concat(icon_img)
        context.safe_concat(text)
      end
    end

    def label_text
      label = if options[:label].nil?
                file.original_filename
              elsif options[:label].is_a? Proc
                options[:label].call(model).to_s
              else
                options[:label].to_s
              end

      options[:truncate] ? context.truncate(label) : label
    end

    def render
      raise "you need to pass a paperclip attribute" unless file.respond_to?(:url)
      options[:truncate] = options.fetch(:truncate, true)
      return nil unless file.file?
      context.link_to(build_label, file.url, target: "_blank", class: "attachment-link")
    end

    def file
      model.send(attribute)
    end
  end
end

ActiveAdminAddons::AttachmentBuilder.create_view_methods
