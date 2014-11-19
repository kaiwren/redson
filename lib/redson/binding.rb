module Redson
  class Binding
    def initialize(element_matcher, options)
      @element_matcher = element_matcher
      @options = options
      @options[:notify_on] ||= 'keyup'
      validate!
    end
    
    def element_matcher
      @element_matcher
    end
    
    def notify_on
      @options[:notify_on]
    end
    
    def to
      @options[:to]
    end
    
    def notification_handler
      @options[:notification_handler]
    end
    
    def validate!
      raise ":to missing when setting up binding for #{element_matcher}" unless to
    end
    
    def create_for(widget)
      widget.bind(element_matcher, to, notify_on, notification_handler)
    end
  end
end