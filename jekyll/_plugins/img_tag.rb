module Jekyll
  class RenderImageTag < Liquid::Tag
    safe false

    def initialize(tag_name, text, tokens)
      super
      @text = text
    end

    def render(context)
      "<figure><a href=\"#{site.cdn}#{@text}#{site.img_origin}\"><img src=\"#{site.cdn}#{@text}{{ site.img }}\"></a></figure>"
    end
  end
end

Liquid::Template.register_tag('img', Jekyll::RenderImageTag)