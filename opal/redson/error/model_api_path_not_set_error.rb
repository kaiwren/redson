module Redson
  module Error
    class ModelApiPathNotSetError < StandardError
      def initialize(model)
        super("api_path is not set for #{model.class.name}")
      end
    end
  end
end