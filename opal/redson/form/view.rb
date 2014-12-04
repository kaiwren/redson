module Redson
  module Form
    class View < Redson::View
      def initialize_view_elements
        raise "#{this_element.inspect} is not a form element" unless this_element.is('form')
        disable_submit_event_propagation!
        write_current_view_state_to_model
        trigger_save_on_submit
      end
      
      def trigger_save_on_submit
        %x{
          self.$this_element().on('submit', function(event) {
            self.$model().$save();
          });
        }
      end
      
      def write_current_view_state_to_model
        input_elements.each do |element|
          model[element['name']] = element.value
        end
        model.api_path = self.action_attribute
      end
      
      def disable_submit_event_propagation!
        %x{
          self.$this_element().on('submit', function(event) {
            event.preventDefault();
          });
        }
      end
      
      def action_attribute
        this_element['action']
      end
  
      def submit_element
        this_element.find('input[type=submit]')
      end
  
      def input_elements
        this_element.find('input[type!=submit]')
      end
    end
  end
end