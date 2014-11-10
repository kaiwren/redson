require File.expand_path(File.join(File.dirname(__FILE__), "echo", "model"))
require File.expand_path(File.join(File.dirname(__FILE__), "echo", "view"))

module Hello
  class Echo < Redson::Widget
    set_target_element_matcher '#echo'
    bind '.input', :to => 'input', :update_on => 'keyup', :notify => :input_changed_handler
    
    def initialize
      super
      @output_element = @this_element.find!(".output")
    end

    def input_changed_handler(event)
      @output_element.text(@bound_values['input'])
    end
  end
end