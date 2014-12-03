module Student
  class View < Redson::View
    def initialize_view_elements
    end
    
    def student_name_keyup_handler(event)
      p "student_name_keyup_handler"
    end
    
    def student_age_keyup_handler(event)
      p "student_age_keyup_handler"
    end
  end
end