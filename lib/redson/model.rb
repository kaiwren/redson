class Redson::Model
  def self.validates_presence_of(key)
  end
  
  def initialize(view)
    @view = view
    @state = {}
  end
  
  def api_url
  end
  
  def []=(key, value)
    @state[key.to_s] = value
  end
  
  def [](key)
    @state[key]
  end
end