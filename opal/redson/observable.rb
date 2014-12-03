module Redson
  module Observable
    def self.scoped_event_name(event_name)
      "redson.#{event_name}"
    end
    
    def initialize_observable
      `this._redson_observers = jQuery({})`
      @_redson_cached_observer_names = {}
    end

    def register_observer(observer, options = {})
      event_name = options[:on]
      handler_method_name = options[:notify]
      handler_method_name = handler_method_name ? "#{handler_method_name}" : generate_default_handler_name_for(event_name)
      handler_method_name = "$#{handler_method_name}"
      scoped_event_name = Observable.scoped_event_name(event_name)
      `this._redson_observers.on(scoped_event_name, jQuery.proxy(observer[handler_method_name], observer))`
      self
    end

    def notify_observers(event_name)
      scoped_event_name = Observable.scoped_event_name(event_name)
      `this._redson_observers.trigger(scoped_event_name)`
      self
    end

    def generate_default_handler_name_for(event_name)
      if @_redson_cached_observer_names[event_name]
        @_redson_cached_observer_names[event_name]
      else
        underscored_class_name = self.class.name.split("::").last.scan(/[A-Z][a-z]*/).join("_").downcase
        default_handler_name = "#{underscored_class_name}_#{event_name}_handler"
        @_redson_cached_observer_names[event_name] = default_handler_name
      end
    end
  end
end