module Hello
  module Echo
    class View < Redson::View
      def load_view_elements
        @output_element = this_element.find!(".output")
      end
      
      def input_keyup_handler(event)
        @output_element.text(model['input'])
      end
    end
  end
end