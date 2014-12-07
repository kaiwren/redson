module Redson
  module Observable
    def self.scoped_event_name(event_name)
      "redson.#{event_name}"
    end
    
    def initialize_observable
      `this._redson_observers = jQuery({})`
      @_redson_cached_observer_names = {}
    end
    
    def registerObserver(js_observer_hash, js_options_hash)
      observer = Redson.js_object_to_rb_hash(js_observer_hash)
      options = Redson.js_object_to_rb_hash(js_options_hash)
      wrapper = Redson::AccessoriedHash.new(observer)
      register_observer(wrapper, options)
    end
    
    def register_observer(observer, options = {})
      event_name = options[:on]
      handler_method_name = options[:notify]
      handler_method_name = handler_method_name ? "#{handler_method_name}" : generate_default_handler_name_for(event_name)
      handler_method_name = "$#{handler_method_name}"
      scoped_event_name = Observable.scoped_event_name(event_name)
      
      Redson.l.d "Observer #{observer} registering for '#{event_name}' on #{self}"
      %x{
        if(observer[handler_method_name] === undefined){
          Opal.Redson.$l().$e("Observer " + observer + " has no handler with name " + handler_method_name);
        }else if(typeof observer[handler_method_name] !== 'function') {
          Opal.Redson.$l().$e(handler_method_name + " on Observer " + observer + " is not a function and can't be used as an event handler'");
        }
        
        self._redson_observers.on(scoped_event_name, function(event) {
          Opal.Redson.$l().$d("Dispatching '" + scoped_event_name + "' from " + self.toString() + "' to " + observer.toString());
          observer[handler_method_name](event);
        });
      }
      self
    end

    def notify_observers(event_name)
      scoped_event_name = Observable.scoped_event_name(event_name)
      Redson.l.d "Event '#{event_name}' raised by #{self}"
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