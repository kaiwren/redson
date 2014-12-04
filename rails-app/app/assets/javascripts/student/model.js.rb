module Student
  class Model < Redson::Form::Model
    validates_presence_of  'name'
    
  end
end