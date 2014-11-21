module Student
  class Model < Redson::Model
    validates_presence_of  'name'
    
  end
end