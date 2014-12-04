module Student
  class Widget < Redson::Form::Widget
    disable_template!
    
    bind "input[name='student[name]']", :to => 'student[name]', :notify_on => 'keyup', :notification_handler => :student_name_keyup_handler
    bind "input[name='student[age]']", :to => 'student[age]', :notify_on => 'keyup', :notification_handler => :student_age_keyup_handler
  end
end