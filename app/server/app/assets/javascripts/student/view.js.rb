module Student
  class View < Redson::View
    def initialize_view_elements
      @name_error_element = find_element!(".name.error")
    end
    
    def name_keyup_handler(event)
      puts model['name']
    end
  end
end