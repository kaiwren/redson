module Redson
  module Error
    class TemplateMethodNotOverridenError < StandardError
      def initialize(subclass, method_name)
        super
        @method_name = method_name
        @subclass_name = subclass.class.name
      end
      
      def message
        "#{@method_name} not overriden in #{@subclass_name}"
      end
    end
  end
end