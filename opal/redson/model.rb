class Redson::Model
  def self.validates_presence_of(key)
  end
  
  attr_accessor :api_path
  
  def initialize
    @_redson_state = {}
    @_redson_nested_keys = {}
  end
    
  def []=(key, value)
    if @_redson_nested_keys.include?(key) 
      keys = @_redson_nested_keys[key]
      @_redson_state[keys[0]] ||= {}
      @_redson_state[keys[0]][keys[1]] = value
    elsif `/\[/.test(#{key})`
      keys = parse_keys(key)
      @_redson_nested_keys[key] = keys
      @_redson_state[keys[0]] ||= {}
      @_redson_state[keys[0]][keys[1]] = value
    else
      @_redson_state[key] = value
    end
  end
  
  def [](key)
    @_redson_state[key]
  end
  
  def save
    HTTP.post(api_path, :payload => @_redson_state) do |response|
      p response
    end
  end
  
  def parse_keys(nested_key)
    nested_key.split(/\]\[|\[|\]/)
  end
  
  def inspect
    "#{super} #{@_redson_state.inspect} #{api_path}"
  end
end