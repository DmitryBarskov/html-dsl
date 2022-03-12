module Html
  class Element
    def initialize(tag_name, attributes = nil, &block)
      @tag_name = tag_name
      @attributes = attributes
      @children = []
      instance_eval(&block) if block
    end

    def append_child(html)
      @children << html
    end
    alias text append_child

    def to_s
      starting_line = "#{@tag_name} #{@attributes.to_s}".strip
      children_html = @children.join

      if children_html.empty?
        "<#{starting_line} />"
      else
        "<#{starting_line}>#{children_html}</#{@tag_name}>"
      end
    end
  end
end
