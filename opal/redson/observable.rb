module Redson
  module Observable
    def initialize_observable
      `this._redson_observers = jQuery({})`
    end
    
    def self.scoped_event_name(event_name)
      "redson.#{event_name}"
    end
    
    def register_observer(observer, options = {})
      event_name = options[:on]
      handler_method_name = options[:notify]
      handler_method_name = handler_method_name ? "#{handler_method_name}" : generate_default_handler_name_for(event_name)
      handler_method_name = "$#{handler_method_name}"
      scoped_event_name = Observable.scoped_event_name(event_name)
      `this._redson_observers.on(scoped_event_name, observer[handler_method_name])`
      self
    end
    
    def notify_observers(event_name)
      scoped_event_name = Observable.scoped_event_name(event_name)
      `this._redson_observers.trigger(scoped_event_name)`
      self
    end
    
    def generate_default_handler_name_for(event_name)
      underscored_class_name = self.class.name.split("::").last.scan(/[A-Z][a-z]*/).join("_").downcase
      @_redson_cached_observer_name ||= "#{underscored_class_name}_#{event_name}_handler"
    end
  end
end