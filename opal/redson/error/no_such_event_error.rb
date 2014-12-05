module Redson
  module Error
    class NoSuchEventError < StandardError
      def initialize(event_name)
        super
        @event_name = event_name
      end
      
      def message
        "No such event is emitted: #{@event_name}"
      end
    end
  end
end