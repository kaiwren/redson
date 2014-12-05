module Redson
  module Error
    class NotADomElementError < StandardError
      def initialize(thing)
        super
        @thing = thing.to_s
      end
      
      def message
        "Expected a jQuery DOM element, got #{@thing} instead"
      end
    end
  end
end