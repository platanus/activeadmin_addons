module ActiveAdminAddons
  class ImageBuilder < CustomBuilder
    def render
      return nil if data.nil?
      raise "you need to pass a paperclip image attribute" unless data.respond_to?(:url)
      style = options.fetch(:style, :original)
      context.image_tag(data.url(style)) if data.file?
    end
  end
end

ActiveAdminAddons::ImageBuilder.create_view_methods
