module Hello
  class Greeter < Opal001::Widget
    def initialize(target_element, template_element)
      super(target_element, template_element)
      @input_element = @this_element.find(".o-input")
      @output_element = @this_element.find(".o-output")
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

require "greeter/model"
require "greeter/view"