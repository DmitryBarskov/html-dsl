require_relative './attribute.rb'

module Html
  class Attributes
    def initialize(attributes)
      @attributes = attributes
    end

    def to_s
      html_attributes = @attributes.map do |name, value|
        Html::Attribute.instantiate(name, value).to_s
      end
      html_attributes.join(" ").strip
    end
  end
end
