class Redson::Model
  include Redson::Observable
  
  def self.validates_presence_of(key)
  end
    
  def initialize
    @_redson_api_path = nil
    @_redson_state = {}
    @_redson_nested_keys = {}
    @_redson_observers = `jQuery({})`
    @_redson_attributes_namespace = nil
    reset_errors
    initialize_observable
  end
  
  def [](key)
    @_redson_state[key]
  end
    
  def []=(key, value)
    if @_redson_nested_keys.include?(key) 
      keys = @_redson_nested_keys[key]
      @_redson_state[keys[0]] ||= {}
      @_redson_state[keys[0]][keys[1]] = value
    elsif `/\[/.test(#{key})`
      keys = parse_keys(key)
      @_redson_attributes_namespace = keys[0]
      @_redson_nested_keys[key] = keys
      @_redson_state[keys[0]] ||= {}
      @_redson_state[keys[0]][keys[1]] = value
    else
      @_redson_state[key] = value
    end
  end
  
  def attributes_namespace
    @_redson_attributes_namespace
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
  
  def api_path
    @_redson_api_path
  end
  
  def api_path=(path) 
    @_redson_api_path = path.end_with?(".json") ? path : "#{path}.json"
  end
  
  def save
    raise Redson::Error::ModelApiPathNotSetError.new(self) unless api_path
    if self['_method'] == 'patch'
      HTTP.put(api_path, :payload => @_redson_state) { |response| process_response(response) }
    else
      HTTP.post(api_path, :payload => @_redson_state) { |response| process_response(response) }
    end
  end
  
  def process_response(response)
    if response.status_code == 201
      reset_errors
      Redson.l.d "Model successfully created"
      notify_observers(:created, nil, :location => response.get_header('location'))
    elsif response.status_code == 200
      reset_errors
      Redson.l.d "Model successfully updated"
      notify_observers(:updated)
    elsif response.status_code == 422
      @_redson_server_validation_errors = response.json
      Redson.l.d "Model failed with #{@_redson_server_validation_errors.inspect}"
      notify_observers(:unprocessable_entity)
    else
      Redson.l.e "HTTP Unhandled Response Status #{response.status_code}, expected 200, 201 or 422"
    end
  end
  
  def parse_keys(nested_key)
    nested_key.split(/\]\[|\[|\]/)
  end
  
  def inspect
    "#{super}\napi_path: #{api_path}\nattributes:\n#{@_redson_state.inspect}\nerrors:\n#{errors.inspect}"
  end
end