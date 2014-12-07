module Redson
  class Event
    attr_reader :name, :source, :attributes, :parent_event
    def initialize(event_name, source = nil, parent_event = nil, attributes = nil)
      @name = event_name
      @source = source
      @attributes = attributes || {}
      @parent_event = parent_event || NullEvent.new
      %x{
        self.location = self.$location;
      }
    end
    
    def scoped_event_name
      "redson.#{@name}"
    end
    
    def get_attribute(key)
      @attributes[key] || @parent_event.get_attribute(key)
    end
    
    def location
      get_attribute(:location)
    end
    
    def status_code
      get_attribute(:status_code)
    end
    
    def inspect
      "#{super} #{@name} #{@source} #{@attributes.inspect} \n #{@parent_event.inspect}"
    end
  end
  
  class NullEvent
    attr_reader :source, :parent_event
    def attributes; {}; end
    def name;"null-event";end
    def scoped_event_name; "null-event-something-may-be-wrong";end
    def get_attribute(key);end
    def location(key);end
    def status_code(key);end
  end
end