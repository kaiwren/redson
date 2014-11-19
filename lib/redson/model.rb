class Redson::Model
  def initialize(view)
    @view = view
    @state = {}
  end
  
  def []=(key, value)
    @state[key.to_s] = value
  end
  
  def [](key)
    @state[key]
  end
end