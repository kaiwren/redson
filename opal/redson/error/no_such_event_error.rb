module Redson
  module Error
    class NoSuchEventError < StandardError
      def initialize(event_name)
        super("No such event is emitted: #{event_name}")
      end
    end
  end
end