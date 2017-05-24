module Jekyll
  class RenderDownloadTag < Liquid::Tag

    require "shellwords"

    def initialize(tag_name, text, tokens)
      super
      @text = text.strip.shellsplit
    end

    def render(context)
      cdn = context.registers[:site].config["cdn"]
      path = @text[0]
      filename = @text[1]

      "<a href=\"#{cdn}#{path}\" class=\"btn btn-info\"><i class=\"icon-download icon-white\"></i> Download #{filename}</a>"
    end
  end
end

Liquid::Template.register_tag('download', Jekyll::RenderDownloadTag)