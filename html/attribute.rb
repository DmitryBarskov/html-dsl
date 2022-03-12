module Html
  class Attribute
    def self.instantiate(name, value)
      if name.to_sym == :style && value.is_a?(::Hash)
        Html::Attribute::Style.new(name, value)
      elsif name.to_sym == :data && value.is_a?(::Hash)
        Html::Attribute::Data.new(name, value)
      elsif name.to_sym == :class && value.is_a?(::Hash)
        Html::Attribute::ClassAsHash.new(name, value)
      elsif name.to_sym == :class && value.is_a?(::Enumerable)
        Html::Attribute::ClassAsArray.new(name, value)
      else
        Html::Attribute::String.new(name, value)
      end
    end

    class String
      def initialize(name, value)
        @name = name
        @value = value
      end

      def to_s
        if @value == true
          @name.to_s
        elsif @value == false
          ""
        else
          "#{@name}=\"#{@value}\""
        end
      end
    end

    class Style
      def initialize(name, value)
        @name = name
        @value = value
      end

      def to_s
        styles = @value.map do |name, value|
          "#{name}: #{value};"
        end
        "#{@name}=\"#{styles.join(" ")}\""
      end
    end

    class Data
      def initialize(name, value)
        @name = name
        @value = value
      end

      def to_s
        attributes = @value.map do |name, value|
          Html::Attribute::String.new("#{@name}-#{name}", value).to_s
        end
        attributes.join(" ").strip
      end
    end

    class ClassAsHash
      def initialize(name, value)
        @name = name
        @value = value
      end

      def to_s
        classes = @value.select { _2 }.keys
        ClassAsArray.new(@name, classes).to_s
      end
    end

    class ClassAsArray
      def initialize(name, value)
        @name = name
        @value = value
      end

      def to_s
        "#{@name}=\"#{@value.join(" ")}\""
      end
    end
  end
end
