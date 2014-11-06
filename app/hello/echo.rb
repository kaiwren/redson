require File.expand_path(File.join(File.dirname(__FILE__), "echo", "model"))
require File.expand_path(File.join(File.dirname(__FILE__), "echo", "view"))

module Hello
  class Echo < Redson::Widget
    target_element_matcher '#greeter'
    bind '.input', :to => 'input', :update_on => 'keyup', :notify => :input_changed_handler
    
    def initialize(target_element)
      super(target_element)
      @output_element = @this_element.find!(".output")
    end

    def input_changed_handler(event)
      @output_element.text(@bound_values['input'])
    end
  end
end