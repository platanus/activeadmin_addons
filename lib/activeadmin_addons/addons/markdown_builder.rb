require 'redcarpet'

module ActiveAdminAddons
  class MarkdownBuilder < CustomBuilder
    def render
      return if data.blank?

      Redcarpet::Markdown.new(renderer, extensions).render(@data).html_safe
    end

    private

    def extensions_default
      { fenced_code_blocks: true,
        no_intra_emphasis: true,
        strikethrough: true,
        superscript: true }
    end

    def renderer_options_default
      { filter_html: true, hard_wrap: true }
    end

    def extensions
      @extensions ||= extensions_default.merge(options[:extensions] || {})
    end

    def render_options
      @render_options ||= renderer_options_default.merge(options[:render_options] || {})
    end

    def renderer
      @renderer ||= Redcarpet::Render::HTML.new(render_options)
    end
  end
end

ActiveAdminAddons::MarkdownBuilder.create_view_methods
