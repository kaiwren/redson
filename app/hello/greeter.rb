module Hello
  class Greeter < Redson::Widget
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