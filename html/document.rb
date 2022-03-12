module Html
  class Document
    def initialize(&block)
      instance_eval(&block)
    end

    def append_child(root)
      raise "Document must have only one child element!" if @root

      @root = root
    end

    def to_s
      "<!DOCTYPE html>#{@root}"
    end
  end
end
