class Redson::Model
  def self.validates_presence_of(key)
  end
    
  def initialize
    @_redson_api_path = nil
    @_redson_state = {}
    @_redson_nested_keys = {}
    @_redson_observers = `jQuery({})`
    reset_errors
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
  
  def attributes
    @_redson_state
  end
  
  def reset_errors
    @_redson_server_validation_errors = {}
  end
  
  def errors
    @_redson_server_validation_errors
  end
  
  def valid?
    errors.empty?
  end
  
  def [](key)
    @_redson_state[key]
  end
  
  def api_path
    @_redson_api_path
  end
  
  def api_path=(path) 
    @_redson_api_path = path.end_with?(".json") ? path : "#{path}.json"
  end
  
  def save
    raise Redson::Error::ModelApiPathNotSetError.new(self) unless api_path
    HTTP.post(api_path, :payload => @_redson_state) do |response|
      if response.ok?
        reset_errors
      else
        @_redson_server_validation_errors = response.json
      end
    end
  end
  
  def parse_keys(nested_key)
    nested_key.split(/\]\[|\[|\]/)
  end
  
  def inspect
    "#{super}\napi_path: #{api_path}\nattributes:\n#{attributes.inspect}\nerrors:\n#{errors.inspect}"
  end
end