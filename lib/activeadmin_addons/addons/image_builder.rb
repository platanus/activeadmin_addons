module ActiveAdminAddons
  class ImageBuilder < CustomBuilder
    def render
      return nil if data.nil?

      if Object.const_defined?('Shrine::UploadedFile') && data.is_a?(Shrine::UploadedFile)
        shrine_data
      else
        raise "you need to pass a shrine image attribute"
      end
    end

    private

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
