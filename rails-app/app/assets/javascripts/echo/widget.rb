module Echo
  class Widget < Redson::Widget
    set_target_element_matcher '#echoes .echo'
    bind '.input', :to => 'input', :notify_on => 'keyup', :notification_handler => :input_keyup_handler    
  end
end