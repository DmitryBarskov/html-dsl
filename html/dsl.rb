require_relative './html.rb'
require_relative './attributes.rb'
require_relative './element.rb'

module Html
  module Dsl
    module InstanceMethods
      def tag(tag_name, attributes_hash = {}, &block)
        attributes = ::Html::Attributes.new(attributes_hash)
        node = ::Html::Element.new(tag_name, attributes)
        result = node.instance_eval(&block) if block
        append_child(node)
      end

      Html::TAGS.each do |tag_name|
        define_method(tag_name) do |attributes_hash = {}, &block|
          tag(tag_name, attributes_hash, &block)
        end
      end
    end

    def self.included(receiver)
      receiver.send :include, InstanceMethods
    end
  end
end
