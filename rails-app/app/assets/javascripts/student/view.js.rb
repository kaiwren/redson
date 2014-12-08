module Student
  class View < Redson::Form::View
    def student_name_keyup_handler(event)
      puts "student_name_keyup_handler called after model was updated by view"
    end
    
    def student_age_keyup_handler(event)
      puts "student_age_keyup_handler called after model was updated by view"
    end
  end
end