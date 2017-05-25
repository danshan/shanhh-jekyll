module Jekyll
  class RenderImageTag < Liquid::Tag

    require "shellwords"

    def initialize(tag_name, text, tokens)
      super
      @text = text.strip.shellsplit
    end

    def render(context)
      cdn = context.registers[:site].config["cdn"]
      img = context.registers[:site].config["img"]
      img_origin = context.registers[:site].config["img_origin"]

      "<figure><a href=\"#{cdn}#{@text[0]}#{img_origin}\" class=\"image-popup\"><img src=\"#{cdn}#{@text[0]}#{img}\"></a></figure><figcaption>#{@text[1]}</figcaption>"
    end
  end
end

Liquid::Template.register_tag('img', Jekyll::RenderImageTag)