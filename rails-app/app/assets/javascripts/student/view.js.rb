module Student
  class View < Redson::Form::View
    def initialize_view_elements
      super
    end
    
    def model_created_handler(event)
      p :model_created_handler
    end

    def model_updated_handler(event)
      p :model_updated_handler
    end

    def model_unprocessable_entity_handler(event)
      p :model_unprocessable_entity_handler
    end
    
    def student_name_keyup_handler(event)
      p "student_name_keyup_handler"
    end
    
    def student_age_keyup_handler(event)
      p "student_age_keyup_handler"
    end
  end
end