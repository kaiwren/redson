module Student
  class View < Redson::Form::View
    def initialize_view_elements
      super
    end
    
    def student_name_keyup_handler(event)
      p "student_name_keyup_handler"
      p model
    end
    
    def student_age_keyup_handler(event)
      p "student_age_keyup_handler"
    end
  end
end