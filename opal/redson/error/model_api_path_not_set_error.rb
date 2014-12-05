module Redson
  module Error
    class ModelApiPathNotSetError < StandardError
      def initialize(model)
        super
        @model_class_name = model.class.name
      end
      
      def message
        "#{super} | api_path is not set for #{@model_class_name}"
      end
    end
  end
end