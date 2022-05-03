module ActiveAdminAddons
  class ImageBuilder < CustomBuilder
    def render
      return nil if data.nil?

      if Object.const_defined?('Paperclip::Attachment') && data.is_a?(Paperclip::Attachment)
        paperclip_data
      elsif Object.const_defined?('Shrine::UploadedFile') && data.is_a?(Shrine::UploadedFile)
        shrine_data
      else
        raise "you need to pass a paperclip or shrine image attribute"
      end
    end

    private

    def paperclip_data
      style = options.fetch(:style, :original)
      context.image_tag(data.url(style)) if data.file?
    end

    def shrine_data
      image_options = options[:image_options].presence || {}
      if options[:style] && derivatives.include?(options[:style])
        context.image_tag(model.send("#{attribute}_url", options[:style]), image_options)
      else
        context.image_tag(data.url, image_options)
      end
    end

    def derivatives
      model.send("#{attribute}_derivatives")
    end
  end
end

ActiveAdminAddons::ImageBuilder.create_view_methods
