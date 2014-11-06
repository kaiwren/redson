module Redson
  class Binding
    def initialize(element_matcher, options)
      @element_matcher = element_matcher
      @options = options
      @options[:update_on] ||= 'keyup'
      validate!
    end
    
    def element_matcher
      @element_matcher
    end
    
    def update_on
      @options[:update_on]
    end
    
    def to
      @options[:to]
    end
    
    def notify
      @options[:notify]
    end
    
    def validate!
      raise ":to missing when setting up binding for #{element_matcher}" unless to
    end
    
    def create_for(widget)
      widget.bind(element_matcher, to, update_on, notify)
    end
  end
end