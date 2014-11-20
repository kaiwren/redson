module Student
  class Widget < Redson::Widget
    disable_template!
    bind "input[name='student[name]']", :to => 'name', :notify_on => 'keyup', :notification_handler => :name_keyup_handler
  end
end