module Jekyll
  class RenderImageTag < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @text = text.strip
    end

    def render(context)
      cdn = context.registers[:site].config["cdn"]
      img = context.registers[:site].config["img"]
      img_origin = context.registers[:site].config["img_origin"]

      "<figure><a href=\"#{cdn}#{@text}#{img_origin}\"><img src=\"#{cdn}#{@text}#{img}\"></a></figure><figcaption></figcaption>"
    end
  end
end

Liquid::Template.register_tag('img', Jekyll::RenderImageTag)