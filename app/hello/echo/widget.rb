module Hello
  module Echo
    class Widget < Redson::Widget
      set_target_element_matcher '#echoes .echo'
      bind '.input', :to => 'input', :update_on => 'keyup', :notify => :input_changed_handler
    
      def initialize
        super
        @output_element = view.this_element.find!(".output")
      end

      def input_changed_handler(event)
        @output_element.text(@bound_values['input'])
      end
    end
  end
end