module Redson
  module Error
    class NotADomElementError < StandardError
      def initialize(thing)
        super("Expected a jQuery DOM element, got #{thing} instead")
      end
    end
  end
end