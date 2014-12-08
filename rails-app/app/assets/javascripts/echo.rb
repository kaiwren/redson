module Echo
  class Widget < Redson::Widget
    set_target_element_matcher '#echoes .echo'
    bind '.input', :to => 'input', :notify_on => 'keyup', :notification_handler => :input_keyup_handler    
  end
  
  class View < Redson::View
    def initialize_view_elements
      @output_element = find_element!(".output")
    end
    
    def input_keyup_handler(event)
      @output_element.text(model['input'])
    end
  end
  
  class Model < Redson::Model
  end
end