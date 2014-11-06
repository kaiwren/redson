require File.expand_path(File.join(File.dirname(__FILE__), "echo", "model"))
require File.expand_path(File.join(File.dirname(__FILE__), "echo", "view"))

module Hello
  class Echo < Redson::Widget
    target_element_matcher '#greeter'
    
    def initialize(target_element)
      super(target_element)
      @input_element = @this_element.find!(".input")
      @output_element = @this_element.find!(".output")
      @input = ""

      @input_element.on(:keyup) do |event|
        input_changed_handler(event)
      end
    end

    def input_changed_handler(event)
      @input = @input_element.value
      @output_element.text(@input)
    end
  end
end