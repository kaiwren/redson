module Hello
  module Echo
    class View < Redson::View
      def initialize_view_elements
        @output_element = find_element!(".output")
      end
      
      def input_keyup_handler(event)
        @output_element.text(model['input'])
      end
    end
  end
end